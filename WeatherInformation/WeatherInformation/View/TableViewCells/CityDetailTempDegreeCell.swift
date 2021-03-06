//
//  CityDetailTempDegreeCell.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 17/12/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit

class CityDetailTempDegreeCell: UICollectionViewCell {
    
    //MARK: - Outlets and Variables
    @IBOutlet weak var backgroundContainerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempDegreeLabel: UILabel!
    @IBOutlet weak var tempDiscriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundContainerView.layer.cornerRadius = 5
        backgroundContainerView.layer.shadowColor = UIColor.white.cgColor
        backgroundContainerView.layer.shadowOpacity = 0.1
        backgroundContainerView.layer.shadowOffset = .zero
        backgroundContainerView.layer.shadowRadius = 5
    }
    
}
