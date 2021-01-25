//
//  OrderPlaceProduct.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on January 10, 2021

import Foundation
import SwiftyJSON


class OrderPlaceProduct : NSObject, NSCoding{

    var availableQuantity : Int!
    var createdAt : String!
    var image : String!
    var isActive : String!
    var productDescription : String!
    var productId : String!
    var productName : String!
    var purchasePrice : String!
    var salePrice : String!
    var soldQuantity : Int!
    var totalOrderedQuantity : String!
    var totalQuantity : String!
    var unit : String!
    var unitNote : String!
    var updatedAt : String!
    var myOrder : String!



	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        availableQuantity = json["available_quantity"].intValue
        createdAt = json["created_at"].stringValue
        image = json["image"].stringValue
        isActive = json["is_active"].stringValue
        productDescription = json["product_description"].stringValue
        productId = json["product_id"].stringValue
        productName = json["product_name"].stringValue
        purchasePrice = json["purchase_price"].stringValue
        salePrice = json["sale_price"].stringValue
        soldQuantity = json["sold_quantity"].intValue
        totalOrderedQuantity = json["total_ordered_quantity"].stringValue
        totalQuantity = json["total_quantity"].stringValue
        unit = json["unit"].stringValue
        unitNote = json["unit_note"].stringValue
        updatedAt = json["updated_at"].stringValue
        myOrder = json["myOrder"].stringValue

	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if availableQuantity != nil{
        	dictionary["available_quantity"] = availableQuantity
        }
        if createdAt != nil{
        	dictionary["created_at"] = createdAt
        }
        if image != nil{
        	dictionary["image"] = image
        }
        if isActive != nil{
        	dictionary["is_active"] = isActive
        }
        if productDescription != nil{
        	dictionary["product_description"] = productDescription
        }
        if productId != nil{
        	dictionary["product_id"] = productId
        }
        if productName != nil{
        	dictionary["product_name"] = productName
        }
        if purchasePrice != nil{
        	dictionary["purchase_price"] = purchasePrice
        }
        if salePrice != nil{
        	dictionary["sale_price"] = salePrice
        }
        if soldQuantity != nil{
        	dictionary["sold_quantity"] = soldQuantity
        }
        if totalOrderedQuantity != nil{
        	dictionary["total_ordered_quantity"] = totalOrderedQuantity
        }
        if totalQuantity != nil{
        	dictionary["total_quantity"] = totalQuantity
        }
        if unit != nil{
        	dictionary["unit"] = unit
        }
        if unitNote != nil{
        	dictionary["unit_note"] = unitNote
        }
        if updatedAt != nil{
        	dictionary["updated_at"] = updatedAt
        }
        if myOrder != nil{
            dictionary["myOrder"] = myOrder
        }


		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		availableQuantity = aDecoder.decodeObject(forKey: "available_quantity") as? Int
		createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
		image = aDecoder.decodeObject(forKey: "image") as? String
		isActive = aDecoder.decodeObject(forKey: "is_active") as? String
		productDescription = aDecoder.decodeObject(forKey: "product_description") as? String
		productId = aDecoder.decodeObject(forKey: "product_id") as? String
		productName = aDecoder.decodeObject(forKey: "product_name") as? String
		purchasePrice = aDecoder.decodeObject(forKey: "purchase_price") as? String
		salePrice = aDecoder.decodeObject(forKey: "sale_price") as? String
		soldQuantity = aDecoder.decodeObject(forKey: "sold_quantity") as? Int
		totalOrderedQuantity = aDecoder.decodeObject(forKey: "total_ordered_quantity") as? String
		totalQuantity = aDecoder.decodeObject(forKey: "total_quantity") as? String
		unit = aDecoder.decodeObject(forKey: "unit") as? String
		unitNote = aDecoder.decodeObject(forKey: "unit_note") as? String
		updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
        myOrder = aDecoder.decodeObject(forKey: "myOrder") as? String


	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if availableQuantity != nil{
			aCoder.encode(availableQuantity, forKey: "available_quantity")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if isActive != nil{
			aCoder.encode(isActive, forKey: "is_active")
		}
		if productDescription != nil{
			aCoder.encode(productDescription, forKey: "product_description")
		}
		if productId != nil{
			aCoder.encode(productId, forKey: "product_id")
		}
		if productName != nil{
			aCoder.encode(productName, forKey: "product_name")
		}
		if purchasePrice != nil{
			aCoder.encode(purchasePrice, forKey: "purchase_price")
		}
		if salePrice != nil{
			aCoder.encode(salePrice, forKey: "sale_price")
		}
		if soldQuantity != nil{
			aCoder.encode(soldQuantity, forKey: "sold_quantity")
		}
		if totalOrderedQuantity != nil{
			aCoder.encode(totalOrderedQuantity, forKey: "total_ordered_quantity")
		}
		if totalQuantity != nil{
			aCoder.encode(totalQuantity, forKey: "total_quantity")
		}
		if unit != nil{
			aCoder.encode(unit, forKey: "unit")
		}
		if unitNote != nil{
			aCoder.encode(unitNote, forKey: "unit_note")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}
        if myOrder != nil{
            aCoder.encode(myOrder, forKey: "myOrder")
        }
	}

}
