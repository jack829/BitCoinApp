//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoin(coinModel: CoinModel)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "1D5F81B1-F6E8-4E0D-982B-A9AD91C9023D"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        sendRequest(urlString: urlString)
    }
    
    func sendRequest(urlString: String) {
        print(urlString)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let coinModel = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCoin(coinModel: coinModel)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let fromCurrency = decodedData.asset_id_quote
            let rate = decodedData.rate
            
            let coinModel = CoinModel(fromCurrency: fromCurrency, rate: rate)
            return coinModel
        } catch {
            print(error)
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
}
