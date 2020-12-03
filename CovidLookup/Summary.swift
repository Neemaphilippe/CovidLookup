//
//  Summary.swift
//  CovidLookup
//
//  Created by Neema on 12/3/20.
//  Copyright © 2020 Neema Philippe. All rights reserved.
//

import Foundation
//create a country and SummaryWrapper model
//country name, total recovered, total confirmed


struct SummaryWrapper: Codable {
    let countries: [Summary]
    
    //CodingKeys allows us to rename properties
    enum CodingKeys: String, CodingKey {
        case countries = "Countries"
    }
}

struct Summary : Codable {
    let country: String
    let totalConfrimed: Int
    let totalRecovered: Int
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case totalConfrimed = "TotalConfirmed"
        case totalRecovered = "TotalRecovered"
    }
    
}
