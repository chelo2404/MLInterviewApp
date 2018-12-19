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
        // initially set the format based on your datepicker date / server String
        dateFormatter.dateFormat = from// "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        // convert your string to date
        let stopTime = dateFormatter.date(from: value)
        //then again set the date format whhich type of output you need
        dateFormatter.dateFormat = to// "EEE, MMM d, ''yy"
        // again convert your date to string
        let dateAsString = dateFormatter.string(from: stopTime!)
        return dateAsString
    }
}
