//
//  ScheduleCollectionViewCell.swift
//  schedule4unn
//
//  Created by Илья on 25.04.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import UIKit

class ScheduleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var textDate: UILabel!
    
    var scheduleInfo:ScheduleDateCell?
    
    func setCharacterSpacig(string:String) -> NSMutableAttributedString {
        
        let attributedStr = NSMutableAttributedString(string: string)
        attributedStr.addAttribute(NSAttributedString.Key.kern, value: 0.65, range: NSMakeRange(0, attributedStr.length))
        return attributedStr
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
       table?.delegate = self
       table?.dataSource = self
        table?.rowHeight = 113
    }
    
    func reloadTable() -> () {
        self.table.reloadData()
    }
   
    }



extension ScheduleCollectionViewCell: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scheduleInfo?.lessons.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as? ScheduleTableViewCell
        cell?.isMultipleTouchEnabled = false
       print(label.font.fontName)
        if (scheduleInfo != nil){
            if ((scheduleInfo?.lessons.count ?? 0)>0){
                cell?.end.attributedText = setCharacterSpacig(string: scheduleInfo?.lessons[indexPath.row].end ?? "text")
        cell?.info?.attributedText = setCharacterSpacig(string: scheduleInfo?.lessons[indexPath.row].info ?? "text")
        cell?.start?.attributedText = setCharacterSpacig(string: scheduleInfo?.lessons[indexPath.row].start ?? "text")
        cell?.name?.attributedText = setCharacterSpacig(string: scheduleInfo?.lessons[indexPath.row].name ?? "text")
        cell?.name2?.attributedText = setCharacterSpacig(string: scheduleInfo?.lessons[indexPath.row].name2 ?? "text")
        cell?.type?.attributedText = setCharacterSpacig(string: scheduleInfo?.lessons[indexPath.row].type ?? "text")
                 cell?.setColors()
            }
        }
        return cell ?? UITableViewCell()
    }
    
    
}
