//
//  WeatherResponse.swift
//  WeatherMars
//
//  Created by Matteo Fusilli on 30/05/2020.
//  Copyright © 2020 Matteo Fusilli. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    let sol: SOL
    let sol_keys: [String]?
    
    enum TopLevelCodingKeys: String, CodingKey {
        case sol
    }
}

struct SOL: Codable {
    let at: AT
    let Season: String
    let Wd: WD
}

struct AT: Codable {
    let av: Float
    let mn: Float
    let mx: Float
}

struct WD: Codable {
    let most_common: MostCommon
}

struct MostCommon: Codable {
    let compass_point: String
}


