//
//  DishListTableViewCell.swift
//  Yummie
//
//  Created by Haytham on 06/11/2023.
//

import UIKit

class DishListTableViewCell: UITableViewCell {
    static let identifier = String(describing: DishListTableViewCell.self)
    
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configureCell(_ dish: Dish) {
        dishNameLabel.text = dish.name
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        descriptionLabel.text = dish.descreption
    }
    
    func configureCell(_ order: Order) {
        dishImageView.kf.setImage(with: order.dish?.image?.asUrl)
        dishNameLabel.text = order.dish?.name
        descriptionLabel.text = order.name
    }
}
