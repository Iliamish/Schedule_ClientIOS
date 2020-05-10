//
//  EnterViewController.swift
//  schedule4unn
//
//  Created by Илья on 02.05.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import UIKit

class EnterViewController: UIViewController {
    let networkService = NetworkService()
    private var timer:Timer?
    var groupsResponse:[SearchResponse?] = []
    var scheduleInfo:SearchResponse?=nil
    var textFildString:String?=nil
    var id:Int?=nil
    var type:Int?=nil
    var textDetail:String?=nil
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var load: UIActivityIndicatorView!
    @IBOutlet weak var tableGroups: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Авторизация"
        button.layer.cornerRadius = 8
        setupTableView()
        tableGroups.isHidden = true
        self.button.isEnabled = false
    }
    
    private func setupTableView()
    {
        tableGroups.delegate = self
        tableGroups.dataSource = self
        tableGroups.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableGroups.rowHeight = 60
        text.delegate = self
    }

    @IBAction func changeText(_ sender: UITextField) {
        self.textFildString=sender.text
        if ((sender.text?.count ?? 0)>0){
            tableGroups.isHidden = false
        }
        else{
            tableGroups.isHidden = true
        }
        load.startAnimating()
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
                                            self.load.stopAnimating()
                                        }
            })
           
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func pushButton(_ sender: UIButton) {
        UserDefaults.standard.set(text.text, forKey: "groupKey")
        UserDefaults.standard.set(textDetail, forKey: "groupDetailKey")
        UserDefaults.standard.set(id, forKey: "idKey")
        UserDefaults.standard.set(type, forKey: "typeKey")
        UserDefaults.standard.set(true, forKey: "logged in")
        UserDefaults.standard.synchronize()
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
}

extension EnterViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableGroups.dequeueReusableCell(withIdentifier: "searchcell", for: indexPath) as? EnterTableViewCell
        cell?.title.text = groupsResponse[indexPath.row]!.Name
        cell?.info.text = groupsResponse[indexPath.row]!.info[0]
        return cell ?? UITableViewCell()
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
        self.tableGroups.isHidden = true
        self.button.isEnabled = true
    }
}
