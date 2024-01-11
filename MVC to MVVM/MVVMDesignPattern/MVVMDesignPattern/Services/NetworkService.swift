//
//  NetworkService.swift
//  MVVMDesignPattern
//
//  Created by Jason Pinlac on 4/27/23.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
    var user: User?
    
    private init() {}
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            if email == "Jasonpinlac@gmail.com" && password == "Password" {
                self?.user = User(firstName: "Jason", lastName: "Pinlac", age: 33, email: "jasonpinlac@gmail.com")
                completion(true)
            } else {
                self?.user = nil
                completion(false)
            }
        }
    }
    
    func getLoggedInUser() -> User? {
        return user
    }
    
}
