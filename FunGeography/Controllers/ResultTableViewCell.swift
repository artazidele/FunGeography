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
    
    func setUI(with: User, place: Int) {
        placeLabel.text = String(place)
        usernameLabel.text = with.username
        pointsLabel.text = String(with.result)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
