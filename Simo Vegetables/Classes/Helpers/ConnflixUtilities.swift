//
//  ShopeLivUtilities.swift
//  ShopeLiv
//
//  Created by Suresh on 01/03/18.
//  Copyright © 2018 Jagannath. All rights reserved.
//

import UIKit
import SwiftyJSON
class ConnflixUtilities: NSObject {
    
    static let shared = ConnflixUtilities()
    private override init() { }

//    var userType_id: String? {
//        get {
//            return UserDefaults.standard.object(forKey: Constant.KuserType_id) as? String
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: Constant.KuserType_id)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
//    var PermissionCheck: String? {
//        get {
//            return UserDefaults.standard.object(forKey: Constant.KpermissionCheck) as? String
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: Constant.KpermissionCheck)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }

    //MARK: Logged in userID
    var UserID: String? {
        get {
            return UserDefaults.standard.object(forKey: CS.Params.user_id) as? String
        }
        set {
            if let value = newValue {
                UserDefaults.standard.setValue(value, forKey: CS.Params.user_id)
                UserDefaults.standard.synchronize()
            }
        }
    }
//    var myWallet: Int? {
//        get {
//            return UserDefaults.standard.object(forKey: "myWallet") as? Int
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: "myWallet")
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
//    var savedUser: User? {
//        get {
//            guard let list = UserDefaults.standard.object(forKey: CS.Params.userData) as? User else {
//                let value = JSON()
//                return User (fromJson: value)
//            }
//            return list
//        }
//        set {
//
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: CS.Params.userData)
//                UserDefaults.standard.synchronize()
//            }
//        }
//
//    }
    var mobile : String? {
        get {
            return UserDefaults.standard.object(forKey: CS.Params.mobile) as? String
        }
        set {
            if let value = newValue {
                UserDefaults.standard.setValue(value, forKey: CS.Params.mobile)
                UserDefaults.standard.synchronize()
            }
        }
    }
    var selectVideoType : String? {
        get {
            return UserDefaults.standard.object(forKey: CS.Saved.selectvideoType) as? String
        }
        set {
            if let value = newValue {
                UserDefaults.standard.setValue(value, forKey: CS.Saved.selectvideoType)
                UserDefaults.standard.synchronize()
            }
        }
    }

    var email : String? {
        get {
            return UserDefaults.standard.object(forKey:CS.Params.email) as? String
        }
        set {
            if let value = newValue {
                UserDefaults.standard.setValue(value, forKey: CS.Params.email)
                UserDefaults.standard.synchronize()
            }
        }
    }

//    var isWalkThroughShowed: Bool? {
//        get {
//            guard let flag = UserDefaults.standard.object(forKey: Macros.kSettingWalkThroughShowedAdding) as? Bool else {
//                return false
//            }
//
//            return flag
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: Macros.kSettingWalkThroughShowedAdding)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
//    var isStoreAdded: Bool? {
//        get {
//            return UserDefaults.standard.object(forKey: Macros.kSettingStoreAdding) as? Bool
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: Macros.kSettingStoreAdding)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
    
//    var provider: String? {
//        get {
//            return UserDefaults.standard.object(forKey: Macros.kSettingUserProvider) as? String
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: Macros.kSettingUserProvider)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
    //MARK: Logged in first name
    var firstname: String? {
        get {
            return UserDefaults.standard.object(forKey: CS.Params.first_name) as? String
        }
        set {
            if let value = newValue {
                UserDefaults.standard.setValue(value, forKey: CS.Params.first_name)
                UserDefaults.standard.synchronize()
            }
        }
    }
    //MARK: Logged in last name
    var lastname: String? {
        get {
            return UserDefaults.standard.object(forKey: CS.Params.last_name) as? String
        }
        set {
            if let value = newValue {
                UserDefaults.standard.setValue(value, forKey: CS.Params.last_name)
                UserDefaults.standard.synchronize()
            }
        }
    }
    var profilePic: String? {
        get {
            return UserDefaults.standard.object(forKey: CS.Params.profile_pic) as? String
        }
        set {
            if let value = newValue {
                UserDefaults.standard.setValue(value, forKey: CS.Params.profile_pic)
                UserDefaults.standard.synchronize()
            }
        }
    }
//    var isProfileStatusAdded: Bool? {
//        get {
//            return UserDefaults.standard.object(forKey: Macros.kSettingProfileStatusAdding) as? Bool
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: Macros.kSettingProfileStatusAdding)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
//
    //MARK: media_base_url
//    var MediaUrl: String? {
//        get {
//            return UserDefaults.standard.object(forKey: Constant.KMediaUrl) as? String
//        }
//        set {
//            if let value = newValue {
//                UserDefaults.standard.setValue(value, forKey: Constant.KMediaUrl)
//                UserDefaults.standard.synchronize()
//            }
//        }
//    }
}

extension Date {
    
    var  formatter: DateFormatter { return DateFormatter() }
    
    var convertToTimeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let str = dateFormatter.string(from: self)
        return str
    }
    var convertToDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DATE_FORMAT
        let str = dateFormatter.string(from: self)
        return str
    }

}


// MARK: - Asynchronous Image download
let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(_ urlString: String) {
        
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let data = data{
                    if let imageToCache = UIImage(data: data){
                        
                        if self.imageUrlString == urlString {
                            self.image = imageToCache
                        }
                        imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                    }
                }
            })
        }).resume()
    }
}

