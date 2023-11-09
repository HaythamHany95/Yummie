//
//  DishDetailsVC.swift
//  Yummie
//
//  Created by Haytham on 06/11/2023.
//

import UIKit
import ProgressHUD

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
        
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespaces),
              !name.isEmpty else {
            
            ProgressHUD.showError("Please Enter Your Name")
            return
        }
        
        ProgressHUD.show("Placing order..")
        
        guard let dishId = dish?.id else { return }
        NetworkManager.shared.placeOrder(dishId: dishId, name: name) { result in
            switch result {
                
            case .success( _):
                ProgressHUD.showSuccess("Your order has been received.👨‍🍳")
                
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
        
    }
    
    private func configureDish() {
        dishImageView.kf.setImage(with: dish?.image?.asUrl)
        dishNameLabel.text = dish?.name
        caloriesLabel.text = "\(dish?.calories ?? 0 ) calories"
        descriptionLabel.text = dish?.descreption
    }
    
}
