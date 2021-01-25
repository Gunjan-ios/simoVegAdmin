//
//  ExampleBasicContentView.swift
//  ESTabBarControllerExample
//
//  Created by lihao on 2017/2/9.
//  Copyright © 2018年 Egg Swift. All rights reserved.
//

import UIKit

class ExampleBasicContentView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor =  .gray
        highlightTextColor = colorPrimary
        iconColor =  .gray
        highlightIconColor = colorPrimary
        
//        highlightIconColor = UIColor.init(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)

    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
