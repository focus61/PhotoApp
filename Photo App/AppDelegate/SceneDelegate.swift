//
//  SceneDelegate.swift
//  Photo App
//
//  Created by Aleksandr on 04.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var isLogin = false
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let profileVC = ProfileViewController()
        let profileNav = UINavigationController(rootViewController: profileVC)
        let usersTable = UINavigationController(rootViewController: UsersTableViewController())
        let tabBar = UITabBarController()
        tabBar.navigationController?.navigationBar.prefersLargeTitles = false
        tabBar.tabBar.backgroundColor = .systemGray6
        tabBar.viewControllers = [profileNav, usersTable]
        guard let ws = (scene as? UIWindowScene) else { return }
        var navigation = UINavigationController()
        
        window = UIWindow(frame: ws.coordinateSpace.bounds)
        window?.windowScene = ws
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        CoreDataManager.shared.loginIsEmpty()
        if CoreDataManager.shared.isLogin() {
            if let users = CoreDataManager.shared.users() {
                for i in users {
                    if i.isLoad == true {
                        profileVC.currentUser = i
                    }
                }
            }
            window?.rootViewController = tabBar
        } else {
            navigation = UINavigationController(rootViewController: AuthViewController())
            window?.rootViewController = navigation
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func changeRootViewController(_ vc: UIViewController, animated: Bool = true, options: UIView.AnimationOptions = []) {
        guard let window = self.window else {
            return
        }
        window.rootViewController = vc
        UIView.transition(with: window,
                          duration: 0.5,
                          options: options,
                          animations: nil,
                          completion: nil)
    }
    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataManager.shared.saveContext()
    }


}

