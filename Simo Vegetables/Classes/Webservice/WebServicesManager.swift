//
//  GISWebServicesManager.swift
//  TestSpatialite
//
//  Created by Gaurav on 20/09/19.
//  Copyright © 2019 Gaurav. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let apiId = "YzMxYjMyMzY0Y2UxOWNhOGZjZDE1MGE0MTdlY2NlNTg="
let BASE_URL = "https://digitalfriend.co.in/simo_vegetables/api/services/"
let BASE_Admin_URL = "https://digitalfriend.co.in/simo_vegetables/api/"

let ItunesUrl = "https://apps.apple.com/us/app/connflix/id1546423387"

//let SIGNIN_URL = "admin/login"
let SIGNIN_URL = "user/signin"

let SIGNUP_URL = "user/signup"
let PROFILEUPDATE_URL = "user/update_profile"
let RESENDOTP_URL = "user/resend_otp"
let VERIFYOTP_URL = "user/verify_otp"
let PROFILEDETAILS_URL = "user/profile_details"
let FORGOT_PASSWORD_URL = "user/forgot_password"
let RESET_PASSWORD_URL = "user/reset_password"
let CHNAGES_PASSWORD_URL = "user/change_password"
let ORDERSAVE_URL = "order/save"
let PRODUCTLIST_URL = "product/list"
let ORDERLIST_URL = "order/list"
let UPDATEPRICE_URL = "product/update_price"
let GENERAL_URL = "general"



class WebServicesManager {
    
    class func loginWS(mobile:String,password:String,onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        
        Hud.showLoading(title: CS.Common.waiting)
        let parameters: Parameters = [
            CS.Params.mobile : mobile,
            CS.Params.password : password,
            ]
        
        let strUrl = "\(BASE_URL)\(SIGNIN_URL)"
        print(parameters)
        print("Request :- \(strUrl)")
        Alamofire.request(strUrl, method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
            Hud.hideLoading()
            guard let value = response.result.value
                else {
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    return }
            
            let json = JSON(value)
            print(json)
         onCompletion!(json)
        }
    }

    
    class func changePasswordWS(user_id:String,new_password:String,old_password:String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        
        Hud.showLoading(title: CS.Common.waiting)
        let parameters: Parameters = [
            CS.Params.user_id : user_id,
            CS.Params.new_password : new_password,
            CS.Params.old_password : old_password,
        ]


        let strUrl = "\(BASE_URL)\(CHNAGES_PASSWORD_URL)"
        print(parameters)
        print("Request :- \(strUrl)")
        Alamofire.request(strUrl, method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
            Hud.hideLoading()
            
            
            guard let value = response.result.value
                else {
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    return }
            
            let json = JSON(value)
            print(json)
            onCompletion!(json)
        }
    }

    class func RESET_PASSWORD_WS(mobile:String,password:String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {

        Hud.showLoading(title: CS.Common.waiting)
        let parameters: Parameters = [
            CS.Params.mobile : mobile,
            CS.Params.password : password,
        ]

        let strUrl = "\(BASE_URL)\(RESET_PASSWORD_URL)"
        print(parameters)
        print("Request :- \(strUrl)")
        Alamofire.request(strUrl, method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
            Hud.hideLoading()


            guard let value = response.result.value
                else {
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    return }

            let json = JSON(value)
            print(json)
            onCompletion!(json)
        }
    }
    class func signUPWS(firstname:String,lastname:String,email:String,mobile:String,password:String,address:String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        
        Hud.showLoading(title: CS.Common.waiting)

        let parameters: Parameters = [
            CS.Params.first_name : firstname,
            CS.Params.last_name : lastname,
            CS.Params.email : email,
            CS.Params.mobile : mobile,
            CS.Params.password : password,
            CS.Params.address : address,
        ]
        
        let strUrl = "\(BASE_URL)\(SIGNUP_URL)"
        print(parameters)
        print("Request :- \(strUrl)")
        Alamofire.request(strUrl, method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
            Hud.hideLoading()
            guard let value = response.result.value
                else {
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    return }
            
            let json = JSON(value)
            print(json)
            onCompletion!(json)
        }
        
    }

    class func resendORForgotOtpWS(mobile:String, type : String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        
        Hud.showLoading(title: CS.Common.waiting)
        let parameters: Parameters = [
            CS.Params.mobile : mobile]
        
        var strUrl : String = ""

        if type  ==  "Resend"{
           strUrl = "\(BASE_URL)\(RESENDOTP_URL)"
        }else{
            strUrl = "\(BASE_URL)\(FORGOT_PASSWORD_URL)"
        }
        print(parameters)
        print("Request :- \(strUrl)")
        
        Alamofire.request(strUrl, method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
            Hud.hideLoading()
            guard let value = response.result.value
                else {
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    return }
            
            let json = JSON(value)
            print(json)
            onCompletion!(json)
        }
        
    }
    
    class func verifyOtpWS(otp:String, mobile:String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        
        Hud.showLoading(title: CS.Common.waiting)
        let parameters: Parameters = [
            CS.Params.otp : otp,
            CS.Params.mobile : mobile
        ]
        let strUrl = "\(BASE_URL)\(VERIFYOTP_URL)"
        print(parameters)
        print("Request :- \(strUrl)")
        
        Alamofire.request(strUrl, method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
            Hud.hideLoading()
            
            
            guard let value = response.result.value
                else {
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    return }
            
            let json = JSON(value)
            print(json)
            onCompletion!(json)
        }
    }
    
    
    class func  profileUpdateWS(formData:Parameters, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        Hud.showLoading(title: CS.Common.waiting)
        
        let header: HTTPHeaders = [
            "Accept": "application/json",
            "Content-type": "multipart/form-data"
        ]
        var finalData : Parameters!
        finalData = formData

        let strUrl = "\(BASE_URL)\(PROFILEUPDATE_URL)"
        print("Request :- \(strUrl)")
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in finalData {
                if let imageData = value as? AGImageInfo {
                    multipartFormData.append(imageData.data, withName: key, fileName: imageData.fileName, mimeType: imageData.type)
                }
                
                multipartFormData.append("\(value)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
                
            }
            
        }, to: strUrl, method: .post, headers: header) { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        Hud.hideLoading()
                        let json = JSON(value)
                        print(json)
                        onCompletion!(json)
                        break
                    case .failure(let error):
                        onError?(error)
                        return
                    }
                }
                
