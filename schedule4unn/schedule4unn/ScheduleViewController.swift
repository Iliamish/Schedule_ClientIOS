//
//  ScheduleViewController.swift
//  schedule4unn
//
//  Created by Илья on 06.04.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    let networkService = NetworkService()
    var sscheduleResponse: [ScheduleResponse?] = []
    var urlString:String = ""
    
    
    //@IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
     
        let type = UserDefaults.standard.integer(forKey: "typeKey")
        let typeStr = String(type)
        let id = String(UserDefaults.standard.integer(forKey: "idKey"))
        //let idStr = String(id)
        let txtAppend = typeStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let txtAppend1 = id.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        switch type {
            
        case 0:
            urlString = "https://journal.unn.ru/schedule.php?lessons?fromdate=2020.03.09&todate=2020.03.29&recieverType=\(txtAppend ?? "0")&studentoid=\(txtAppend1 ?? "0")"
        case 1:
            urlString = "https://journal.unn.ru/schedule.php?lessons?fromdate=2020.03.09&todate=2020.03.29&recieverType=\(txtAppend ?? "0")&lectureroid=\(txtAppend1 ?? "0")"
        case 3:
            urlString = "https://journal.unn.ru/schedule.php?lessons?fromdate=2020.03.09&todate=2020.03.29&recieverType=\(txtAppend ?? "0")&groupoid=\(txtAppend1 ?? "0")"
        default:
            print(";(")
        }
        networkService.request(urlString: urlString) { (scheduleResponse, error) in
            self.sscheduleResponse = scheduleResponse
            self.table.reloadData()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        /*let urlString = "https://journal.unn.ru/schedule.php?lessons?fromdate=2020.03.09&todate=2020.03.29&recieverType=1&lectureroid=24579"
        
        networkService.request(urlString: urlString) { (scheduleResponse, error) in
            self.sscheduleResponse = scheduleResponse
            self.table.reloadData()
        }
 */
    }
    

    private func setupTableView()
    {
        table.delegate = self
        table.dataSource=self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = 100
    }
   
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //cell.textLabel?.text="123"
        let str = sscheduleResponse[indexPath.row]
        cell.textLabel?.text=(str?.beginLesson)! + " " + (str?.discipline)! + " " + (str?.auditorium)!
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return sscheduleResponse.count
    }
}
