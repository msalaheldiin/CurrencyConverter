//
//  RatesVC.swift
//  CurrencyConverter
//
//  Created by Mahmoud Salaheldin on 12/23/20.
//  Copyright © 2020 Mahmoud Salaheldin. All rights reserved.
//

import UIKit

class RatesVC: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate =  self
            collectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var rateResultLbl: UILabel!
    
    // MARK: - Variabels
    
    lazy var viewModel = RatesViewModel()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Currency Converter"
        setupViewModel()
        viewModel.getRates()
        
    }
    
    
    // MARK: - SetupViewModel
    
    func setupViewModel() {
        viewModel.showLoadingIndicator = { [weak self] in
            self?.activityIndicator.startAnimating()
        }
        
        viewModel.reloadcollectionView = { [weak self] in
           DispatchQueue.main.async { 
            self?.collectionView.reloadData()
            }
        }
        
        viewModel.hideLoadingIndicator = { [weak self] in
            self?.activityIndicator.startAnimating()
            self?.activityIndicator.isHidden = true
        }
    }
    
    
    //MARK: - Initialization
    
    class func initializeFromStoryboard() -> RatesVC {
        
        let storyboard = UIStoryboard(name: Storyboards.Rates, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: RatesVC.self)) as! RatesVC
    }
    
    
    //MARK: - Actions
    @IBAction func convertButtonPressed(_ sender: Any) {
        rateResultLbl.text = ""
        rateResultLbl.text = viewModel.claculteConvertedAmount(forAmount:amountTF.text ?? "0" )
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        amountTF.text = ""
        rateResultLbl.text = ""
    }
    
}


// MARK: - CollectionViewDataSource

extension RatesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let rateCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RatesCell.self), for: indexPath) as! RatesCell
        
        let itemCurrency = viewModel.itemCurrency(atIndex: indexPath.row)
        let itemRate = viewModel.itemRate(atIndex: indexPath.row)
        rateCell.configureRateCell(itemCurrency: itemCurrency, itemRate: itemRate)
        
        return rateCell
    }
}


// MARK: - CollectionViewDelegate

extension RatesVC:UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         viewModel.selectedRate = viewModel.itemRate(atIndex: indexPath.row)
    }
}

