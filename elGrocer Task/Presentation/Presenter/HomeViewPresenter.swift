//
//  HomeViewPresenter.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

struct HomeScreenModel {
    var category: Category
    var products: [Product]
}

protocol HomePresenterInputs {
    func getCategories(forRetailer id: Int)
    func getProducts(forCategory categoryID: [Category], retailerID: Int, offset: Int, limit: Int)
}

protocol HomePresenterOutput {
    func homePresenter(categories: [Category])
    func homePresenter(products: [HomeScreenModel])
    func homePresenter(errorMsg: String)
    func homePresenter(showLoader status: Bool)
}

final class HomePresenterImp: HomePresenterInputs {
    
    private var output: HomePresenterOutput
    private var productRepository: ProductRepository
    
    init(output: HomePresenterOutput, productRepository: ProductRepository) {
        self.output = output
        self.productRepository = productRepository
    }
    
    
    func getCategories(forRetailer id: Int) {
        self.productRepository.getCategories(retailer: id) { categories, errorMsg in
            
            if let categories = categories, errorMsg == nil {
                DispatchQueue.main.async { [weak self] in
                    self?.output.homePresenter(categories: categories)
                }
                
                self.getProducts(forCategory: categories, retailerID: id, offset: 0, limit: 10)
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.output.homePresenter(errorMsg: errorMsg ?? "Define a common error msg")
            }
        }
    }
    
    func getProducts(forCategory categoryID: [Category], retailerID: Int, offset: Int, limit: Int) {
        let dispatchGroup = DispatchGroup()
        var models: [HomeScreenModel] = []
        
        self.output.homePresenter(showLoader: true)
        
        categoryID.forEach { category in
            dispatchGroup.enter()
            self.productRepository.getProducts(ofCategory: category.id, retailer: retailerID, offset: offset, limit: limit) { products, errorMsg in
                dispatchGroup.leave()
                if let products = products, errorMsg == nil {
                    models.append(HomeScreenModel(category: category, products: products))
                    return
                }
                
                self.output.homePresenter(errorMsg: errorMsg ?? "Define a common error msg")
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.output.homePresenter(showLoader: false)
            self.output.homePresenter(products: models)
        }
    }
}
