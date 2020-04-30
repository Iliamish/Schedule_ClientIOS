//
//  ScheduleCollectionViewCell.swift
//  schedule4unn
//
//  Created by Илья on 25.04.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import UIKit

class ScheduleCollectionViewCell: UICollectionViewCell {
    
  
   
    @IBOutlet weak var label: SFLabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var textDate: UILabel!
    
    
    /* var scheduleInfo:ScheduleTableCell = {
        let info = ScheduleTableCell()
        return info
    }()*/
    
    var scheduleInfo:ScheduleDateCell?//[ScheduleTableCell?]?
    
    
    func setCharacterSpacig(string:String) -> NSMutableAttributedString {
        
        let attributedStr = NSMutableAttributedString(string: string)
        attributedStr.addAttribute(NSAttributedString.Key.kern, value: 5.1, range: NSMakeRange(0, attributedStr.length))
        return attributedStr
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
       table?.delegate = self
       table?.dataSource = self
        //table?.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "tablecell")
        table?.rowHeight = 110
        //let attributedString = NSMutableAttributedString(string: textDate.text ?? "")
       // attributedString.addAttribute(NSMutableAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: textDate.text?.count))
        //let attributedString = NSMutableAttributedString(string: label.text ?? "label")
       // attributedString.addAttribute(NSAttributedString.Key.kern, value:   CGFloat(1.4), range: NSRange(location: 0, length: 9))
       // label?.characterSpacing = 5
    }
    
    func reloadTable() -> () {
        self.table.reloadData()
    }
   
    }



extension ScheduleCollectionViewCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleInfo?.lessons.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as? ScheduleTableViewCell
        cell?.isMultipleTouchEnabled = false
        if (scheduleInfo != nil){
            if ((scheduleInfo?.lessons.count ?? 0)>0){
           cell?.end?.text = scheduleInfo?.lessons[indexPath.row].end
        cell?.info?.text = scheduleInfo?.lessons[indexPath.row].info
        cell?.start?.text = scheduleInfo?.lessons[indexPath.row].start
        cell?.name?.text = scheduleInfo?.lessons[indexPath.row].name
        cell?.name2?.text = scheduleInfo?.lessons[indexPath.row].name2
        cell?.type?.text = scheduleInfo?.lessons[indexPath.row].type
            }
        }
        return cell ?? UITableViewCell()
    }
    
    
}
