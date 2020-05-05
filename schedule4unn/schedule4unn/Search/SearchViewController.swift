//
//  SearchViewController.swift
//  schedule4unn


import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableSearch: UITableView!
    @IBOutlet weak var label: UILabel!
    
    let networkService = NetworkService()
    private var timer:Timer?
    var searchResponse:[SearchResponse?]=[]
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        setupSearchBar()
        setupTableView()
        tableSearch.isHidden = true
    }
    
    private func setupSearchBar()
    {
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate=self
       
    }
    
    private func setupTableView()
    {
        tableSearch.delegate = self
        tableSearch.dataSource=self
        tableSearch.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableSearch.rowHeight = 80
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableSearch.dequeueReusableCell(withIdentifier: "scell", for: indexPath) as? SearchTableViewCell
        cell?.title.text = searchResponse[indexPath.row]?.Name
        cell?.info.text = searchResponse[indexPath.row]?.info[0]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return searchResponse.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Schedule", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "ScheduleViewController") as? ScheduleViewController
        newVC?.type = searchResponse[indexPath.row]!.type
        newVC?.idd = searchResponse[indexPath.row]!.unnid
        newVC?.navigationItem.title = searchResponse[indexPath.row]!.Name
        navigationController?.pushViewController(newVC!, animated: true)
    }
}

extension SearchViewController:UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if (searchText.count>0){
            tableSearch.isHidden = false
            label.isHidden = true
        }
        let txtAppend = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlString = "http://95.79.92.107:8080/unnApp_war_exploded/objects?Name=\(txtAppend ?? "0")"
        if searchText.count>3 {
          timer?.invalidate()
          timer=Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false,
            block:{ (_) in
              self.networkService.requestSearch(urlString: urlString) { (scheduleResponse, error) in
              self.searchResponse = scheduleResponse
              self.tableSearch.reloadData()
                                        
            }
          })
        }
    }
}
