//
//  ScheduleTableViewCell.swift
//  schedule4unn


import UIKit

class ScheduleTableViewCell: UITableViewCell {
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var end: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func attribute(label: UILabel, size: CGFloat, fontName: String){
        let font = UIFont(name: fontName, size: size)
        let attributedText = NSMutableAttributedString(string: label.text ?? "text" , attributes: [.font: font!])
        attributedText.addAttribute(NSAttributedString.Key.kern, value: 0.65, range: NSMakeRange(0, attributedText.length))
        label.attributedText = attributedText
    }
    
    func setColors(){
        
        attribute(label: type, size: 14, fontName: "FuturaPT-Book")
        attribute(label: name, size: 15, fontName: "FuturaPT-Medium")
        attribute(label: info, size: 14, fontName: "FuturaPT-Book")
        attribute(label: name2, size: 14, fontName: "FuturaPT-Medium")
        switch type.text {
        case "Лекция":
            type.textColor = UIColor(red: 0/255.0, green: 87/255.0, blue: 217/255.0, alpha: 1)
            colorView.backgroundColor = UIColor(red: 0/255.0, green: 87/255.0, blue: 217/255.0, alpha: 1)
            colorView.isHidden = false
        case "Практика":
            type.textColor = UIColor(red: 23/255.0, green: 185/255.0, blue: 49/255.0, alpha: 1)
            colorView.backgroundColor = UIColor(red: 23/255.0, green: 185/255.0, blue: 49/255.0, alpha: 1)
            colorView.isHidden = false
        case "Лабораторная работа":
            type.textColor = UIColor(red: 179/255.0, green: 19/255.0, blue: 205/255.0, alpha: 1)
            colorView.backgroundColor = UIColor(red: 179/255.0, green: 19/255.0, blue: 205/255.0, alpha: 1)
            colorView.isHidden = false
        default:
            print(type.text ?? "sss")
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
