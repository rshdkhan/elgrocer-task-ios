//
//  HomeTableViewCell.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 27/07/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblCaregoryTitle: UILabel!
    
    static let identifier: String = "HomeTableViewCell"
    var products: [Product] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: ProductCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
    }
    
    func configure(category: Category, product: [Product]) {
        lblCaregoryTitle.text = category.name
        self.products = product
        self.collectionView.reloadData()
    }
}

extension HomeTableViewCell {
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}

//MARK: - Collection view delegate and datasource
extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
            
        cell.configure(product: products[indexPath.row])
        return cell
    }
}

// MARK: - Collection view flow layout delegate
extension HomeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.width / 1.5)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  16
    }
}
