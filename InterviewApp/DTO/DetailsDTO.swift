//
//  DetailsDTO.swift
//  InterviewApp
//
//  Created by Gerardo Marcelo Fernandez on 18/12/2018.
//  Copyright © 2018 Gerardo Marcelo Fernandez. All rights reserved.
//

import UIKit

class DetailsDTO: NSObject {
    var title = ""
    var price = ""
    var thumbnail = ""
    var mercadoPago = false
    var stopTime = ""
    var rating = 0.0
    var condition = "new"
    
    /**
     Converts a JSON object into a DTO object with the details of the item selected.
     
     - Parameter jsonObject: The JSON object we want to convert to DTO.
     
     - Returns: A DetailsDTO object with the selected item info.
    */
    class func DTOFromJSON(jsonObject: Dictionary<String, Any>) -> DetailsDTO{
        // Create an instance of this class
        let dto = DetailsDTO()
        
        // Set the title
        dto.title = jsonObject["title"] as! String
        
        // Format and set the price
        let price = (jsonObject["price"] as? NSNumber)!
        dto.price = String(format: "%.2f", price.doubleValue)
        
        dto.thumbnail = jsonObject["thumbnail"] as! String
        dto.mercadoPago = jsonObject["accepts_mercadopago"] as! Bool
        dto.stopTime = jsonObject["stop_time"] as! String
        
        // Get the rating from the reviews object and set the proper attribute
        let reviews = jsonObject["reviews"] as! Dictionary<String, Any>
        let rating = reviews["rating_average"] as? NSNumber
        dto.rating = rating?.doubleValue ?? 0.0
        
        dto.condition = jsonObject["condition"] as! String
        
        return dto
    }
}


