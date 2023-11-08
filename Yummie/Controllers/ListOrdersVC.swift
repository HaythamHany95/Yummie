//
//  ListOrdersVC.swift
//  Yummie
//
//  Created by Haytham on 06/11/2023.
//

import UIKit

class ListOrdersVC: UIViewController {

    var orders: [Order] = [Order(id: "113", name: "Haytham Hany", dish: Dish(id: "11", name: "Koshari", image:"https://picsum.photos/100/200", calories: 600,                                         descreption: "Most popular delicious dish allover the Egypt "))]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Orders"
        tableView.delegate = self
        tableView.dataSource = self
        
        registerCell()
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
}

extension ListOrdersVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier, for: indexPath) as? DishListTableViewCell else { return UITableViewCell() }
        cell.configureCell(orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: DishDetailsVC.identifier) as! DishDetailsVC
        vc.dish = orders[indexPath.row].dish
        navigationController?.pushViewController(vc, animated: true)
    }
}
