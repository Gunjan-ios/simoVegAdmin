//
//  Utils.swift
//  iBeacon
//
//  Created by Gunjan on 02/09/19.
//  Copyright © 2019 Gunjan. All rights reserved.
//

import UIKit
import JQProgressHUD
import Foundation
import SwiftyJSON


class Utils: NSObject {

    static func getAlertController(title : String, message : String ,style: UIAlertController.Style) ->  UIAlertController {
        
        let alertVc = UIAlertController.init(title: title, message: message, preferredStyle: style)
        alertVc.view.tintColor = colorPrimary
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : colorPrimary]
        let hogen = NSMutableAttributedString.init(string: title, attributes: attrs)
        alertVc.setValue(hogen,forKey: "attributedTitle")
        let attrsM  = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : colorPrimary]
        let hogenMessage = NSMutableAttributedString.init(string: message, attributes: attrsM)
        alertVc.setValue(hogenMessage,forKey: "attributedMessage")
        return alertVc
    }
    static func getPriceAlertController(title : String, message : String ,style: UIAlertController.Style) ->  UIAlertController {
        
        let alertVc = UIAlertController.init(title: title, message: message, preferredStyle: style)
        alertVc.view.tintColor = colorPrimary
         let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : colorPrimary]
        let hogen = NSMutableAttributedString.init(string: title, attributes: attrs)
        alertVc.setValue(hogen,forKey: "attributedTitle")
        let attrsM = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : colorGreen]
        let hogenMessage = NSMutableAttributedString.init(string: message, attributes: attrsM)
        alertVc.setValue(hogenMessage,forKey: "attributedMessage")
        return alertVc
    }
    
    static func attributedString(str : String) -> NSAttributedString? {
        let attributes : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0),
            NSAttributedString.Key.foregroundColor : UIColor.lightGray,
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSAttributedString(string: str, attributes: attributes)
        return attributedString
    }
    static func mulitplelinebutton(strText :NSString , btn :UIButton){
        
        
        let fulltext : String = strText as String
        //getting the range to separate the button title strings
        let newlineRange: NSRange = strText.range(of: "\n")
        
        //getting both substrings
        var substring1 = ""
        var substring2 = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = strText.substring(to: newlineRange.location)
            substring2 = strText.substring(from: newlineRange.location)
        }
        
        //assigning diffrent fonts to both substrings
        let font1: UIFont = UIFont .boldSystemFont(ofSize:SMALL_BUTTON_FONT_SIZE)
        let attributes1: [NSAttributedString.Key: Any] = [
            .font: font1,
            .foregroundColor: colorSubHeading_76
        ]
        let attrString1 = NSMutableAttributedString(string: substring1, attributes: attributes1)
        
        
        let font2: UIFont = UIFont .systemFont(ofSize:  SUB_LABEL_DESC_FONT_SIZE)
        let attributes2: [NSAttributedString.Key: Any] = [
            .font: font2,
            .foregroundColor: colorSubSubHeading_94
        ]
        
        let attrString2 = NSMutableAttributedString(string: substring2, attributes: attributes2)
        
        attrString1.append(attrString2)

        //assigning the resultant attributed strings to the button
        btn.setAttributedTitle(attrString1, for: [])
    
    }
   static func convertDateFormat(inputDate: String) -> String {
        
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = DATE_FORMAT
        
        let oldDate = olDateFormatter.date(from: inputDate)
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateStyle = .medium
        
        return convertDateFormatter.string(from: oldDate!)
    }

    static func getDateFormDays(strDay:Int) -> String {
        let today = Date()
        let Dates = Calendar.current.date(byAdding: .day, value: strDay, to: today)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DATE_FORMAT
        let days = dateFormatter.string(from: Dates)
        return days
    }
    static func getCurrentTimeStamp()-> String {
        let timestamp = NSDate().timeIntervalSince1970
        return "\(timestamp)"
    }
    
    static func showLoading(title : String)  {
        JQProgressHUDTool.jq_showCustomHUD( msg: title)
    }
    static func hideLoading()  {
        JQProgressHUDTool.jq_hideHUD()
    }
    static func mimeType(for data: Data) -> String {
        
        var b: UInt8 = 0
        data.copyBytes(to: &b, count: 1)
        
        switch b {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x4D, 0x49:
            return "image/tiff"
        case 0x25:
            return "application/pdf"
        case 0xD0:
            return "application/vnd"
        case 0x46:
            return "text/plain"
        default:
            return "application/octet-stream"
        }
    }
    static func stringFromJson(object: [[String : Any]]) -> String{
        let newjson = JSON(object)
        let sjod = newjson.rawString()
        return sjod!
//        let jsonData = try? JSONSerialization.data(withJSONObject: object, options: [])
//        let jsonString = String(data: jsonData!, encoding: .utf8)
//        return jsonString!
    }
    static func jsonObjectDic(jsonString : String) -> NSMutableDictionary{
        let jsonData = jsonString.data(using: .utf8)
        let dictionary = try? JSONSerialization.jsonObject(with: jsonData!, options: .mutableContainers )
        return dictionary as! NSMutableDictionary
    }
    
//    static func stringFromJson(object: String) -> [String : Any]{
//        let newjson = JSON(object)
//        let sjod = newjson.rawString()
//        return sjod!
//        //        let jsonData = try? JSONSerialization.data(withJSONObject: object, options: [])
//        //        let jsonString = String(data: jsonData!, encoding: .utf8)
//        //        return jsonString!
//    }
    static func stringFromJson(obj: [String : Any]) -> String{
        let jsonData = try? JSONSerialization.data(withJSONObject: obj, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        return jsonString!
    }
    static func jsonObject(jsonString : String) -> JSON {
        let jsonData = jsonString.data(using: .utf8)
        if (jsonData != nil) {
            let finalJSON = try? JSON(data: jsonData!)
            return finalJSON!
        }
        else{
            return JSON()
        }
    }
}

