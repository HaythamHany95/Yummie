//
//  HomeVC.swift
//  Yummie
//
//  Created by Haytham on 01/11/2023.
//

import UIKit

class HomeVC: UIViewController {
    
    #warning("make the image string after testing")
    var categories: [DishCategory] = [DishCategory(id: "1", name: "Egyptian Dishes", image: UIImage(named: "test1")!),
                                      DishCategory(id: "1", name: "African Dishes", image: UIImage(named: "test2")!),
                                      DishCategory(id: "1", name: "Asian Dishes", image: UIImage(named: "test3")!),
                                      DishCategory(id: "1", name: "Latino Dishes", image: UIImage(named: "test5")!),
                                      DishCategory(id: "1", name: "Moroccian Dishes", image: UIImage(named: "test4")!)]
    var popularDishes: [Dish] = [Dish(id: "11", name: "Koshari", image: UIImage(named: "test1"), calories: 600,                                         descreption: "Most popular delicious dish allover the Egypt "),
                                 Dish(id: "22", name: "Mahshi", image: UIImage(named: "test2"), calories: 1000, descreption: "A very respected dish in most occasions"),
                                 Dish(id: "33", name: "Bassta", image: UIImage(named: "test3"), calories: 1500, descreption: "Very quick and delisious meal")]
    var speacials: [Dish] = [Dish(id: "11", name: "Koshari", image: UIImage(named: "test1"), calories: 600,                                         descreption: "Most popular delicious dish allover the Egypt "),
                             Dish(id: "22", name: "Mahshi", image: UIImage(named: "test2"), calories: 1000, descreption: "A very respected dish in most occasions"),
                             Dish(id: "33", name: "Bassta", image: UIImage(named: "test3"), calories: 1500, descreption: "talian pasta is a collective name for food made from wheat flour and water. The name refers to the resulting dough (pasta also literally means 'dough') of which different shapes are rolled and cut. Pasta is boiled in water and served with a sauce.")]
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var specialCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyCollectionDelegates()
        registerCell()
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    
    private func registerCell() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularCollectionView.register(UINib(nibName: PopularCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PopularCollectionViewCell.identifier)
        specialCollectionView.register(UINib(nibName: SpecialCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SpecialCollectionViewCell.identifier)
    }
    
    private func applyCollectionDelegates() {
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        specialCollectionView.delegate = self
        specialCollectionView.dataSource = self
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case categoryCollectionView:
            return categories.count
            
        case popularCollectionView:
            return popularDishes.count
            
        case specialCollectionView:
            return speacials.count
            
        default:
            return 1
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            
        case categoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return  UICollectionViewCell() }
            cell.configureCell(categories[indexPath.row])
            return cell
            
        case popularCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCollectionViewCell.identifier, for: indexPath) as? PopularCollectionViewCell else { return  UICollectionViewCell() }
            cell.configureCell(popularDishes[indexPath.row])
            return cell
            
        case specialCollectionView:
            guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: SpecialCollectionViewCell.identifier, for: indexPath) as? SpecialCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(speacials[indexPath.row])
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == categoryCollectionView {
            let vc = storyboard?.instantiateViewController(withIdentifier: DishListVC.identifier) as! DishListVC
            
            ///*To make the navigationBar "title" equal to the particular item we tapped on , so it can be viewed as  "title" of DishListVC
            vc.category = categories[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
            
        } else {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: DishDetailsVC.identifier) as! DishDetailsVC
            
            ///*To load the variable "dish" with the particular item we tapped on, so it can be viewed on DishDetailsVC
            vc.dish = collectionView == popularCollectionView ? popularDishes[indexPath.row] : speacials[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
}
