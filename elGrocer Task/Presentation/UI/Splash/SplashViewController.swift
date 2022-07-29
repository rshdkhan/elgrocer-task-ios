//
//  SplashViewController.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let network = NetworkClientImp(urlSession: URLSession(configuration: .default), responseHandler: ResponseHandlerImp())
        let tokenRepository = TokenRepositoryImp(networkClient: network)
        let splashPresenter: SplashPresenterInputs = SplashViewPresenter(tokenRepository: tokenRepository, output: self)
        
//        if Session.instance.isValid {
            if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
                scene.changeRootVC(rootVC: homeVC)
            }
//        } else {
//            print("token required")
////            splashPresenter.refreshToken()
//        }
        
        print("isValid >>", Session.instance.isValid)
    }
}

extension SplashViewController: SplashPresenterOutput {
    func splashPresenter(refreshToken: RefreshTokenResponse) {
        DispatchQueue.main.async {
            if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
                scene.changeRootVC(rootVC: homeVC)
            }
        }
    }
    
    func splashPreseter(errorMsg: String) {
        // display error msg
    }
}
