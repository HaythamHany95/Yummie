//
//  DishDetailsVC.swift
//  Yummie
//
//  Created by Haytham on 06/11/2023.
//

import UIKit

class DishDetailsVC: UIViewController {
    static let identifier = String(describing: DishDetailsVC.self)
    
    var dish: Dish?
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDish()

    }
    

    @IBAction func placeOrderTapped(_ sender: UIButton) {
    }
    

    private func configureDish() {
        dishImageView.kf.setImage(with: dish?.image?.asUrl)
        dishNameLabel.text = dish?.name
        caloriesLabel.text = "Calories \(dish?.calories ?? 0 )"
        descriptionLabel.text = dish?.descreption
    }
    
}
