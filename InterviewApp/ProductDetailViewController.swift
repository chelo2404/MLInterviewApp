//
//  ProductDetailViewController.swift
//  InterviewApp
//
//  Created by Gerardo Marcelo Fernandez on 17/12/2018.
//  Copyright © 2018 Gerardo Marcelo Fernandez. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var mercadoPagoLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    var details : DetailsDTO = DetailsDTO()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = self.details.title
        self.priceLabel.text = self.details.price
        self.thumbnail.sd_setImage(with: URL(string: (self.details.thumbnail)), completed: nil)
        
        var mercadoPagoText = "No acepta"
        if ((self.details.mercadoPago)) {
            mercadoPagoText = "Acepta"
        }
        self.mercadoPagoLabel.text = mercadoPagoText
        
        self.endDateLabel.text = Utils.convertDateFormatFor(value: self.details.stopTime, from: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", to: "EEE, MMM d, ''yy")
            
        self.ratingLabel.text = String(format: "%.1f", (self.details.rating))
        self.conditionLabel.text = self.details.condition.capitalized
    }

}
