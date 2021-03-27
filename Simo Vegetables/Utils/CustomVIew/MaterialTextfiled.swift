//
//  MaterialTextfiled.swift
//  Movie
//
//  Created by Gunjan Raval on 03/07/20.
//  Copyright © 2020 Gunjan Raval. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields


//public class MaterialTextfiled: MDCOutlinedTextField {
//
//        override open func InitDesign() {
//            setOutlineColor(UIColor.white, for: MDCTextControlState.normal)
//            label.textColor = UIColor.white
//            backgroundColor = .white
//        }
//    }

extension MDCOutlinedTextField {
    

    func InitDesign(pImageName:String,PInfoText:String,pPlaceHolder:String){
        
        let labelHeight = 25

        setOutlineColor(UIColor.black, for: MDCTextControlState.normal)
        label.textColor = UIColor.black
        textColor = .black
        setOutlineColor(.black, for:.normal)
        setOutlineColor(.black, for:.editing)
        label.textColor = UIColor.black
        setTextColor(.black, for: .normal)
        setTextColor(.black, for: .editing)
        setFloatingLabelColor(.black, for: .normal)
        setFloatingLabelColor(.black, for: .editing)

        placeholder = pPlaceHolder
        label.text = placeholder
        if PInfoText != "" {
            text = PInfoText
            placeholder = ""
        }

        let imgView = UIImageView (frame: CGRect (x: 0, y: 10 , width: labelHeight, height: labelHeight))
        imgView.image = UIImage (named: pImageName)
        imgView.setImageColor(color: colorPrimary)
        self.leftView = imgView
        self.leftViewMode = .always

        }

    //  Padding x
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 0))
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 0))
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 0))
    }
    }
//}
