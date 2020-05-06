//
//  NetworkService.swift
//  schedule4unn
//
//  Created by Илья on 12.04.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import Foundation

class NetworkService
{
    func request(urlString:String, completion: @escaping ([ScheduleResponse?], Error?) -> Void)
    {
        let openUrl = NSURL(string: urlString)
        URLSession.shared.dataTask(with: openUrl! as URL){ (data,response,error) in
            DispatchQueue.main.async {
                if let error = error
                {
                    print("Some error")
                    completion([], error)
                    print(error)
                    return
                }
                guard let data = data else {return}
                do{
                    let schedule = try JSONDecoder().decode([ScheduleResponse].self, from: data)
                    completion(schedule,nil)
                } catch let jsonError {
                    print("Fail", jsonError)
                    completion([],jsonError)
                }
            }
            }.resume()
    }
    
    func request1(urlString:String, completion: @escaping ([GroupsResponse?], Error?) -> Void)
    {
         let openUrl = NSURL(string: urlString)
        //guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: openUrl! as URL){ (data,response,error) in
            DispatchQueue.main.async {
                if let error = error
                {
                    print("Some error")
                    completion([], error)
                    return
                }
                guard let data = data else {return}
                do{
                    let schedule = try JSONDecoder().decode([GroupsResponse].self, from: data)
                    completion(schedule,nil)
                } catch let jsonError {
                    print("Fail", jsonError)
                    completion([],jsonError)
                }
            }
            }.resume()
    }
    
    func requestSearch(urlString:String, completion: @escaping ([SearchResponse?], Error?) -> Void)
    {
        let openUrl = NSURL(string: urlString)
        URLSession.shared.dataTask(with: openUrl! as URL){ (data,response,error) in
            DispatchQueue.main.async {
                if let error = error
                {
                    print("Some error")
                    completion([], error)
                    return
                }
                guard let data = data else {return}
                do{
                    let schedule = try JSONDecoder().decode([SearchResponse].self, from: data)
                    completion(schedule,nil)
                } catch let jsonError {
                    print("Fail", jsonError)
                    completion([],jsonError)
                }
            }
            }.resume()
    }
}
