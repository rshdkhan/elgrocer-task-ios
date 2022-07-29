//
//  SplashPresenter.swift
//  elGrocer Task
//
//  Created by Rashid Khan on 28/07/2022.
//

import Foundation

protocol SplashPresenterInputs {
    func refreshToken()
}

protocol SplashPresenterOutput {
    func splashPresenter(refreshToken: RefreshTokenResponse)
    func splashPreseter(errorMsg: String)
}

final class SplashViewPresenter: SplashPresenterInputs {
    private var tokenRepository: TokenRepository
    private var output: SplashPresenterOutput
    
    init(tokenRepository: TokenRepository, output: SplashPresenterOutput) {
        self.tokenRepository = tokenRepository
        self.output = output
    }
    
    func refreshToken() {
        self.tokenRepository.refreshToken { refreshToken, errorMsg in
            
            DispatchQueue.main.async {
                
                if let refreshToken = refreshToken, errorMsg == nil {
                    Session.instance.create(tokenResponse: refreshToken)
                    self.output.splashPresenter(refreshToken: refreshToken)
                    return
                }
                
                self.output.splashPreseter(errorMsg: errorMsg ?? "Define a common error msg")
            }
        }
    }
}
