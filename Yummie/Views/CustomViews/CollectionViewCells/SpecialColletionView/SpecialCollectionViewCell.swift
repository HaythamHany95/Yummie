//
//  SpecialCollectionViewCell.swift
//  Yummie
//
//  Created by Haytham on 05/11/2023.
//

import UIKit

class SpecialCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: SpecialCollectionViewCell.self)
    
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var descreptionLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ dish: Dish) {
        dishNameLabel.text = dish.name
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        caloriesLabel.text = "Calories \(dish.calories ?? 0 )"
        descreptionLabel.text = dish.descreption
    }

}
