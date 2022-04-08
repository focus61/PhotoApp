//
//  AuthViewController.swift
//  Photo App
//
//  Created by Aleksandr on 04.04.2022.
//

import UIKit
import CoreData

class AuthViewController: UIViewController {

    let authView = AuthView()
    var coreDataManager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        authView.signInButton.addTarget(self, action: #selector(register(sender:)), for: .touchUpInside)
        authView.signUpButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        view.addSubviews(authView)
        view.viewConstraints(subView: authView)
        view.backgroundColor = .white
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
//tabBar config
        let profileVC = ProfileViewController()
        let tableVC = UsersTableViewController()
        let profileNav = UINavigationController(rootViewController: profileVC)
        let usersTable = UINavigationController(rootViewController: tableVC)
        let tabBar = UITabBarController()
        tabBar.navigationController?.navigationBar.prefersLargeTitles = false
        tabBar.tabBar.selectedItem?.badgeColor = .red
        tabBar.navigationController?.navigationBar.backgroundColor = .gray
        tabBar.viewControllers = [profileNav, usersTable]
        
        if sender.titleLabel?.text == "Sign up" {
//If sign up
            let txtFieldText = authView.userNameTextField.text ?? ""
            if !txtFieldText.isEmpty && txtFieldText.count > 3 {
                if coreDataManager.containsUser(text: txtFieldText) {
                    view.alert(message: "Username is taken", target: self)
                } else {
                    profileVC.currentUser = coreDataManager.createUser(user: txtFieldText)
                    
                    tableVC.tableView.reloadData()
                    coreDataManager.loginUpdate(isLogin: true)
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBar, options: [.transitionFlipFromRight])
                }
            } else {
                view.alert(message: "Enter a name", target: self)
            }
        } else {
//If sign in
            let txtFieldText = authView.userNameTextField.text ?? ""
            if !txtFieldText.isEmpty && txtFieldText.count > 3 {
                if coreDataManager.containsUser(text: txtFieldText) {
                    profileVC.currentUser = coreDataManager.currentUser(userName: txtFieldText)
                    coreDataManager.loginUpdate(isLogin: true)
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
