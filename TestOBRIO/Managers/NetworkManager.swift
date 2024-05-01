//
//  NetworkManager.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import UIKit

/// Class to download the current bitcoin price from network
final class NetworkManager {
    
    static func getBitcoinInDollars(completion: @escaping (Double) -> Void) {
        guard let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json") else {
            completion(1)
            return
        }
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(BitcoinResponse.self, from: data)
                completion(result.bpi.USD.rate_float)
            } catch {
                print(error)
            }
            
        }
        dataTask.resume()
        completion(1)
        return
    }
    
}
