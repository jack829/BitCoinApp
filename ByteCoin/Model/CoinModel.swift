//
//  CoinModel.swift
//  ByteCoin
//
//  Created by John Peterson on 5/7/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    var fromCurrency: String
    var rate: Double
    
    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
