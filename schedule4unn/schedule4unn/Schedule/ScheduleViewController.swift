//
//  ScheduleViewController.swift
//  schedule4unn


import UIKit


class ScheduleViewController: UIViewController {
   
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var error: UILabel!
    @IBOutlet var viewVC: UIView!
    let networkService = NetworkService()
    var sscheduleResponse: [ScheduleResponse?] = []
    var urlString:String = ""
    let date = Date()
    let calendar = Calendar.current
    var schedule: [ScheduleDateCell] = []
    var scheduleInfo:[ScheduleTableCell?]?
    var type = UserDefaults.standard.integer(forKey: "typeKey")
    var idd = UserDefaults.standard.integer(forKey: "idKey")
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        setupCollectionView()
        collectionView.isHidden = true
        if navigationItem.title == "25 april" {
       setNavBarTitle()
        }
        collectionView.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        viewVC.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
     
        
        let dateEnd = calendar.date(byAdding: .day, value: 7, to: date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let strDate = formatter.string(from: date)
        
        let txtDate = strDate.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let strDate1 = formatter.string(from: dateEnd!)
        let txtDate1 = strDate1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let typeStr = String(type)
        
        let id = String(idd)
        
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
          
            if (error != nil){
                self.error.isHidden = false
            }
            else {
                self.sscheduleResponse = scheduleResponse
                self.separateSchedule()
                self.collectionView.reloadData()
                self.collectionView.isHidden = false
            }
            
        }
        
        
    }
    
    func setNavBarTitle(){
        let formatter4Title = DateFormatter()
        formatter4Title.dateFormat = "MM"
        let month = formatter4Title.string(from: date)
        let monthStr:String
        formatter4Title.dateFormat = "dd"
        var day = formatter4Title.string(from: date)
        switch month {
        case "01":
            monthStr = "Января"
        case "02":
            monthStr = "Февраля"
        case "03":
            monthStr = "Марта"
        case "04":
            monthStr = "Апреля"
        case "05":
            monthStr = "Мая"
        case "06":
            monthStr = "Июня"
        case "07":
            monthStr = "Июля"
        case "08":
            monthStr = "Августа"
        case "09":
            monthStr = "Сентября"
        case "10":
            monthStr = "Октября"
        case "11":
            monthStr = "Ноября"
        case "12":
            monthStr = "Декабря"
        default:
            monthStr = ""
            print(month)
        }
        if day[day.startIndex] == "0"{
            day.remove(at: day.startIndex)
        }
        self.navigationItem.title = day + " " + monthStr
    }
    
    
    
    private func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
       
    }

  
    
   
   
    private func separateSchedule(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        var dateSch = date
        let dateSchEnd = calendar.date(byAdding: .day, value: 7, to: date)
        while (formatter.string(from: dateSch) != formatter.string(from: dateSchEnd!)) {
            var info:ScheduleDateCell = ScheduleDateCell(lessons: [], date: "", noClasses: "")
            for item in sscheduleResponse{
                
                
                if item?.date ==  formatter.string(from: dateSch) {
                    var lesson = ScheduleTableCell()
                    lesson.start = item?.beginLesson
                    lesson.name = item?.discipline
                    lesson.name2 = item?.lecturer
                    lesson.type = item?.kindOfWork
                    lesson.end = item?.endLesson
                    lesson.info = (item?.building ?? "default") + ", " + (item?.auditorium)!
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

extension ScheduleViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "schedulecell", for: indexPath) as? ScheduleCollectionViewCell
        if (schedule.count > 0){
            cell?.textDate.attributedText = cell?.setCharacterSpacig(string: schedule[indexPath.row].date ?? "label")
            
            if ((schedule[indexPath.row].lessons.count) > 0){
                cell?.scheduleInfo = schedule[indexPath.row]
                cell?.reloadTable()
               
            }
            else{
               
                cell?.label.isHidden = false
                cell?.label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
                cell?.label.attributedText = cell?.setCharacterSpacig(string: "Нет занятий")
                cell?.table.isHidden = true
                cell?.view.isHidden = true
            }
            
            
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = self.view.frame.width
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "schedulecell", for: indexPath) as? ScheduleCollectionViewCell
        if (schedule.count > 0){
            if ((schedule[indexPath.row].lessons.count) > 0){
        let h = ((cell?.table.rowHeight ?? 113) * CGFloat(schedule[indexPath.row].lessons.count)) + 25
                return CGSize(width: w, height: h)
            }
            
        }
        return CGSize(width: w, height: 113)
    }
}
