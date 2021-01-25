//
//  CustomButton.swift
//  TestSpatialite
//
//  Created by Gaurav on 09/08/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import UIKit
class CustomButton : UIButton {
    
    private var shadowLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = colorPrimary
        self.contentHorizontalAlignment = .center
        setTitleColor(UIColor.white, for: .normal)
        
        // corner
        layer.cornerRadius = radius
//        self.layer.borderWidth = 1
//        self.layer.borderColor = buttonBorderColor.cgColor
        
        // title color
        
        // font
        titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: BUTTON_FONT_SIZE)
        
//         shadow
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor

            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
        }


       
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}


class whiteButton : UIButton {
    
    private var shadowLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        self.contentHorizontalAlignment = .center
        setTitleColor(UIColor.black, for: .normal)
        
        // corner
        layer.cornerRadius = radius
        
        // title color
        
        // font
        titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: BUTTON_FONT_SIZE)
        
        //         shadow
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
        }
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
class SettingButton : UIButton {
    
    private var shadowLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray6
        self.contentHorizontalAlignment = .left
        setTitleColor(.black, for: .normal)
        
        // corner
        layer.cornerRadius = radius
       
        // font
        titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: BUTTON_FONT_SIZE)
    
        self.imageEdgeInsets = UIEdgeInsets (top: 0, left: 5, bottom: 0, right: 0)
        self.titleEdgeInsets = UIEdgeInsets (top: 0, left: 15, bottom: 0, right: 0)

        //  shadow
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class ShareButton : UIButton{
    
    private var shadowLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  initDesign(pText:String,img:String,line:Bool) {

        self.setTitle(pText, for: .normal)
        self.setImage(UIImage (named: img), for: .normal)
        self.contentHorizontalAlignment = .center
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = .clear
        titleLabel?.font  = UIFont .boldSystemFont(ofSize: SHARE_BUTTON_FONT_SIZE)
        self.centerVertically(padding: 6, totalWidth: self.bounds.width)

        if line == true{
            let lblView = UIView (frame: CGRect (x: self.bounds.width, y: 0, width: 1, height: self.bounds.height))
            lblView.backgroundColor = .white
            self.addSubview(lblView)
        }
    }
}
//class favButton : FaveButton{
//    
//    private var shadowLayer: CAShapeLayer!
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func  initDesign(pText:String,img:String,line:Bool) {
//        
//        self.setTitle(pText, for: .normal)
//        self.setImage(UIImage (named: img), for: .normal)
//        self.contentHorizontalAlignment = .center
//        setTitleColor(UIColor.white, for: .normal)
//        backgroundColor = .clear
//        titleLabel?.font  = UIFont .boldSystemFont(ofSize: SHARE_BUTTON_FONT_SIZE)
//        self.centerVertically(padding: 6, totalWidth: self.bounds.width)
//        if line == true{
//            let lblView = UIView (frame: CGRect (x: self.bounds.width, y: 0, width: 1, height: self.bounds.height))
//            lblView.backgroundColor = .white
//            self.addSubview(lblView)
//        }
//    }
//}
class SmallButton : UIButton {
    
    private var shadowLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = colorPrimary
        self.contentHorizontalAlignment = .center
        setTitleColor(UIColor.white, for: .normal)
        
        // corner
        layer.cornerRadius = radius
        
        
        // font
//        titleLabel?.font = UIFont(name:APP_FONT_NAME_BOLD, size: SMALL_BUTTON_FONT_SIZE)
        titleLabel?.font = UIFont .boldSystemFont(ofSize: SMALL_BUTTON_FONT_SIZE)

        //         shadow
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 3.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
