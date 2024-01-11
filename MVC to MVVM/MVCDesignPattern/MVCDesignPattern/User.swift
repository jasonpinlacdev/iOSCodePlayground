//
//  User.swift
//  MVCDesignPattern
//
//  Created by Jason Pinlac on 4/27/23.
//

import Foundation

struct User {
    let firstName: String
    let lastName: String
    let email: String
    let location: Location
}

struct Location {
    let lat: Double
    let lng: Double
}
