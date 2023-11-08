//
//  DishListVC.swift
//  Yummie
//
//  Created by Haytham on 06/11/2023.
//

import UIKit

class DishListVC: UIViewController {
    static let identifier = String(describing: DishListVC.self)
    
    var category: DishCategory?
    var dishes: [Dish] = [Dish(id: "11", name: "Koshari", image:"https://picsum.photos/100/200", calories: 600,                                         descreption: "Most popular delicious dish allover the Egypt "),
                          Dish(id: "22", name: "Mahshi", image:"https://picsum.photos/100/200", calories: 1000, descreption: "A very respected dish in most occasions"),
                          Dish(id: "33", name: "Bassta", image:"https://picsum.photos/100/200", calories: 1500, descreption: "Very quick and delisious meal")]
  
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category?.name
        tableView.delegate = self
        tableView.dataSource = self

        registerCell()
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
