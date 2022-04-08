
import UIKit

class ProfileViewController: UIViewController {

    let profileView = ProfileView()
    var currentUser: User?
    var cdManager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "\(currentUser?.user ?? "")"
        navigationItem.title = "Welcome \(currentUser?.user ?? "")"
        if let imageData = currentUser?.avatar {
            profileView.currentAvatarImageView.image = UIImage(data: imageData)
            profileView.currentAvatarImageView.contentMode = .scaleToFill
        }
    }
    private func configure() {
        currentUser = cdManager.currentUser(userName: currentUser?.user ?? "")
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubviews(profileView)
        view.viewConstraints(subView: profileView)
        profileView.deleteProfileButton.addTarget(self, action: #selector(deleteTarget), for: .touchUpInside)
        profileView.signOutButton.addTarget(self, action: #selector(signOutTarget), for: .touchUpInside)
        profileView.changeAvatarButton.addTarget(self, action: #selector(changePhotoTarget), for: .touchUpInside)
    }
    
    @objc func deleteTarget() {
        let vc = AuthViewController()
        let navCont = UINavigationController(rootViewController: vc)
        guard let currentUser = currentUser, let user = currentUser.user else {return}
        cdManager.deleteUser(user: user)
        cdManager.loginUpdate(isLogin: false)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(navCont, options: [.transitionFlipFromLeft])
        
    }
    
    @objc func signOutTarget() {
        let vc = AuthViewController()
        let navCont = UINavigationController(rootViewController: vc)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(navCont, options: [.transitionFlipFromLeft])
        cdManager.loginUpdate(isLogin: false)
        guard let currentUser = currentUser else {
            return
        }
        cdManager.signOut(object: currentUser)
    }
    
    @objc func changePhotoTarget() {
        navigationController?.pushViewController(PhotoViewController(), animated: true)
    }
}
