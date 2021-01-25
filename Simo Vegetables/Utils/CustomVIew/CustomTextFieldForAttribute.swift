//
//  CustomTextField.swift
//  TestSpatialite
//
//  Created by Gaurav on 07/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit

class CustomTextFieldForAttribute: UITextField {
    
    var imgIcon:UIImageView!
    let padding: CGFloat = 30
    var boxBorderColor = UIColor.lightGray.cgColor

    override init(frame: CGRect) {
        super.init(frame: frame)
        imgIcon = UIImageView(frame: CGRect(x: 0, y: 5, width: 30, height: 30))
        imgIcon.image = UIImage(systemName: "calendar")
        self.imgIcon.contentMode = .center
        self.addSubview(imgIcon)

//        let border = CALayer()
//        let lineWidth = CGFloat(1)
//        border.borderColor = textFieldTextColor.cgColor
//        border.frame = CGRect(x: 0, y: frame.size.height - lineWidth, width:  frame.size.width, height: frame.size.height)
//        border.borderWidth = lineWidth
//        layer.addSublayer(border)
//        layer.masksToBounds = true

        self.backgroundColor = .systemGray6
        self.font = UIFont(name: TAB_FONT, size: SHARE_BUTTON_FONT_SIZE)
        self.textAlignment = .left
        self.textColor = UIColor.black
      
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //  Padding x
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        // let newCGRect = bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 0))
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 0))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 0))
    }
    
   
}
//
