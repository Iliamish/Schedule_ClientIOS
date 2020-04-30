//
//  ScheduleModels.swift
//  schedule4unn
//
//  Created by Илья on 25.04.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import Foundation

struct ScheduleTableCell{
    
    var start:String?
    var end:String?
    var name:String?
    var type:String?
    var name2:String?
    var info:String?
}

struct ScheduleDateCell{
    var lessons:[ScheduleTableCell]
    var date:String?
    var noClasses:String?
}
