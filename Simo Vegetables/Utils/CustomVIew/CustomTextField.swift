//
//  CustomTextField.swift
//  TestSpatialite
//
//  Created by Gaurav on 07/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects


class MyTextfiled: AkiraTextField {
    
    override func awakeFromNib(){
        borderStyle  = .none
        textColor = UIColor.black
        placeholderColor = UIColor .gray
        placeholderFontScale = 0.9
        self.font = UIFont(name: APP_FONT_NAME, size: NAV_HEADER_FONT_SIZE)
    }
}

class CountryTextfiled: MadokaTextField {
    
    let padding: CGFloat =  8
    let rightPadding: CGFloat = CGFloat(8)
    
    override func awakeFromNib(){
        borderColor = UIColor .clear
        textColor = UIColor.white
        placeholderColor = UIColor .gray
        placeholderFontScale = 1
        let border = CALayer()
        let lineWidth = CGFloat(1)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 55, y: self.frame.size.height - lineWidth*2, width: self.bounds.width, height: lineWidth)
        border.borderWidth = 50.0
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
 
    
    //  Padding x
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        // let newCGRect = bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: rightPadding))
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: rightPadding))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: rightPadding))
    }
    
    
    
}
class OrderTextfiled: UITextField {
    
    let padding: CGFloat = 4
    let rightPadding: CGFloat = CGFloat(4)


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor =  UIColor.lightGray.cgColor
        self.font = UIFont(name: APP_FONT_NAME, size: TEXTFIELD_FONT_SIZE)
        self.textColor = .white
        
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  Padding x
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        // let newCGRect = bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: rightPadding))
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: rightPadding))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: rightPadding))
    }
    
}


class CustomTextField : UITextField {
    
    let padding: CGFloat = 45
    var boxBorderColor = UIColor.lightGray.cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.backgroundColor = UIColor.init(white: 0.6, alpha: 1)
        self.font = UIFont(name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
        self.textColor = .white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    //  Padding x
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 0))
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 0))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 0))
    }
    
}
class ContactUSTextField : UITextField {
    
    let padding: CGFloat = 45
    var boxBorderColor = UIColor.white.cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = colorPrimary
        self.font = UIFont(name: TAB_FONT, size: TEXTFIELD_FONT_SIZE)
        self.textColor = .white
        self.leftViewMode = .always
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = UIColor.white.cgColor

    }
    
    
    func initDesign(placeHolder:String,imgName:String) {
        self.placeholder = placeHolder
        self.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.leftImage(UIImage (named: imgName), imageWidth: 25, padding: 12)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  Padding x
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 0))
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 0))
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: 0))
    }
    
}
