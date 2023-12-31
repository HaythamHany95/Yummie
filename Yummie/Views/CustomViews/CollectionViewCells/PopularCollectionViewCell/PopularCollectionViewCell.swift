//
//  PopularCollectionViewCell.swift
//  Yummie
//
//  Created by Haytham on 02/11/2023.
//

import UIKit

class PopularCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: PopularCollectionViewCell.self)
    
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var descreptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(_ dish: Dish) {
        dishNameLabel.text = dish.name
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        caloriesLabel.text = "\(dish.calories ?? 0 ) calories" 
        descreptionLabel.text = dish.descreption
    }

}
