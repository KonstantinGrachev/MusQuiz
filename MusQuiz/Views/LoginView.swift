//
//  LoginView.swift
//  MusQuiz
//
//  Created by Konstantin Gracheff on 04.10.2022.
//

import UIKit

//MARK: - protocol

protocol LoginViewDelegate: AnyObject {
    func signUp(userData: UserData)
    func signIn(userData: UserData)
}

class LoginView: UIView {
    
    weak var delegate: (LoginViewDelegate)?
    
    //MARK: - constants
    
    private enum Constants {
        static let appIconHeightWidth: CGFloat = 200
        static let appIconTopIndentation: CGFloat = 100
        static let cornerRadius: CGFloat = 10
    }
    
    //MARK: - UI
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "musQuizBackground")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let appIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoMusQuizApp")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter login"
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = .init(white: 1, alpha: 0.8)
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .init(white: 1, alpha: 0.8)
        button.layer.cornerRadius = Constants.cornerRadius
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var textFieldsStackView = UIStackView()
    private lazy var buttonsStackView = UIStackView()
    private lazy var aggregateStackView = UIStackView()
    
    //MARK: - initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setDelegates()
        setConstraints()
    }
    required init?(coder: NSCoder)  {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - @objc funcs
    
    @objc private func signInButtonTapped() {
        //FIXME: - need a separate method. duplicated code.
        guard let login = loginTextField.text,
              let password = passwordTextField.text else { return }
        let userData = UserData(login: login, password: password)
        
        delegate?.signIn(userData: userData)
    }
    
    @objc private func signUpButtonTapped() {
        //FIXME: - need a separate method
        guard let login = loginTextField.text,
              let password = passwordTextField.text else { return }
        let userData = UserData(login: login, password: password)
        
        delegate?.signUp(userData: userData)
    }
    
    //MARK: - set delegates
    
    private func setDelegates() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    //MARK: - setup views
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundImageView)
        addSubview(appIconImageView)
        
        textFieldsStackView = UIStackView(arrangedSubviews: [loginTextField, passwordTextField],
                                          axis: .vertical,
                                          spacing: 10)
        buttonsStackView = UIStackView(arrangedSubviews: [signInButton, signUpButton],
                                       axis: .horizontal,
                                       spacing: 20)
        aggregateStackView = UIStackView(arrangedSubviews: [textFieldsStackView, buttonsStackView],
                                         axis: .vertical,
                                         spacing: 20)
        buttonsStackView.distribution = .fillEqually
        addSubview(aggregateStackView)
    }
    
    //MARK: - set constraints
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            appIconImageView.heightAnchor.constraint(equalToConstant: Constants.appIconHeightWidth),
            appIconImageView.widthAnchor.constraint(equalToConstant: Constants.appIconHeightWidth),
            appIconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            appIconImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.appIconTopIndentation)
        ])
        
        NSLayoutConstraint.activate([
            aggregateStackView.topAnchor.constraint(equalTo: appIconImageView.bottomAnchor, constant: 20),
            aggregateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            aggregateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
}

//MARK: - UITextFieldDelegate

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    func hideKeyboard() {
        endEditing(true)
    }
    
}
