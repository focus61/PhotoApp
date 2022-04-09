import UIKit
class AuthView: UIView {
    static var isRegister = false
    static var isSignUp = false
    let infoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Log in your profile"
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.textAlignment = .center
        return lbl
    }()
    let userNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "User"
        lbl.font = UIFont.systemFont(ofSize: 20)
        return lbl
    }()
    let userNameTextField: UITextField = {
        let txtFld = UITextField()
        txtFld.backgroundColor = .systemGray5
        txtFld.placeholder = "Enter your name"
        txtFld.textAlignment = .center
        txtFld.layer.cornerRadius = 10
        return txtFld
    }()
    let passwordTextField: UITextField = {
        let txtFld = UITextField()
        txtFld.backgroundColor = .systemGray5
        txtFld.placeholder = "Enter your password"
        txtFld.textAlignment = .center
        txtFld.layer.cornerRadius = 10
        return txtFld
    }()
    let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        return button
    }()
    var signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.setTitle("Sign up", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubviews(infoLabel, userNameLabel, userNameTextField, passwordTextField, signInButton, signUpButton)
        constraint()

    }
    
    private func constraint() {
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            infoLabel.widthAnchor.constraint(equalToConstant: 150),
            infoLabel.heightAnchor.constraint(equalToConstant: 100),
            
            userNameLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 50),
            userNameLabel.bottomAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 100),
            userNameLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 200),
            userNameLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10),
            
            userNameTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 40),
            userNameTextField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            userNameTextField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10),

            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            passwordTextField.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10),
            
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            signInButton.heightAnchor.constraint(equalToConstant: 40),
            signInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signInButton.widthAnchor.constraint(equalToConstant: 200),
            
            signUpButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            signUpButton.heightAnchor.constraint(equalToConstant: 40),
            signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 200)
            
        ])
    }
}
