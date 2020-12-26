//
//  APIResponseModel.swift
//  CurrencyConverter
//
//  Created by Mahmoud Salaheldin on 12/23/20.
//  Copyright © 2020 Mahmoud Salaheldin. All rights reserved.
//

import UIKit
import AnyCodable

class APIResponseModel: BaseModel, Codable {
       var success: Bool?
       var timestamp: Int?
       var base: String?
       var date: String?
       var rates: Rates?
}

