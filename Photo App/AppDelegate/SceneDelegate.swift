import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let ws = (scene as? UIWindowScene) else { return }
        var navigation = UINavigationController()
        let profileVC = ProfileViewController()
        let tableVC = UsersTableViewController()
        let authVC = AuthViewController()
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
//If user is log in
            window?.rootViewController = UITabBarController().createTabBarController(firstVC: profileVC, secondVC: tableVC)
        } else {
            navigation = UINavigationController(rootViewController: authVC)
            window?.rootViewController = navigation
        }
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
