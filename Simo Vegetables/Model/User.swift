//
//  User.swift
//  Created on January 3, 2021

import Foundation
import SwiftyJSON

struct AGImageInfo {
    var fileName: String
    var type: String
    var data: Data
}
class User : NSObject, NSCoding{

    var address : String!
    var email : String!
    var firstName : String!
    var lastName : String!
    var mobile : String!
    var profilePic : String!
    var userId : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        address = json["address"].stringValue
        email = json["email"].stringValue
        firstName = json["first_name"].stringValue
        lastName = json["last_name"].stringValue
        mobile = json["mobile"].stringValue
        profilePic = json["profile_pic"].stringValue
        userId = json["admin_id"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if address != nil{
        	dictionary["address"] = address
        }
        if email != nil{
        	dictionary["email"] = email
        }
        if firstName != nil{
        	dictionary["first_name"] = firstName
        }
        if lastName != nil{
        	dictionary["last_name"] = lastName
        }
        if mobile != nil{
        	dictionary["mobile"] = mobile
        }
        if profilePic != nil{
        	dictionary["profile_pic"] = profilePic
        }
        if userId != nil{
        	dictionary["user_id"] = userId
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		address = aDecoder.decodeObject(forKey: "address") as? String
		email = aDecoder.decodeObject(forKey: "email") as? String
		firstName = aDecoder.decodeObject(forKey: "first_name") as? String
		lastName = aDecoder.decodeObject(forKey: "last_name") as? String
		mobile = aDecoder.decodeObject(forKey: "mobile") as? String
		profilePic = aDecoder.decodeObject(forKey: "profile_pic") as? String
		userId = aDecoder.decodeObject(forKey: "user_id") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if address != nil{
			aCoder.encode(address, forKey: "address")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if firstName != nil{
			aCoder.encode(firstName, forKey: "first_name")
		}
		if lastName != nil{
			aCoder.encode(lastName, forKey: "last_name")
		}
		if mobile != nil{
			aCoder.encode(mobile, forKey: "mobile")
		}
		if profilePic != nil{
			aCoder.encode(profilePic, forKey: "profile_pic")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}

	}

}
