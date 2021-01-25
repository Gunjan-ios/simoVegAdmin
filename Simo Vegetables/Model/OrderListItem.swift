//
//  OrderListItem.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on January 3, 2021

import Foundation
import SwiftyJSON


class OrderListItem : NSObject, NSCoding{

    var image : String!
    var orderId : String!
    var orderItemId : String!
    var productDescription : String!
    var productId : String!
    var productName : String!
    var purchasePrice : String!
    var quantity : String!
    var salePrice : String!
    var totalPurchasePrice : String!
    var totalSalePrice : String!
    var unit : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        image = json["image"].stringValue
        orderId = json["order_id"].stringValue
        orderItemId = json["order_item_id"].stringValue
        productDescription = json["product_description"].stringValue
        productId = json["product_id"].stringValue
        productName = json["product_name"].stringValue
        purchasePrice = json["purchase_price"].stringValue
        quantity = json["quantity"].stringValue
        salePrice = json["sale_price"].stringValue
        totalPurchasePrice = json["total_purchase_price"].stringValue
        totalSalePrice = json["total_sale_price"].stringValue
        unit = json["unit"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if image != nil{
        	dictionary["image"] = image
        }
        if orderId != nil{
        	dictionary["order_id"] = orderId
        }
        if orderItemId != nil{
        	dictionary["order_item_id"] = orderItemId
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
        if quantity != nil{
        	dictionary["quantity"] = quantity
        }
        if salePrice != nil{
        	dictionary["sale_price"] = salePrice
        }
        if totalPurchasePrice != nil{
        	dictionary["total_purchase_price"] = totalPurchasePrice
        }
        if totalSalePrice != nil{
        	dictionary["total_sale_price"] = totalSalePrice
        }
        if unit != nil{
        	dictionary["unit"] = unit
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		image = aDecoder.decodeObject(forKey: "image") as? String
		orderId = aDecoder.decodeObject(forKey: "order_id") as? String
		orderItemId = aDecoder.decodeObject(forKey: "order_item_id") as? String
		productDescription = aDecoder.decodeObject(forKey: "product_description") as? String
		productId = aDecoder.decodeObject(forKey: "product_id") as? String
		productName = aDecoder.decodeObject(forKey: "product_name") as? String
		purchasePrice = aDecoder.decodeObject(forKey: "purchase_price") as? String
		quantity = aDecoder.decodeObject(forKey: "quantity") as? String
		salePrice = aDecoder.decodeObject(forKey: "sale_price") as? String
		totalPurchasePrice = aDecoder.decodeObject(forKey: "total_purchase_price") as? String
		totalSalePrice = aDecoder.decodeObject(forKey: "total_sale_price") as? String
		unit = aDecoder.decodeObject(forKey: "unit") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if image != nil{
			aCoder.encode(image, forKey: "image")
		}
		if orderId != nil{
			aCoder.encode(orderId, forKey: "order_id")
		}
		if orderItemId != nil{
			aCoder.encode(orderItemId, forKey: "order_item_id")
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
		if quantity != nil{
			aCoder.encode(quantity, forKey: "quantity")
		}
		if salePrice != nil{
			aCoder.encode(salePrice, forKey: "sale_price")
		}
		if totalPurchasePrice != nil{
			aCoder.encode(totalPurchasePrice, forKey: "total_purchase_price")
		}
		if totalSalePrice != nil{
			aCoder.encode(totalSalePrice, forKey: "total_sale_price")
		}
		if unit != nil{
			aCoder.encode(unit, forKey: "unit")
		}

	}

}
