//
//  MatchFlagsAndCountriesGame.swift
//  FunGeography
//
//  Created by arta.zidele on 29/04/2021.
//

import Foundation
import UIKit

class MatchFlagsAndCountriesGame {
    func isWon(_ countries: [Card]) -> Bool {
        var allMatched = true
        for card in countries {
            if card.isMatched == false {
                allMatched = false
                break
            }
        }
        if allMatched == true {
            return true
        } else {
            return false
        }
    }
}
