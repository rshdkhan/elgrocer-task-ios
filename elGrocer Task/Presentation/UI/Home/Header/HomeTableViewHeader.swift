//
//  HomeTableViewHeader.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 29/07/2022.
//

import UIKit

class HomeTableViewHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var categories: [Category] = []
    static let identifier: String = "HomeTableViewHeader"
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnViewAll: UIButton!
    
    override func awakeFromNib() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: CategoryCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
    }
    
    func configure(categories: [Category]) {
        lblTitle.isHidden = categories.count == 0
        btnViewAll.isHidden = categories.count == 0
        
        self.categories = categories
        self.collectionView.reloadData()
    }
}

//MARK: - Collection view delegate and datasource
extension HomeTableViewHeader: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
            
        cell.configure(category: self.categories[indexPath.row])
        return cell
    }
}

// MARK: - Collection view flow layout delegate
extension HomeTableViewHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.width / 4)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
