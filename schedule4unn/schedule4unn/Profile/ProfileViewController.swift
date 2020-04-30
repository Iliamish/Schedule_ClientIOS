//
//  ProfileViewController.swift
//  schedule4unn
//
//  Created by Илья on 12.04.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let profileTableViewController = ProfileTableViewController()
    let networkService = NetworkService()
    private var timer:Timer?
    var groupsResponse:[SearchResponse?] = []
    var scheduleInfo:SearchResponse?=nil
    var textFildString:String?=nil
    var id:Int?=nil
    var type:Int?=nil
    var textDetail:String?=nil
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var tableGroups: UITableView!
    
    @IBOutlet weak var text: UITextField!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        self.button.isEnabled = false
        setupTableView()
    }
    
    private func setupTableView()
    {
        tableGroups.delegate = self
        tableGroups.dataSource = self
        tableGroups.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableGroups.rowHeight = 100
    }
    
    @IBAction func changeText(_ sender: UITextField) {
        self.textFildString=sender.text
        let txtAppend = textFildString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let urlString = "http://95.79.92.107:8080/unnApp_war_exploded/objects?Name=\(txtAppend ?? "0")"
        if (textFildString?.count ?? 0)>3{
            timer?.invalidate()
            timer=Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false,
            block:{ (_) in
              self.networkService.requestSearch(urlString: urlString) { (groupResponse, error) in
              self.groupsResponse = groupResponse
                self.button.isEnabled = false
              self.tableGroups.reloadData()
               
                  }
              })
          }
    
    }
    @IBAction func pushButton(_ sender: UIButton) {
        //self.profileTableViewController.labelGroup?.text = text.text
        //self.profileTableViewController.labelGroupInfo?.text = textDetail
        
       
        let newVC = storyboard?.instantiateViewController(withIdentifier: "ProfileTableViewController") as! ProfileTableViewController
        //UserDefaults.standard.set(scheduleInfo, forKey: "scheduleInfo")
        UserDefaults.standard.set(text.text, forKey: "groupKey")
        UserDefaults.standard.set(textDetail, forKey: "groupDetailKey")
        UserDefaults.standard.set(id, forKey: "idKey")
        UserDefaults.standard.set(type, forKey: "typeKey")
        UserDefaults.standard.synchronize()
        newVC.textFromVC? = text.text!
        newVC.textFromVC2? = textDetail!
        navigationController?.popToRootViewController(animated: true)
    }
    

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableGroups.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let str = groupsResponse[indexPath.row]!.Name
       // print(groupsResponse[indexPath.row]!.gName)
        cell.textLabel?.textColor = UIColor(red: 0, green: 0, blue: 200, alpha: 100)
        cell.textLabel?.text=str
        let str1 = groupsResponse[indexPath.row]!.info[0]
        cell.detailTextLabel?.text = str1
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return groupsResponse.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.scheduleInfo = groupsResponse[indexPath.row]
        self.text.text = groupsResponse[indexPath.row]!.Name
        self.textDetail = groupsResponse[indexPath.row]!.info[0]
        self.id = groupsResponse[indexPath.row]!.unnid
        self.type = groupsResponse[indexPath.row]!.type
        self.button.isEnabled = true
    }
}
