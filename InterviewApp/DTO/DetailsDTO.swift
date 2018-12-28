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
    class func DTOFromJSON(jsonObject: Dictionary<String, Any>) -> DetailsDTO {
        // Create an instance of this class
        let dto = DetailsDTO()
        
        // Set the title
        dto.title = jsonObject[Utils.titleKey] as! String
        
        // Format and set the price
        let price = (jsonObject[Utils.priceKey] as? NSNumber)!
        dto.price = String(format: "%.2f", price.doubleValue)
        
        // Set preview image url
        dto.thumbnail = jsonObject[Utils.thumbnailKey] as! String
        
        // Set payment method
        dto.mercadoPago = jsonObject[Utils.mercadoPagoKey] as! Bool
        
        // Set end time for offer
        dto.stopTime = jsonObject[Utils.stopTimeKey] as! String
        
        // Get the rating from the reviews object and set the proper attribute
        let reviews = jsonObject[Utils.reviewKey] as! Dictionary<String, Any>
        let rating = reviews[Utils.ratingKey] as? NSNumber
        dto.rating = rating?.doubleValue ?? 0.0
        
        // Set item status
        dto.condition = jsonObject[Utils.conditionKey] as! String
        
        return dto
    }
}


