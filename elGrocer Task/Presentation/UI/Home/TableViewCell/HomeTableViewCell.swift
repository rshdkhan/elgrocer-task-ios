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
    
    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.register(UINib(nibName: CategoryCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        collectionView.register(UINib(nibName: ProductCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
    }
    
    func configure(category: Category) {
        lblCaregoryTitle.text = category.name
    }
}

extension HomeTableViewCell {
    func setCollectionViewDataSourceAndDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        
        collectionView.setContentOffset(collectionView.contentOffset, animated: false) 
        collectionView.reloadData()
    }

    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}
