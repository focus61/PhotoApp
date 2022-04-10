import UIKit
class AuthViewController: UIViewController {
    let authView = AuthView()
    private let manager = CoreDataManager.shared
    let maxCount = 10
    let minCount = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        authView.signInButton.addTarget(self, action: #selector(register(sender:)), for: .touchUpInside)
        authView.signUpButton.addTarget(self, action: #selector(pressedSignUp), for: .touchUpInside)
        authView.userNameTextField.delegate = self
        authView.passwordTextField.delegate = self
        view.addSubviews(authView)
        view.viewConstraints(subView: authView)
        view.backgroundColor = .white
    }
    
    @objc func pressedSignUp() {
        let vc = AuthViewController()
        vc.authView.signUpButton.isHidden = true
        let signIn = vc.authView.signInButton
        signIn.setTitle("Sign up", for: .normal)
        signIn.backgroundColor = .systemGreen
        vc.authView.infoLabel.text = "Register a profile"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func register(sender: UIButton) {
        let profileVC = ProfileViewController()
        let tableVC = UsersTableViewController()
        let tabBar = UITabBarController().createTabBarController(firstVC: profileVC, secondVC: tableVC)
        let userText = authView.userNameTextField.text ?? ""
        let passwordText = authView.passwordTextField.text ?? ""
        if sender.titleLabel?.text == "Sign up" {
//If sign up
            if !userText.isEmpty && userText.count > minCount && userText.count < maxCount && !passwordText.isEmpty && passwordText.count > 5 && passwordText.count < maxCount {
                if manager.containsUser(user: userText) {
                    view.alert(message: "Username is taken", target: self)
                } else {
                    profileVC.currentUser = manager.createUser(user: userText, password: passwordText)
                    tableVC.tableView.reloadData()
                    manager.loginUpdate(isLogin: true)
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBar, options: [.transitionFlipFromRight])
                }
            } else {
                view.alert(message: "Enter a name", target: self)
            }
        } else {
//If sign in
            if !userText.isEmpty && userText.count > minCount && userText.count < maxCount && !passwordText.isEmpty && passwordText.count > 5 && passwordText.count < maxCount{
                if manager.containsUser(user: userText) {
                    if manager.isValidPassword(user: userText, password: passwordText) {
                        profileVC.currentUser = manager.currentUser(userName: userText)
                        manager.loginUpdate(isLogin: true)
                        tableVC.tableView.reloadData()
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBar, options: [.transitionFlipFromRight])
                    } else {
                        view.alert(message: "Password incorrect", target: self)
                    }
                   
                } else {
                    view.alert(message: "Username is incorrect", target: self)
                }
            } else {
                view.alert(message: "Enter a name", target: self)
            }
        }
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.authView.userNameTextField {
            authView.passwordTextField.becomeFirstResponder()
        } else {
            authView.passwordTextField.resignFirstResponder()
            return true
        }
        return false
    }
}
