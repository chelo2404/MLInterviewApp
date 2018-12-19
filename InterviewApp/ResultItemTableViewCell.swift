//
//  ResultItemTableViewCell.swift
//  InterviewApp
//
//  Created by Gerardo Marcelo Fernandez on 17/12/2018.
//  Copyright © 2018 Gerardo Marcelo Fernandez. All rights reserved.
//

import UIKit

class ResultItemTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
