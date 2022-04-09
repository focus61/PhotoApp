import UIKit
import Photos
extension UIViewController {
    func getPermissionIfNecessary(completionHandler: @escaping (Bool) -> Void) {
        guard PHPhotoLibrary.authorizationStatus() != .authorized else {
            completionHandler(true)
            return
        }
        PHPhotoLibrary.requestAuthorization { status in
            completionHandler(status == .authorized ? true : false)
        }
    }
}
extension UITabBarController {
    func createTabBarController(firstVC: UIViewController, secondVC: UITableViewController) -> UITabBarController{
        let tabbar = self
        let profileNav = UINavigationController(rootViewController: firstVC)
        let usersTable = UINavigationController(rootViewController: secondVC)
        tabbar.viewControllers = [profileNav, usersTable]
        usersTable.title = "Users"
        tabbar.navigationController?.navigationBar.prefersLargeTitles = false
        tabbar.tabBar.backgroundColor = .systemGray6
        tabbar.viewControllers?[0].tabBarItem.image = UIImage(systemName: "person")
        tabbar.viewControllers?[1].tabBarItem.image = UIImage(systemName: "person.2.wave.2")
        return tabbar
    }
}

