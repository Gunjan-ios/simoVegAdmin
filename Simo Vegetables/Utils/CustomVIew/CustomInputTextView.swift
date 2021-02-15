//
//  CustomComboBoxView.swift
//  TestSpatialite
//
//  Created by Gaurav on 30/12/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects

class CustomInputTextField: UIView, UITextFieldDelegate {
    
    private var labelTitle:UILabel! = nil
    var txtField:MyTextfiled!
    var delegateAppForm:ViewController?
    var delegateApp:ViewController?


    let labelHeight = 25
    
    func initDesign(pText:String,pImageName:String,pTag:Int,pPlaceHolder:String) {
        
        let imgView = UIImageView (frame: CGRect (x: 0, y: 30, width: labelHeight, height: labelHeight))
        imgView.image = UIImage (named: pImageName)
        imgView.setImageColor(color: colorPrimary)
        self.addSubview(imgView)
        
        self.txtField = MyTextfiled(frame: CGRect(x: 30, y: 0, width: Int(frame.size.width) - 30 , height: NEXT_BUTTON_HEIGHT))
        self.txtField.awakeFromNib()
        self.txtField.text = pText
//        self.txtField.backgroundColor = .yellow
        self.txtField.delegate = self
        self.txtField.tag = pTag
        self.txtField.placeholder = pPlaceHolder
        self.addSubview(self.txtField)
        
    }
  
    
}
