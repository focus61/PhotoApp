import UIKit
class ProfileView: UIView {
    let currentAvatarLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Your avatar"
        lbl.font = UIFont.systemFont(ofSize: 30)
        lbl.textAlignment = .center
        lbl.addBottomBorder(with: .systemGray3, andWidth: 1)
        return lbl
    }()
    let currentAvatarImageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    let changeAvatarButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Change avatar", for: .normal)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 10
        return button
    }()
    let signOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 10
        button.setTitle("Sign out", for: .normal)
        return button
    }()
    let deleteProfileButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemRed
        button.setTitle("Delete", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    private func configure() {
        addSubviews(currentAvatarLabel, currentAvatarImageView,changeAvatarButton, signOutButton, deleteProfileButton)
        constraints()
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            
            currentAvatarLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            currentAvatarLabel.heightAnchor.constraint(equalToConstant: 80),
            currentAvatarLabel.rightAnchor.constraint(equalTo: centerXAnchor),
            currentAvatarLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10),
            
            currentAvatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            currentAvatarImageView.heightAnchor.constraint(equalToConstant: 150),
            currentAvatarImageView.widthAnchor.constraint(equalToConstant: 150),
            currentAvatarImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10),

            changeAvatarButton.topAnchor.constraint(equalTo: currentAvatarLabel.bottomAnchor, constant: 10),
            changeAvatarButton.rightAnchor.constraint(equalTo: currentAvatarLabel.rightAnchor),
            changeAvatarButton.leftAnchor.constraint(equalTo: currentAvatarLabel.leftAnchor),
            changeAvatarButton.heightAnchor.constraint(equalToConstant: 40),
            
            signOutButton.bottomAnchor.constraint(equalTo: deleteProfileButton.topAnchor, constant: -20),
            signOutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signOutButton.widthAnchor.constraint(equalToConstant: 150),
            signOutButton.heightAnchor.constraint(equalToConstant: 40),
            
            deleteProfileButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            deleteProfileButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            deleteProfileButton.widthAnchor.constraint(equalToConstant: 150),
            deleteProfileButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
