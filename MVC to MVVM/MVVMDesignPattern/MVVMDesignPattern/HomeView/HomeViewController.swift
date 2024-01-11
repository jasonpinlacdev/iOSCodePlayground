//
//  HomeViewController.swift
//  MVVMDesignPattern
//
//  Created by Jason Pinlac on 4/27/23.
//

import UIKit


class HomeViewController: UIViewController {
    
    var welcomeLabel = UILabel()
    
    let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MVVM HomeVC"
        view.backgroundColor = .systemBackground
        setupSubviews()
        setupBindings()
        viewModel.getLoggedInUser()
    }
    
    func setupBindings() {
        viewModel.loggedInUser.bind { [weak self] user in
            guard let user = user else { return }
            self?.welcomeLabel.text = "Welcome, \(user.firstName) \(user.lastName)!"
        }
    }
    
    func setupSubviews() {
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
