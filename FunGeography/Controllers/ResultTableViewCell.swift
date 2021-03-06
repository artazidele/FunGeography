//
//  ResultTableViewCell.swift
//  FunGeography
//
//  Created by arta.zidele on 26/04/2021.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    func setUI(with: User, place: Int, result: Int) {
        placeLabel.text = String(place)
        usernameLabel.text = with.username
        pointsLabel.text = String(with.result)
        if (result == place) {
            contentView.backgroundColor = .lightGray
        }
    }
}
