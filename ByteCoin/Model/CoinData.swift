//
//  CoinData.swift
//  ByteCoin
//
//  Created by John Peterson on 5/7/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    var asset_id_base: String
    var asset_id_quote: String
    var rate: Double
}

