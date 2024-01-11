//
//  ViewController.swift
//  MVCDesignPattern
//
//  Created by Jason Pinlac on 4/27/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let welcomeBackLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton(configuration: .filled())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "MVC LoginVC"
        view.backgroundColor = .systemBackground
        setupSubviews()
    }

    
    func setupSubviews() {
        welcomeBackLabel.text = "Welcome Back"
        welcomeBackLabel.textColor = .label
        welcomeBackLabel.textAlignment = .center
        
        emailTextField.borderStyle = .bezel
        emailTextField.placeholder = "Email"
        emailTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(validateFields), for:  .editingChanged)
        
        passwordTextField.borderStyle = .bezel
        passwordTextField.placeholder = "Password"
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(validateFields), for:  .editingChanged)
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.isEnabled = false
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    
        let subviews = [welcomeBackLabel, emailTextField, passwordTextField, loginButton]

        subviews.forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        
        NSLayoutConstraint.activate([
            welcomeBackLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            welcomeBackLabel.heightAnchor.constraint(equalToConstant: 50),
            welcomeBackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeBackLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: welcomeBackLabel.bottomAnchor, constant: 50),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 50),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
        ])
    }
    
    @objc private func validateFields() {
        loginButton.isEnabled = !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty
    }
    
    @objc func loginButtonTapped() {
        NetworkService.shared.login(email: emailTextField.text!, password: passwordTextField.text!, completion: { [weak self] result in
            switch result {
            case true:
                let homeViewController = HomeViewController()
                self?.navigationController?.pushViewController(homeViewController, animated: true)
            case false:
                let alertController = UIAlertController(title: "Login Failed", message: "The credentials you entered are incorrect. Try agagin.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Dismiss", style: .cancel)
                alertController.addAction(alertAction)
                self?.present(alertController, animated: true)
            }
        })
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
