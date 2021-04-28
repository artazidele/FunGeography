//
//  RegionTableViewCell.swift
//  FunGeography
//
//  Created by arta.zidele on 20/04/2021.
//

import UIKit

class RegionTableViewCell: UITableViewCell {
    @IBOutlet weak var regionLabel: UILabel!
    func setUI(with: String) {
        regionLabel.text = with
    }
}
