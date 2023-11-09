//
//  DishListVC.swift
//  Yummie
//
//  Created by Haytham on 06/11/2023.
//

import UIKit
import ProgressHUD

class DishListVC: UIViewController {
    static let identifier = String(describing: DishListVC.self)
    
    var category: DishCategory?
    var dishes: [Dish] = []
  
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category?.name
        tableView.delegate = self
        tableView.dataSource = self
        registerCell()
        ProgressHUD.show()
        
        fetchCategoryDishes()
    }
    
    private func fetchCategoryDishes() {
        guard let categoryId = category?.id else { return }
        NetworkManager.shared.fetchCategoryDishes(categoryId: categoryId) { [weak self] result in
            switch result {
           
            case .success(let dishes):
                ProgressHUD.dismiss()
                
                self?.dishes = dishes
                self?.tableView.reloadData()
            
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
 
}


extension DishListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier, for: indexPath) as? DishListTableViewCell else { return UITableViewCell() }
        cell.configureCell(dishes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: DishDetailsVC.identifier) as! DishDetailsVC
        vc.dish = dishes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
