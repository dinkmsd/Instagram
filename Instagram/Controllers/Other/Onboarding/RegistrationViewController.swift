//
//  RegistrationViewController.swift
//  Instagram
//
//  Created by Lộc Xuân  on 14/09/2022.
//

import UIKit

class RegistrationViewController: UIViewController {

    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
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
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
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
        field.placeholder = "Password"
        field.isSecureTextEntry = true
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
    
    private let confirmPasswordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Confirm your password"
        field.isSecureTextEntry = true
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
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    private func addSubView(){
        view.addSubview(emailField)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(confirmPasswordField)
        view.addSubview(signUpButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        signUpButton.addTarget(self , action: #selector(didTapRegister), for: .touchUpInside)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        emailField.frame = CGRect(
            x: 10,
            y: view.safeAreaInsets.top + 50,
            width: view.width - 20,
            height: 52
        )
        
        usernameField.frame = CGRect(
            x: 10,
            y: emailField.bottom + 10,
            width: view.width - 20,
            height: 52
        )
        
        passwordField.frame = CGRect(
            x: 10,
            y: usernameField.bottom + 10,
            width: view.width - 20,
            height: 52
        )
        
        confirmPasswordField.frame = CGRect(
            x: 10,
            y: passwordField.bottom + 10,
            width: view.width - 20,
            height: 52
        )
        
        signUpButton.frame = CGRect(
            x: 10,
            y: confirmPasswordField.bottom + 20,
            width: view.width - 20,
            height: 52
        )
    }
    
    @objc private func didTapRegister(){
        emailField.resignFirstResponder()
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
              let username = usernameField.text, !username.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8,
              let confirmPassword = confirmPasswordField.text, !confirmPassword.isEmpty, password.count >= 8,
              confirmPassword == password
        else {
            return
        }
        print("Did tap on button")

        AuthManager.shared.registerNewUser(userName: username, email: email, password: password) { successed in
            DispatchQueue.main.async {
                if successed {
                    self.dismiss(animated: true)
                } else {
                    
                }
            }
        }
    }
}
