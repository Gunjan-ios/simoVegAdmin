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

        setOutlineColor(UIColor.white, for: MDCTextControlState.normal)
        label.textColor = UIColor.white
        textColor = .white
        setOutlineColor(.white, for:.normal)
        setOutlineColor(.white, for:.editing)
        label.textColor = UIColor.white
        setTextColor(.white, for: .normal)
        setTextColor(.white, for: .editing)
        setFloatingLabelColor(.white, for: .normal)
        setFloatingLabelColor(.white, for: .editing)
        
        placeholder = pPlaceHolder
        label.text = PInfoText
        
        let imgView = UIImageView (frame: CGRect (x: 5, y: 15 , width: labelHeight, height: labelHeight))
        imgView.image = UIImage (named: pImageName)
        self.addSubview(imgView)
        }

    //  Padding x
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        // let newCGRect = bounds.inset(by: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0))
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0))
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0))
    }
    }
//}