            case .failure(let error):
                Hud.hideLoading()
                debugPrint(error)
                 onError? (error)
                break
            }
        }
    }

    class func profileWS(user_id:String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        Hud.showLoading(title: CS.Common.waiting)

        let parameters: Parameters = [
            CS.Params.user_id : user_id
        ]
        let strUrl = "\(BASE_URL)\(PROFILEDETAILS_URL)"
        print(parameters)
        print("Request :- \(strUrl)")
        
        Alamofire.request(strUrl, method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
            Hud.hideLoading()

            guard let value = response.result.value
                else {
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    return }
            
            let json = JSON(value)
            print(json)
           onCompletion!(json)
        }
    }
    class func orderList(user_id:String,order_date:String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {

//        Hud.showLoading(title: CS.Common.waiting)
        
        let parameters: Parameters = [
            CS.Params.user_id : user_id,
            CS.Params.order_date : order_date
        ]


        let strUrl = "\(BASE_URL)\(ORDERLIST_URL)"
        print(parameters)
        print("Request :- \(strUrl)")
        Alamofire.request(strUrl, method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
            Hud.hideLoading()
            guard let value = response.result.value
                else {
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    return }

            let json = JSON(value)
            print(json)
            onCompletion!(json)
        }
    }
    class func productList(ordered_products:Int,search:String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {

//                Hud.showLoading(title: CS.Common.waiting)

        let parameters: Parameters = [
            CS.Params.is_active : ordered_products,
            CS.Params.search : search,
            CS.Params.ordered_products : ordered_products
        ]


        let strUrl = "\(BASE_URL)\(PRODUCTLIST_URL)"
        print(parameters)
        print("Request :- \(strUrl)")
        Alamofire.request(strUrl, method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
            Hud.hideLoading()
            guard let value = response.result.value
                else {
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    return }

            let json = JSON(value)
            print(json)
            onCompletion!(json)
        }
    }

    class func orderPlaceList(ordered_products:String?,user_id:String, order_id : String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {

        //        Hud.showLoading(title: CS.Common.waiting)

        let parameters: Parameters = [
            CS.Params.order_items : ordered_products ,
            CS.Params.user_id : user_id,
//            CS.Params.order_id : order_id
        ]


        let strUrl = "\(BASE_URL)\(ORDERSAVE_URL)"
        print(parameters)
        print("Request :- \(strUrl)")
        Alamofire.request(strUrl, method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
            Hud.hideLoading()
            guard let value = response.result.value
                else {
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    return }

            let json = JSON(value)
            print(json)
            onCompletion!(json)
        }
    }

    class func commonDocWS(key:String, onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {

        Hud.showLoading(title: CS.Common.waiting)
        let parameters: Parameters = [CS.Params.key : key]
        
        let strUrl = "\(BASE_URL)\(GENERAL_URL)"
        print(parameters)
        print("Request :- \(strUrl)")

        Alamofire.request(strUrl, method: .post, parameters:parameters,encoding: JSONEncoding.default).responseJSON { (response) in
            Hud.hideLoading()
            guard let value = response.result.value
                else {
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    return }
            
            let json = JSON(value)
            print(json)
            onCompletion!(json)
        }
        
    }
}
