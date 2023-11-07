//
//  CategoryCollectionViewCell.swift
//  Yummie
//
//  Created by Haytham on 02/11/2023.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: CategoryCollectionViewCell.self)
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func configureCell(_ category: DishCategory) {
        categoryTitleLabel.text = category.name
        categoryImageView.image = category.image
        #warning("make the image string after testing")
//        categoryImageView.kf.setImage(with: category.image.asUrl)
    }

}
