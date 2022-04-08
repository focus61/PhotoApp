//
//  PhotoRedactorViewController.swift
//  Photo App
//
//  Created by Aleksandr on 07.04.2022.
//

import UIKit

class PhotoRedactorViewController: UIViewController {
    let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(imageView)
        imageView.contentMode = .scaleAspectFit
        view.viewConstraints(subView: imageView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    }
    @objc func save() {
        let vc = ProfileViewController()
        var user: User?
        if let users = CoreDataManager.shared.users() {
            for i in users {
                if i.isLoad == true {
                    user = i
                }
            }
        }
        guard let data = imageView.image?.jpegData(compressionQuality: 0), let user = user else {return}
        vc.currentUser = user
//        print(user, "and", data)
        vc.profileView.currentAvatarImageView.image = UIImage(data: data)
        CoreDataManager.shared.updateAvatar(object: user, imageData: data)
        
        navigationController?.popToRootViewController(animated: true)
    }
}
