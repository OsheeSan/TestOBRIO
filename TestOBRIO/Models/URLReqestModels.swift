//
//  URLReqestModels.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import Foundation

// MARK: - BitcoinResponse
struct BitcoinResponse: Decodable {
    let bpi: Bpi
}

// MARK: - Bpi
struct Bpi: Decodable {
    let USD: Exchange
}

// MARK: - Exchange
struct Exchange: Decodable {
    let code, symbol, rate, description: String
    let rate_float: Double
}
