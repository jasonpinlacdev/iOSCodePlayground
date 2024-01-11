//
//  HomeViewController.swift
//  MVCDesignPattern
//
//  Created by Jason Pinlac on 4/27/23.
//

import UIKit


class HomeViewController: UIViewController {
    
    var welcomeLabel = UILabel()
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MVC HomeVC"
        view.backgroundColor = .systemBackground
        user = NetworkService.shared.getLoggedInUser()
        setupSubviews()
        
    }
    
    func setupSubviews() {
        welcomeLabel.text = "Welcome, \(user?.firstName ?? "Unknown")!"
        welcomeLabel.textColor = .label
        welcomeLabel.textAlignment = .center
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        
        NSLayoutConstraint.activate([
            welcomeLabel.heightAnchor.constraint(equalToConstant: 50),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
}
