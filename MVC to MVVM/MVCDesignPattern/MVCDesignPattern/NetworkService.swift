//
//  NetworkService.swift
//  MVCDesignPattern
//
//  Created by Jason Pinlac on 4/27/23.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    var user: User?
    
    private init() {}
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().async {
            sleep(1)
            if email == "Jasonpinlac@gmail.com" && password == "Password" {
                DispatchQueue.main.async { [weak self] in
                    self?.user = User(firstName: "Jason", lastName: "Pinlac", email: "jasonpinlac@gmail.com", location: Location(lat: 5.0, lng: 7.0))
                    completion(true)
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.user = nil
                    completion(false)
                }
            }
        }
    }
    
    func getLoggedInUser() -> User? {
        return user
    }
    
}
