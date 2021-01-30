//
//  Hud.swift
//  Matchfit
//
//  Created by Gunjan Raval on 23/08/18.
//  Copyright © 2018 Gunjan. All rights reserved.
//
//

import Foundation
import JQProgressHUD
import iProgressHUD

class Hud {
    
    static func showLoading(title : String,view : UIView)  {
        JQProgressHUDTool.jq_showCustomHUD( msg: title)
    }
    static func hideLoading(view : UIView)  {
        JQProgressHUDTool.jq_hideHUD()
    }
}
