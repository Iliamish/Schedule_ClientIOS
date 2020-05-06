//
//  SFLabel.swift
//  schedule4unn
//
//  Created by Илья on 29.04.2020.
//  Copyright © 2020 iailil. All rights reserved.
//

import UIKit

class SFLabel: UILabel {

    @IBInspectable open var characterSpacing:CGFloat = 5 {
        didSet {
            let attributedString = NSMutableAttributedString(string: self.text!)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: self.characterSpacing, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }
        
      /*  override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
        }
        
        required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
        }
        
        private func commonInit() {
        self.font = UIFont(name: "My Font", size: self.font.pointSize)
        }*/
        
        /*override public var font: UIFont! {
        get { return super.font }
        didSet {
        super.font = UIFont(name: "SFProSisplay", size: super.font.pointSize)
        }
        }*/
    }
   
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
