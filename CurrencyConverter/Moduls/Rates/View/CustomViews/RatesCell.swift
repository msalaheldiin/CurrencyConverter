//
//  RatesCell.swift
//  CurrencyConverter
//
//  Created by Mahmoud Salaheldin on 12/24/20.
//  Copyright © 2020 Mahmoud Salaheldin. All rights reserved.
//

import UIKit
import FlagKit

class RatesCell: UICollectionViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var countryFlagIV: UIImageView!
    @IBOutlet weak var currencyRateLbl: UILabel!
    
    
     // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let view = UIView(frame: contentView.bounds)
        view.isUserInteractionEnabled = false
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = UIColor(white: 0.94, alpha: 1.0)
        selectedBackgroundView = view
    }
    
    
    // MARK: - Helper Methods
    
    func configureRateCell(itemCurrency: String? , itemRate: Double?){
        
        currencyRateLbl.text =  String(describing: itemRate ?? 0.0)
        let currency = itemCurrency?.dropLast()
        let countryCode = currency ?? ""
        let bundle = FlagKit.assetBundle
        let originalImage = UIImage(named: String(countryCode), in: bundle, compatibleWith: nil)
        countryFlagIV.image = originalImage
    }
    
}
