//
//  ScheduleTableViewCell.swift
//  schedule4unn
//
//  Created by Илья on 26.04.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var end: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        type.textColor = UIColor(red: 0, green: 87, blue: 217, alpha: 1)
       // type.textColor = UIColor(red: 0, green: 87, blue: 217, alpha: 1)
        name.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        info.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        //name2.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        end.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        //start.textColor = UIColor(red: 125, green: 125, blue: 255, alpha: 1)
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
