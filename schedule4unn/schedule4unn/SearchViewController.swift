//
//  SearchViewController.swift
//  schedule4unn
//
//  Created by Илья on 14.04.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

   
    @IBOutlet weak var tableSearch: UITableView!
    
    let networkService = NetworkService()
    private var timer:Timer?
    var searchResponse:[SearchResponse?]=[]
    let searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)

        setupSearchBar()
        setupTableView()
        // Do any additional setup after loading the view.
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
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableSearch.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let str = searchResponse[indexPath.row]
        cell.textLabel?.text = str?.Name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return searchResponse.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // UserDefaults.standard.set(searchResponse[indexPath.row]!.unnid, forKey: "unnidKey")
       // UserDefaults.standard.set(searchResponse[indexPath.row]!.type, forKey: "typeKey")
        //UserDefaults.standard.synchronize()
        let storyboard = UIStoryboard(name: "Schedule", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "ScheduleViewController") as? ScheduleViewController
        newVC?.type = searchResponse[indexPath.row]!.type
        newVC?.idd = searchResponse[indexPath.row]!.unnid
        navigationController?.pushViewController(newVC!, animated: true)
        // = searchResponse[indexPath.row]!.gName
        //self.textDetail = groupsResponse[indexPath.row]!.info
       // self.button.isEnabled = true
    }
}

extension SearchViewController:UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
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
