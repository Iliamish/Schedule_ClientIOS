//
//  ScheduleResponse.swift
//  schedule4unn
//
//  Created by Илья on 08.04.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import Foundation

struct ScheduleResponse:Decodable
{
    var date:String 
    var dayOfWeek:Int
    var beginLesson:String
    var endLesson:String
    var discipline:String
    var building:String
    var auditorium:String
    var lecturer:String
    var kindOfWork:String
}

struct GroupsResponse:Decodable
{
    var gName:String
    var info:String
}

struct SearchResponse:Decodable  {
    var type:Int
    var Name:String
    var unnid:Int
    var info:[String]
}
