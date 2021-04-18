//
//  Card.swift
//  FunGeography
//
//  Created by arta.zidele on 17/04/2021.
//

import Foundation

class Card {
    
    var country: String?
    var text = 0
    var imageName: String?
    var isFlipped = false
    var isMatched = false
}

struct Country: Decodable {
    let name: String
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case imageUrl = "FlagPng"
    }
    
}


struct Game: Decodable {
    let response: [Country]
    enum CodingKeys: String, CodingKey {
        case response = "Response"
    }
}
