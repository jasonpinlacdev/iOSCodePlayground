//
//  ViewController.swift
//  MVVMDesignPattern
//
//  Created by Jason Pinlac on 4/27/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let welcomeBackLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton(configuration: .filled())
    
    let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "MVVM LoginVC"
        view.backgroundColor = .systemBackground
        setupSubviews()
        setupBindings()
    }
    
    
    @objc func loginButtonTapped() {
        viewModel.login(email: emailTextField.text!, password: passwordTextField.text!)
    }

    func setupBindings() {
        viewModel.isSuccessfulLogin.bind { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case true:
                    let homeViewController = HomeViewController()
                    self?.navigationController?.pushViewController(homeViewController, animated: true)
                case false:
                    let alertController = UIAlertController(title: "Invalid Login", message: "The credentials entered are incorrect. Try again.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Dismiss", style: .cancel)
                    alertController.addAction(action)
                    self?.present(alertController, animated: true)
                default:
                    break
                }
            }
        }
    }
    
    func setupSubviews() {
        welcomeBackLabel.text = "Welcome Back"
        welcomeBackLabel.textColor = .label
        welcomeBackLabel.textAlignment = .center
        
        emailTextField.borderStyle = .bezel
        emailTextField.placeholder = "Email"
        emailTextField.delegate = self
        emailTextField.addTarget(self, action: #selector(validateTextfields), for: .editingChanged)
        
        passwordTextField.borderStyle = .bezel
        passwordTextField.placeholder = "Password"
        passwordTextField.delegate = self
        passwordTextField.addTarget(self, action: #selector(validateTextfields), for: .editingChanged)
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.isEnabled = false
    
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
    
    @objc func validateTextfields() {
        if !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty {
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
