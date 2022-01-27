//
//  CustomTableViewCell.swift
//  TestAssignment
//
//  Created by Дмитрий Куприенко on 27.01.2022.
//

import UIKit
import SDWebImage

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    private let transformer = SDImageResizingTransformer(size: CGSize(width: 150, height: 150), scaleMode: .fill)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(dataToDisplay: Results) {
        
        let firstName = dataToDisplay.name?.first ?? ""
        let lastName = dataToDisplay.name?.last ?? ""
        let age = dataToDisplay.dob?.age ?? 0
        let gender = dataToDisplay.gender?.capitalized
        self.avatarImageView.sd_setImage(with: URL(string: dataToDisplay.picture?.large ?? ""),
                                         placeholderImage: UIImage(named: "empty"), context: [.imageTransformer: transformer])
        self.avatarImageView.layer.cornerRadius = 75
        self.nameLabel.text = firstName + " " + lastName
        self.ageLabel.text = (String(describing: age)) + yearsOldString
        self.genderLabel.text = gender
        self.countryLabel.text = dataToDisplay.location?.country
    }
}
