//
//  Utils.swift
//  InterviewApp
//
//  Created by Gerardo Marcelo Fernandez on 18/12/2018.
//  Copyright © 2018 Gerardo Marcelo Fernandez. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    // Item keys constants
    static let titleKey = "title"
    static let priceKey = "price"
    static let thumbnailKey = "thumbnail"
    static let mercadoPagoKey = "accepts_mercadopago"
    static let stopTimeKey = "stop_time"
    static let reviewKey = "reviews"
    static let ratingKey = "rating_average"
    static let conditionKey = "condition"
    
    // Date format constants
    static let fullDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let dayMonthYearFormat = "EEE, MMM d, ''yy"
    
    // API constants
    static let baseAPIUrl = "https://api.mercadolibre.com/sites/MLA"
    static let searchQuery = "/search?q="
    
    // Navigation constants
    static let showDetailsNavigation = "showDetails"
    
    /**
     Converts a date string in a specified pattern to use a different pattern to be shown in the app.
     
     - Parameter value: String value to be converted.
     - Parameter from: Pattern used in the value (Previous parameter).
     - Parameter to: Pattern to be used in the result.
     
     - Returns: A date converted to a String with the format specified in the to parameter.
    */
    class func convertDateFormatFor(value: String, from: String, to: String) -> String {
        let dateFormatter = DateFormatter()
        
        // Initially set the format based on the results date
        dateFormatter.dateFormat = from
        
        // Convert your string to date
        let stopTime = dateFormatter.date(from: value)
        
        // Set the date format according to the type of output you need
        dateFormatter.dateFormat = to
        
        // Convert your date to string
        let dateAsString = dateFormatter.string(from: stopTime!)
        
        return dateAsString
    }
    
    /**
     Shows an alert in the requested view with a custom message.
     
     - Parameter message: Message to be shown to the user in the alert.
     - Parameter inView: View controller where the alert is going to be shown.
    */
    class func showErrorAlertWith(message: String, inView: UIViewController) {
        // Create alert instance
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        // Add OK button
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                alert.dismiss(animated: true
                    , completion: nil)
            case .cancel:
                alert.dismiss(animated: true
                    , completion: nil)
            case .destructive:
                alert.dismiss(animated: true
                    , completion: nil)
                
            }}))
        
        // Show alert in the requested view controller
        inView.present(alert, animated: true, completion: nil)
    }
    
    /**
     Add loading indicator in the view requested.
     
     - Parameter inView: View where the loading indicator is going to be shown.
     - Returns: Loading indicator view.
    */
    class func displayLoadingIndicator(inView: UIView) -> UIView {
        let spinnerView = UIView.init(frame: inView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            inView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    /**
     Remove loading indicator from view
     
     - Parameter liView: Loading indicator view to be removed from the screen.
    */
    class func hideLoadingIndicator(liView: UIView) {
        DispatchQueue.main.async {
            liView.removeFromSuperview()
        }
    }
}
