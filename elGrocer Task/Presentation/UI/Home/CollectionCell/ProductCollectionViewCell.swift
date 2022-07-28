//
//  ProductCollectionViewCell.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier: String = "ProductCollectionViewCell"
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var ivProductImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUnit: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    func configure(product: Product) {
        ivProductImage.sd_setImage(with: URL(string: product.imageURL), placeholderImage: UIImage(named: "categories-placeholder"))
        lblName.text = product.name
        lblUnit.text = product.sizeUnit
        lblPrice.text = product.priceCurrency + " " + String(product.fullPrice)
    }
}
