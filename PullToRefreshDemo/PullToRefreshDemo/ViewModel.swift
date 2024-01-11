//
//  ViewModel.swift
//  PullToRefreshDemo
//
//  Created by Jason Pinlac on 1/11/24.
//

import Foundation

enum reponseType {
    case one
    case two
}

enum ViewModelEvent {
    case refreshNamesCompleted
}

class ViewModel {
    
    var model: Model
    var handler: ((ViewModelEvent) -> Void)?
    
    var reponseType: reponseType = .two
    
    init(model: Model) {
        self.model = model
    }
    
    func refreshNames() {
        // mock a request to get new names
        // request takes 3 seconds for data to come back
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) { [weak self] in
            // toggle the response type
            if self?.reponseType == .one {
                self?.reponseType = .two
            } else {
                self?.reponseType = .one
            }
            
            let responseModel: Model
            switch self?.reponseType {
            case .one:
                responseModel = Model(names: [
                    "Jason Pinlac",
                    "Michael Pinlac",
                    "David Pinlac"])
            case .two:
                responseModel = Model(names: [
                    "Tyler Byrd",
                    "Andrew Byrd",
                    "Dana Byrd",
                    "Penny Byrd"
                ])
            default:
                responseModel = Model(names: [])
            }
            
            self?.model = responseModel
            self?.handler?(.refreshNamesCompleted)
        }
    }
    
}
