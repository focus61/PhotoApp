import UIKit
import Photos
class PhotoRedactorViewController: UIViewController {
    let imageView = UIImageView()
    var asset: PHAsset?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubviews(imageView)
        imageView.contentMode = .scaleAspectFit
        view.viewConstraints(subView: imageView)
        view.backgroundColor = UIColor().myColor()
        getPhoto()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAndUpdateAvatar))
    }
    
    private func getPhoto() {
        imageView.fetchImageAsset(asset, targetSize: view.bounds.size, completionHandler: nil)
    }
    
    @objc func saveAndUpdateAvatar() {
        var user: User?
        if let users = CoreDataManager.shared.users() {
            for i in users {
                if i.isLoad == true {
                    user = i
                }
            }
        }
        guard let data = imageView.image?.jpegData(compressionQuality: 0), let user = user else {return}
        let profileVC = ProfileViewController()
        let tableVC = UsersTableViewController()
        profileVC.currentUser = user
        profileVC.profileView.currentAvatarImageView.image = UIImage(data: data)
        let tabBar = UITabBarController().createTabBarController(firstVC: profileVC, secondVC: tableVC)
        CoreDataManager.shared.updateAvatar(object: user, imageData: data)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBar, options: [.transitionFlipFromRight])
    }
}
