//
//  HomeVC.swift
//  Yummie
//
//  Created by Haytham on 01/11/2023.
//

import UIKit
import ProgressHUD

class HomeVC: UIViewController {
    
    var categories: [DishCategory] = []
    var popularDishes: [Dish] = []
    var speacials: [Dish] = []
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var specialCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .label
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        applyCollectionDelegates()
        registerCell()
        ProgressHUD.show()
        
        fetchAllCategories()
    }
    
    private func fetchAllCategories() {
        NetworkManager.shared.fetchAllCategories { [weak self] results in
            switch results {
                
            case .success(let allDishes):
                ProgressHUD.dismiss()
                ///*To delete the "Nigerian Dishes" category from the collectionView
               //self?.categories = allDishes.categories!.filter { $0.name != "Nigerian Dishes" }
                self?.categories = allDishes.categories ?? []
                self?.popularDishes = allDishes.populars ?? []
                self?.speacials = allDishes.specials ?? []
                
                self?.categoryCollectionView.reloadData()
                self?.popularCollectionView.reloadData()
                self?.specialCollectionView.reloadData()

                
            case .failure(let error):
                ProgressHUD.showError(error.localizedDescription)
                
            }
        }
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
