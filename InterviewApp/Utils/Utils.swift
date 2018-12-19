//
//  Utils.swift
//  InterviewApp
//
//  Created by Gerardo Marcelo Fernandez on 18/12/2018.
//  Copyright © 2018 Gerardo Marcelo Fernandez. All rights reserved.
//

import UIKit

class Utils: NSObject {

    class func convertDateFormatFor(value: String, from: String, to: String) -> String {
        let dateFormatter = DateFormatter()
        // Initially set the format based on the results date
        dateFormatter.dateFormat = from
        
        // Convert your string to date
        let stopTime = dateFormatter.date(from: value)
        // Then again set the date format according to the type of output you need
        dateFormatter.dateFormat = to
        // Again convert your date to string
        let dateAsString = dateFormatter.string(from: stopTime!)
        
        return dateAsString
    }
}
