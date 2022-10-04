//
//  LoginViewController.swift
//  Instagram
//
//  Created by Lộc Xuân  on 14/09/2022.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "text"))
        
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let userField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = Constants.cornerRadius
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = Constants.cornerRadius
        return field
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .none
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private func addSubView(){
        view.addSubview(imageView)
        view.addSubview(userField)
        view.addSubview(passwordField)
        view.addSubview(forgotPasswordButton)
        view.addSubview(loginButton)
        view.addSubview(privacyButton)
        view.addSubview(registerButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forgotPasswordButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        addSubView()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Assign frame
        imageView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: 200
        )
        userField.frame = CGRect(
            x: 10,
            y: imageView.bottom + 10,
            width: view.width - 20,
            height: 50
        )
        passwordField.frame = CGRect(
            x: 10,
            y: userField.bottom + 10,
            width: view.width-20,
            height: 50
        )
        forgotPasswordButton.frame = CGRect(
            x: view.width / 2 + 20,
            y: passwordField.bottom + 10,
            width: view.width/2 - 40,
            height: 50
        )
        loginButton.frame = CGRect(
            x: 10,
            y: forgotPasswordButton.bottom + 10,
            width: view.width - 20,
            height: 50
        )
        privacyButton.frame = CGRect(
            x: 20,
            y: view.bottom - 150,
            width: view.width - 40,
            height: 50
        )
        registerButton.frame = CGRect(
            x: 20,
            y: privacyButton.bottom + 10,
            width: view.width - 40,
            height: 50
        )
    }
    
    
    
    
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    @objc private func didTapLoginButton() {
        
        userField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let userName = userField.text, !userName.isEmpty, let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        var username: String?
        var email: String?
        
        if userName.contains("@"), userName.contains(".") {
            email = userName
        } else {
            username = userName
        }
        
        AuthManager.shared.loginUser(userName: username, email: email, password: password) { success in
            
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true)
                } else {
                    let alert = UIAlertController(title: "Fail to login", message: "Your username or password is incorrect", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Try again", style: .default)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                
                }
            }
            
        }
    }
 
    
    @objc private func didTapPrivacyButton(){
        guard let url = URL(string: "https://help.instagram.com/196883487377501") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}

