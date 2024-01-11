//
//  LoginViewModel.swift
//  MVVMDesignPattern
//
//  Created by Jason Pinlac on 4/27/23.
//

import Foundation

class LoginViewModel {
    
    var isSuccessfulLogin: ObservableObject<Bool?> = ObservableObject(value: nil)
    
    func login(email: String, password: String) {
        NetworkService.shared.login(email: email, password: password) { [weak self] result in
            self?.isSuccessfulLogin.value = result
        }
    }
}
