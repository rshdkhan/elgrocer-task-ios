//
//  ViewController.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 27/07/2022.
//

import UIKit
import ProgressHUD

enum CellType: Int {
    case category = 0
    case product
}

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var storedOffsets = [Int: CGFloat]()
    private var categories: [Category] = []
    private var products: [[Product]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        
        self.tableView.register(UINib(nibName: HomeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.identifier)
        self.tableView.separatorColor = .clear
        
        let config = URLSessionConfiguration.default
                
                let cache = URLCache(memoryCapacity: 500_000_000, diskCapacity: 1_000_000_000)
                config.urlCache = cache
                config.requestCachePolicy = .useProtocolCachePolicy
        
        config.requestCachePolicy = .returnCacheDataElseLoad
        
        let network = NetworkClientImp(urlSession: URLSession(configuration: config), responseHandler: ResponseHandlerImp())
        let repository = ProductRepositoryImp(networkClient: network)
        let homePresenter = HomePresenterImp(output: self, productRepository: repository)
        homePresenter.getCategories(forRetailer: 16)
    }
}

// MARK: - Presenter Output
extension HomeViewController: HomePresenterOutput {
    func homePresenter(products: [[Product]]) {
        self.products = products
        self.tableView.reloadData()
    }
    
    func homePresenter(categories: [Category]) {
        self.categories = categories
        
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
    }
    
    func homePresenter(showLoader status: Bool) {
        if status {
            ProgressHUD.show()
        } else {
            ProgressHUD.dismiss()
        }
    }
    
    func homePresenter(errorMsg: String) {
        print("failed with some error >> \(errorMsg)")
    }
}

// MARK: - Table view delegate and datasource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? HomeTableViewCell else { return }
        cell.setCollectionViewDataSourceAndDelegate(dataSourceDelegate: self, forRow: indexPath.row)
        cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? HomeTableViewCell else { return }

        storedOffsets[indexPath.row] = cell.collectionViewOffset
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 160 : (self.view.frame.width / 1.4) + 40
    }
}

//MARK: - Collection view delegate and datasource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.tag == 0 ? categories.count : products[collectionView.tag - 1].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
            
            cell.configure(category: categories[indexPath.row])
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
                
            cell.configure(product: products[collectionView.tag - 1][indexPath.row])
            return cell
        }
    }
}

// MARK: - Collection view flow layout delegate
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.width / 4)
        }
        
        return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.width / 1.5)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.tag == 0 ? 0 : 16
    }
}
