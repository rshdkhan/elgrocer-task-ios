//
//  CategoryCollectionViewCell.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 27/07/2022.
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewContainer: UIView!
    
    @IBOutlet weak var ivCategoryImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    static var reuseIdentifier: String = "CategoryCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(category: Category) {
        ivCategoryImage.sd_setImage(with: URL(string: category.photoUrl), placeholderImage: UIImage(named: "categories-placeholder"))
        lblTitle.text = category.name
    }

}
