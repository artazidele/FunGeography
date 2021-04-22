//
//  RegionTableViewCell.swift
//  FunGeography
//
//  Created by arta.zidele on 20/04/2021.
//

import UIKit

class RegionTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var regionImage: UIImageView!
    
    @IBOutlet weak var regionLabel: UILabel!
    
    func setUI(with: String) {
        regionLabel.text = with
        regionImage.image = UIImage(named: "\(with).png")
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
