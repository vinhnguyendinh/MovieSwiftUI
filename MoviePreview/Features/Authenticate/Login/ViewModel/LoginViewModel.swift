//
//  LoginViewModel.swift
//  MoviePreview
//
//  Created by Vinh Nguyen Dinh on R 2/11/09.
//

import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    // MARK: - Properties
    @Published var isLoading: Bool = false
    @Published var isLogedIn: Bool = false
    @Published var isShowRegister: Bool = false

    @Published var username: String = ""
    @Published var password: String = ""
    @Published var requestToken: String = ""
    
    private var cancellables: [AnyCancellable] = []

    // MARK: - Life cycle
    init() {
        self.$requestToken
            .sink { [weak self] requestToken in
                self?.login(requestToken)
            }
            .store(in: &self.cancellables)
    }
    
    // MARK: - Handlers
    
    /// Create request token to login
    func createRequestToken() {
        guard !self.username.isEmpty,
              !self.password.isEmpty else {
            return
        }
        
        self.isLoading = true
        
        authenticateProvider.request(.createRequestToken) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let response):
                if let json = try? response.mapJSON() as? [String: Any],
                   let requestTokenStr = json["request_token"] as? String {
                    strongSelf.requestToken = requestTokenStr
                }
                break
                
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
            
            strongSelf.isLoading = false
        }
    }
    
    /// Login with email, password
    /// and request toekn
    func login(_ requestToken: String) {
        guard !self.username.isEmpty,
              !self.password.isEmpty,
              !requestToken.isEmpty else {
            return
        }
        
        self.isLoading = true
        
        authenticateProvider.request(.login(username: self.username, password: self.password, requestToken: self.requestToken)) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let response):
                if let json = try? response.mapJSON() as? [String: Any] {
                    print(json)
                }
                strongSelf.isLogedIn = true
                break
                
            case .failure(let error):
                strongSelf.isLogedIn = false
                print(error.localizedDescription)
                break
            }
            
            strongSelf.isLoading = false
        }
    }
}
