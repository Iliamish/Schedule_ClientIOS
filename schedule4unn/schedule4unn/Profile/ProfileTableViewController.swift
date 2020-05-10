//
//  ProfileTableViewController.swift
//  schedule4unn

import UIKit

class ProfileTableViewController: UITableViewController {

    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var labelGroup: UILabel!
    @IBOutlet weak var labelGroupInfo: UILabel!
    
    @IBOutlet weak var logOut: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
        attribute(label: labelInfo, size: 16, fontName: "FuturaPT-Book")
        attribute(label: labelGroup, size: 18, fontName: "FuturaPT-Medium")
        attribute(label: labelGroupInfo, size: 16, fontName: "FuturaPT-Book")
       
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
        if let group = UserDefaults.standard.string(forKey: "groupKey")
        {
            labelGroup.text = group }
        else {
            labelGroup.text="Группа 1"
        }
        
        if let groupDetail = UserDefaults.standard.string(forKey: "groupDetailKey"){
            labelGroupInfo.text = groupDetail }
        else {
            labelGroupInfo.text="none"
        }
        
    }
    @IBAction func logOut(_ sender: Any) {
        AppDelegate.shared.rootViewController.switchToLogout()
    }
    
    func attribute(label: UILabel, size: CGFloat, fontName: String){
        let font = UIFont(name: fontName, size: size)
        let attributedText = NSMutableAttributedString(string: label.text ?? "text" , attributes: [.font: font!])
        attributedText.addAttribute(NSAttributedString.Key.kern, value: 0.65, range: NSMakeRange(0, attributedText.length))
        label.attributedText = attributedText
    }

   

   

}
