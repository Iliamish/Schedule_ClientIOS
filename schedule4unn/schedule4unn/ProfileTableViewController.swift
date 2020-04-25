//
//  ProfileTableViewController.swift
//  schedule4unn
//
//  Created by Илья on 15.04.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    var textFromVC:String?=nil
    var textFromVC2:String?=nil

    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var labelGroup: UILabel!
    @IBOutlet weak var labelGroupInfo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let type = UserDefaults.standard.integer(forKey: "typeKey")
        switch type {
            
        case 0:
           labelInfo.text = "Студент"
        case 1:
           labelInfo.text = "Преподаватель"
        case 3:
            labelInfo.text = "Группа"
        default:
            labelInfo.text = ""
        }
        if let group = UserDefaults.standard.string(forKey: "groupKey")// data(forKey: "groupKey")  as String
        {
            labelGroup.text = group }
        else {
            labelGroup.text="Группа 1"
        }
        
        if let groupDetail = UserDefaults.standard.string(forKey: "groupDetailKey")// data(forKey: "groupKey")  as String
        {
            labelGroupInfo.text = groupDetail }
        else {
            labelGroupInfo.text="none"
        }
    }

   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
