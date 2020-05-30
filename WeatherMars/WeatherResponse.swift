//
//  WeatherResponse.swift
//  WeatherMars
//
//  Created by Matteo Fusilli on 30/05/2020.
//  Copyright © 2020 Matteo Fusilli. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    let SOL: AT
    let Season: String
    let WD: WD
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


