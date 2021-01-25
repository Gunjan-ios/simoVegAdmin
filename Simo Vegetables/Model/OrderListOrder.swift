//
//  OrderListOrder.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on January 3, 2021

import Foundation
import SwiftyJSON


class OrderListOrder : NSObject, NSCoding{

    var address : String!
    var firstName : String!
    var items : [OrderListItem]!
    var lastName : String!
    var orderAmount : String!
    var orderId : String!
    var orderNumber : String!
    var orderPlacedOn : String!
    var totalItems : Int!
    var userId : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){

		if json.isEmpty{
			return
		}
        address = json["address"].stringValue
        firstName = json["first_name"].stringValue
        items = [OrderListItem]()
        let itemsArray = json["items"].arrayValue
        items = [OrderListItem]()
        for itemsJson in itemsArray{
            let value = OrderListItem(fromJson: itemsJson)
            items.append(value)
        }
        lastName = json["last_name"].stringValue
        orderAmount = json["order_amount"].stringValue
        orderId = json["order_id"].stringValue
        orderNumber = json["order_number"].stringValue
        orderPlacedOn = json["order_placed_on"].stringValue
        totalItems = json["total_items"].intValue
        userId = json["user_id"].stringValue
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
        if firstName != nil{
        	dictionary["first_name"] = firstName
        }
        if items != nil{
        var dictionaryElements = [[String:Any]]()
        for itemsElement in items {
        	dictionaryElements.append(itemsElement.toDictionary())
        }
        dictionary["items"] = dictionaryElements
        }
        if lastName != nil{
        	dictionary["last_name"] = lastName
        }
        if orderAmount != nil{
        	dictionary["order_amount"] = orderAmount
        }
        if orderId != nil{
        	dictionary["order_id"] = orderId
        }
        if orderNumber != nil{
        	dictionary["order_number"] = orderNumber
        }
        if orderPlacedOn != nil{
        	dictionary["order_placed_on"] = orderPlacedOn
        }
        if totalItems != nil{
        	dictionary["total_items"] = totalItems
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
		firstName = aDecoder.decodeObject(forKey: "first_name") as? String
		items = aDecoder.decodeObject(forKey: "items") as? [OrderListItem]
		lastName = aDecoder.decodeObject(forKey: "last_name") as? String
		orderAmount = aDecoder.decodeObject(forKey: "order_amount") as? String
		orderId = aDecoder.decodeObject(forKey: "order_id") as? String
		orderNumber = aDecoder.decodeObject(forKey: "order_number") as? String
		orderPlacedOn = aDecoder.decodeObject(forKey: "order_placed_on") as? String
		totalItems = aDecoder.decodeObject(forKey: "total_items") as? Int
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
		if firstName != nil{
			aCoder.encode(firstName, forKey: "first_name")
		}
		if items != nil{
			aCoder.encode(items, forKey: "items")
		}
		if lastName != nil{
			aCoder.encode(lastName, forKey: "last_name")
		}
		if orderAmount != nil{
			aCoder.encode(orderAmount, forKey: "order_amount")
		}
		if orderId != nil{
			aCoder.encode(orderId, forKey: "order_id")
		}
		if orderNumber != nil{
			aCoder.encode(orderNumber, forKey: "order_number")
		}
		if orderPlacedOn != nil{
			aCoder.encode(orderPlacedOn, forKey: "order_placed_on")
		}
		if totalItems != nil{
			aCoder.encode(totalItems, forKey: "total_items")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "user_id")
		}

	}

}
