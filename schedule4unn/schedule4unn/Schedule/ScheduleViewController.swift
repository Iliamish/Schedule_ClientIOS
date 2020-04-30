//
//  ScheduleViewController.swift
//  schedule4unn
//
//  Created by Илья on 06.04.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
   
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet var viewVC: UIView!
    let networkService = NetworkService()
    var sscheduleResponse: [ScheduleResponse?] = []
    var urlString:String = ""
    let date = Date()
    let calendar = Calendar.current
    var schedule: [ScheduleDateCell] = []//[[ScheduleTableCell]] = []
     var scheduleInfo:[ScheduleTableCell?]?
    //var type:Int?
    
    var type = UserDefaults.standard.integer(forKey: "typeKey")//scheduleInfo.type
    var idd = UserDefaults.standard.integer(forKey: "idKey")
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupTableView()
        setupCollectionView()
       
        collectionView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        viewVC.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
     
        
        let dateEnd = calendar.date(byAdding: .day, value: 7, to: date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let strDate = formatter.string(from: date)
        let txtDate = strDate.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let strDate1 = formatter.string(from: dateEnd!)
        let txtDate1 = strDate1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        //if (UserDefaults.standard.object(forKey: "scheduleInfo") != nil){
        //let scheduleInfo:SearchResponse = UserDefaults.standard.object(forKey: "scheduleInfo") as! SearchResponse
        
        let typeStr = String(type)
        
        let id = String(idd)
        //let idStr = String(id)
        let txtAppend = typeStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let txtAppend1 = id.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        switch type {
            
        case 0:
            urlString = "https://journal.unn.ru/schedule.php?lessons?fromdate=\(txtDate ?? "2020.01.01")&todate=\(txtDate1 ?? "2020.01.02")&recieverType=\(txtAppend ?? "0")&studentoid=\(txtAppend1 ?? "0")"
        case 1:
            urlString = "https://journal.unn.ru/schedule.php?lessons?fromdate=\(txtDate ?? "2020.01.01")&todate=\(txtDate1 ?? "2020.01.02")&recieverType=\(txtAppend ?? "0")&lectureroid=\(txtAppend1 ?? "0")"
        case 3:
            urlString = "https://journal.unn.ru/schedule.php?lessons?fromdate=\(txtDate ?? "2020.01.01")&todate=\(txtDate1 ?? "2020.01.02")&recieverType=\(txtAppend ?? "0")&groupoid=\(txtAppend1 ?? "0")"
        default:
            print(";(")
        }
        networkService.request(urlString: urlString) { (scheduleResponse, error) in
            self.sscheduleResponse = scheduleResponse
           // self.table.reloadData()
            self.separateSchedule()
            self.collectionView.reloadData()
            
        }
        //separateSchedule()
       //}
        self.navigationItem.title = UserDefaults.standard.string(forKey: "groupKey")
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 10)
        self.navigationItem.titleView?.frame = frame
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        /*let urlString = "https://journal.unn.ru/schedule.php?lessons?fromdate=2020.03.09&todate=2020.03.29&recieverType=1&lectureroid=24579"
        
        networkService.request(urlString: urlString) { (scheduleResponse, error) in
            self.sscheduleResponse = scheduleResponse
            self.table.reloadData()
        }
 */
    }
    
    private func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        //collectionView.register(ScheduleCollectionViewCell.self, forCellWithReuseIdentifier: "schedulecell")
    }

  /*  private func setupTableView()
    {
        table.delegate = self
        table.dataSource=self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = 100
    }*/
   
    private func separateSchedule(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        var dateSch = date
        let dateSchEnd = calendar.date(byAdding: .day, value: 7, to: date)
        while (formatter.string(from: dateSch) != formatter.string(from: dateSchEnd!)) {
            var info:ScheduleDateCell = ScheduleDateCell(lessons: [], date: "", noClasses: "") //[ScheduleTableCell] = []
            for item in sscheduleResponse{
                
                
                if item?.date ==  formatter.string(from: dateSch) {
                    var lesson = ScheduleTableCell()
                    lesson.start = item?.beginLesson
                    lesson.name = item?.discipline
                    lesson.name2 = item?.lecturer
                    lesson.type = item?.kindOfWork
                    lesson.end = item?.endLesson
                    lesson.info = item?.auditorium
                    info.lessons.append(lesson)
                }
                
                
            }
            if (info.lessons.count==0){
                info.noClasses = "No classes"
            }
            
            info.date = formatter.string(from: dateSch)
            schedule.append(info)
            dateSch = calendar.date(byAdding: .day, value: 1, to: dateSch) ?? date
    }
}
}
/*extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ScheduleTableViewCell
        cell?.end.text = scheduleInfo?[indexPath.row]?.end
        cell?.info.text = scheduleInfo?[indexPath.row]?.info
        cell?.start.text = scheduleInfo?[indexPath.row]?.start
        cell?.name.text = scheduleInfo?[indexPath.row]?.name
        cell?.name2.text = scheduleInfo?[indexPath.row]?.name2
        cell?.type.text = scheduleInfo?[indexPath.row]?.type
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return sscheduleResponse.count
    }
}*/

extension ScheduleViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "schedulecell", for: indexPath) as? ScheduleCollectionViewCell
        if (schedule.count > 0){
            if ((schedule[indexPath.row].lessons.count) > 0){
                
                cell?.scheduleInfo = schedule[indexPath.row]
                cell?.reloadTable()
                //scheduleInfo = schedule[indexPath.row]
                //cell?.textDate.textColor = UIColor(red: 125, green: 125, blue: 125, alpha: 1)
                cell?.textDate?.text = schedule[indexPath.row].date
                
               
            }
            else{
               
                cell?.label.isHidden = false
                cell?.label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                cell?.label.text = "No classes"
                 //cell?.label.characterSpacing = 5
                let x = cell?.setCharacterSpacig(string: schedule[indexPath.row].date ?? "label")
                cell?.textDate.text = x?.string
                cell?.table.isHidden = true
                cell?.view.isHidden = true
              // cell?.textDate?.text = schedule[indexPath.row].date
            }
            
            
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = self.view.frame.width
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "schedulecell", for: indexPath) as? ScheduleCollectionViewCell
        if (schedule.count > 0){
            if ((schedule[indexPath.row].lessons.count) > 0){
        let h = ((cell?.table.rowHeight ?? 110) * CGFloat(schedule[indexPath.row].lessons.count)) + 23
                return CGSize(width: w, height: h)
            }
            
        }
        return CGSize(width: w, height: 110)
    }
}
