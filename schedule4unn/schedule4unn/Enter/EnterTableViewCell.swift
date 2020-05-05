//
//  SearchTableViewCell.swift
//  schedule4unn
//
//  Created by Илья on 04.05.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import UIKit

class EnterTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var info: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        attribute(label: title, size: 16, fontName: "FuturaPT-Medium")
        attribute(label: info, size: 14, fontName: "FuturaPT-Book")
    }
    func attribute(label: UILabel, size: CGFloat, fontName: String){
        let font = UIFont(name: fontName, size: size)
        let attributedText = NSMutableAttributedString(string: label.text ?? "text" , attributes: [.font: font!])
        attributedText.addAttribute(NSAttributedString.Key.kern, value: 0.65, range: NSMakeRange(0, attributedText.length))
        label.attributedText = attributedText
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
