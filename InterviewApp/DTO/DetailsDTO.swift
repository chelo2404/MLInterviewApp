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
    
    class func DTOFromJSON(jsonObject: Dictionary<String, Any>) -> DetailsDTO{
        let dto = DetailsDTO()
        
        dto.title = jsonObject["title"] as! String
        
        let price = (jsonObject["price"] as? NSNumber)!
        dto.price = String(format: "%.2f", price.doubleValue)
        
        dto.thumbnail = jsonObject["thumbnail"] as! String
        dto.mercadoPago = jsonObject["accepts_mercadopago"] as! Bool
        dto.stopTime = jsonObject["stop_time"] as! String
        
        let reviews = jsonObject["reviews"] as! Dictionary<String, Any>
        let rating = reviews["rating_average"] as? NSNumber
        dto.rating = rating?.doubleValue ?? 0.0
        
        dto.condition = jsonObject["condition"] as! String
        
        return dto
    }
}


