//
//  RatesViewModel.swift
//  CurrencyConverter
//
//  Created by Mahmoud Salaheldin on 12/23/20.
//  Copyright © 2020 Mahmoud Salaheldin. All rights reserved.
//

import Foundation

class RatesViewModel: BaseViewModel {
    
    // MARK: - Variables
    
    lazy var service = RatesService()
    var ratesResponseModel: APIResponseModel?
    var showLoadingIndicator: (() -> ())?
    var hideLoadingIndicator: (() -> ())?
    var reloadcollectionView: (() -> ())?
    var selectedRate:Double?
    var finalResult: Double?
    
    
    // MARK: - API Calls
    
    func getRates() {
        
        showLoadingIndicator?()
        service.getRates(success: {  [weak self] (response) in
            
            guard let self = self else {return}
            self.ratesResponseModel =  response as? APIResponseModel
            self.reloadcollectionView?()
            self.hideLoadingIndicator?()
            },failure: { (response, erorr) in
                SnackBar.showMessage(erorr?.localizedDescription)
                self.hideLoadingIndicator?()
        })
    }
    
    
    // MARK: - Helper Methods
    
    func numberOfItems() -> Int {
        
        let count = ratesResponseModel?.rates?.propertyNames().count ?? 0
        return count > 0 ? count : 0
    }
    
    func itemCurrency(atIndex index: Int) -> String? {
        let itemCurrency = ratesResponseModel?.rates?.propertyNames()
        return itemCurrency?[index]
    }
    
    func itemRate(atIndex index: Int) -> Double? {
        let itemRate = ratesResponseModel?.rates?.propertyValues()
        return itemRate?[index]
    }
    
    func claculteConvertedAmount(forAmount amount: String) -> String {
        
        let doubleAmount =  Double(amount)
        finalResult  = (selectedRate ?? 0 ) * (doubleAmount ?? 0)
        
        return "\(String(format: NumberFormating.formatTwoDigits,finalResult!)) EUR"
    }
    
}


