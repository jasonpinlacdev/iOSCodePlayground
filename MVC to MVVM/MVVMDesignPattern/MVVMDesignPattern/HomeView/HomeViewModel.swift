//
//  HomeViewModel.swift
//  MVVMDesignPattern
//
//  Created by Jason Pinlac on 4/27/23.
//

import Foundation

class HomeViewModel {
    
    var loggedInUser: ObservableObject<User?> = ObservableObject(value: nil)
    
    func getLoggedInUser() {
        self.loggedInUser.value = NetworkService.shared.getLoggedInUser()
    }
}
