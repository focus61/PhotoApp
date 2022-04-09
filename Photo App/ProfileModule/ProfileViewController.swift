import UIKit
class ProfileViewController: UIViewController {
    let profileView = ProfileView()
    var currentUser: User?
    private let manager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "\(currentUser?.user ?? "")"
        navigationItem.title = "\(currentUser?.user ?? "")"
        if let imageData = currentUser?.avatar {
            profileView.currentAvatarImageView.image = UIImage(data: imageData)
            profileView.currentAvatarImageView.contentMode = .scaleToFill
            profileView.currentAvatarImageView.clipsToBounds = true
            profileView.currentAvatarImageView.layer.cornerRadius = 75
        }
    }
    
    private func configure() {
        currentUser = manager.currentUser(userName: currentUser?.user ?? "")
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubviews(profileView)
        view.viewConstraints(subView: profileView)
        profileView.deleteProfileButton.addTarget(self, action: #selector(deleteTarget), for: .touchUpInside)
        profileView.signOutButton.addTarget(self, action: #selector(signOutTarget), for: .touchUpInside)
        profileView.changeAvatarButton.addTarget(self, action: #selector(changePhotoTarget), for: .touchUpInside)
        view.backgroundColor = .systemYellow

    }
    
    @objc func deleteTarget() {
        let vc = AuthViewController()
        let navCont = UINavigationController(rootViewController: vc)
        guard let currentUser = currentUser, let user = currentUser.user else {return}
        manager.deleteUser(user: user)
        manager.loginUpdate(isLogin: false)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(navCont, options: [.transitionFlipFromLeft])
    }
    
    @objc func signOutTarget() {
        let vc = AuthViewController()
        let navCont = UINavigationController(rootViewController: vc)
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(navCont, options: [.transitionFlipFromLeft])
        manager.loginUpdate(isLogin: false)
        guard let currentUser = currentUser else {
            return
        }
        manager.signOut(object: currentUser)
    }
    
    @objc func changePhotoTarget() {
        let vc = PhotosViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
