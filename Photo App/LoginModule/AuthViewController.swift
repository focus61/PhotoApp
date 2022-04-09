import UIKit
class AuthViewController: UIViewController {
    let authView = AuthView()
    private let manager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        authView.signInButton.addTarget(self, action: #selector(register(sender:)), for: .touchUpInside)
        authView.signUpButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        view.addSubviews(authView)
        view.viewConstraints(subView: authView)
        view.backgroundColor = .systemYellow
    }
    
    @objc func pressed() {
        let vc = AuthViewController()
        vc.authView.signUpButton.isHidden = true
        let signIn = vc.authView.signInButton
        signIn.setTitle("Sign up", for: .normal)
        signIn.backgroundColor = .systemGreen
        vc.authView.infoLabel.text = "Register profile"
        AuthView.isSignUp = true
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func register(sender: UIButton) {
        let profileVC = ProfileViewController()
        let tableVC = UsersTableViewController()
        let tabBar = UITabBarController().createTabBarController(firstVC: profileVC, secondVC: tableVC)
        if sender.titleLabel?.text == "Sign up" {
//If sign up
            let txtFieldText = authView.userNameTextField.text ?? ""
            if !txtFieldText.isEmpty && txtFieldText.count > 3 {
                if manager.containsUser(text: txtFieldText) {
                    view.alert(message: "Username is taken", target: self)
                } else {
                    profileVC.currentUser = manager.createUser(user: txtFieldText)
                    tableVC.tableView.reloadData()
                    manager.loginUpdate(isLogin: true)
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBar, options: [.transitionFlipFromRight])
                }
            } else {
                view.alert(message: "Enter a name", target: self)
            }
        } else {
//If sign in
            let txtFieldText = authView.userNameTextField.text ?? ""
            if !txtFieldText.isEmpty && txtFieldText.count > 3 {
                if manager.containsUser(text: txtFieldText) {
                    profileVC.currentUser = manager.currentUser(userName: txtFieldText)
                    manager.loginUpdate(isLogin: true)
                    tableVC.tableView.reloadData() 
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBar, options: [.transitionFlipFromRight])
                } else {
                    view.alert(message: "Username is incorrect", target: self)
                }
            } else {
                view.alert(message: "Enter a name", target: self)
            }
        }
    }
}
