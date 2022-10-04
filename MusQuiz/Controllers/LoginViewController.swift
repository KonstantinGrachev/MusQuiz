//
//  ViewController.swift
//  MusQuiz
//
//  Created by Konstantin Gracheff on 04.10.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    //MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        setConstraints()
        loginView.delegate = self
    }
    
}

//MARK: - LoginViewDelegate

extension LoginViewController: LoginViewDelegate {
    func signUp(userData: UserData) {
        print("Login: \(userData.login), pass: \(userData.password)")
    }
    
    func signIn(userData: UserData) {
        print("Login: \(userData.login), pass: \(userData.password)")
    }
}

//MARK: - set constraints

extension LoginViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
