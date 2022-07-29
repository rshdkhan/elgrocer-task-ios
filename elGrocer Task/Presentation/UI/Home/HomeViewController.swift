//
//  ViewController.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 27/07/2022.
//

import UIKit
import ProgressHUD

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var storedOffsets = [Int: CGFloat]()
    private var categories: [Category] = []
    private var homeScreenModels: [HomeScreenModel] = []
    private let refreshControl = UIRefreshControl()
    private var presenter: HomePresenterInputs!
    
    private lazy var emptyView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .blue
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table view setup
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        
        self.tableView.register(UINib(nibName: HomeTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.identifier)
        self.tableView.register(UINib(nibName: HomeTableViewHeader.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: HomeTableViewHeader.identifier)
        self.tableView.separatorColor = .clear
        
        // pull to refresh
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        // resolving dependencies
        let network = NetworkClientImp(urlSession: URLSession(configuration: .default), responseHandler: ResponseHandlerImp())
        let repository = ProductRepositoryImp(networkClient: network)
        self.presenter = HomePresenterImp(output: self, productRepository: repository)
        
        // fetch categories
        presenter.getCategories(forRetailer: 16)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        presenter.getCategories(forRetailer: 16)
    }
}

// MARK: - Presenter Output
extension HomeViewController: HomePresenterOutput {
    func homePresenter(products: [HomeScreenModel]) {
        self.refreshControl.endRefreshing()
        
        self.homeScreenModels = products
        self.tableView.reloadData()
    }
    
    func homePresenter(categories: [Category]) {
        self.categories = categories
        
        
        DispatchQueue.main.async {
            self.tableView.reloadSections([0], with: .automatic)
        }
    }
    
    func homePresenter(showLoader status: Bool) {
        if status {
            ProgressHUD.show()
        } else {
            ProgressHUD.dismiss()
            self.refreshControl.endRefreshing()
        }
    }
    
    func homePresenter(errorMsg: String) {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
        print("failed with some error >> \(errorMsg)")
    }
}

// MARK: - Table view delegate and datasource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeScreenModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        
        cell.configure(category: homeScreenModels[indexPath.row].category, product: homeScreenModels[indexPath.row].products)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeTableViewHeader.identifier) as! HomeTableViewHeader
        
        header.configure(categories: self.categories)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? HomeTableViewCell else { return }

        storedOffsets[indexPath.row] = cell.collectionViewOffset
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.width / 1.4) + 40
    }
}

