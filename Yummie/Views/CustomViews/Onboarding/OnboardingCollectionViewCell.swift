//
//  OnboardingCollectionViewCell.swift
//  Yummie
//
//  Created by Haytham on 01/11/2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
   static let identifier = String(describing: OnboardingCollectionViewCell.self)
   
    //MARK: - IBOutlet

    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
     func configureCollectionCell(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
    
    
    
    
}
