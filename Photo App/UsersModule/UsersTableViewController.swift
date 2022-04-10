import UIKit
class UsersTableViewController: UITableViewController {
    lazy var array: [User] = {
        if let users = CoreDataManager.shared.users() {
            return users
        }
        return []
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    private func configure() {
        self.title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UsersTableVIewCell.self, forCellReuseIdentifier: UsersTableVIewCell.cell )
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableVIewCell.cell, for: indexPath) as? UsersTableVIewCell else {return UITableViewCell()}
        let data = array[indexPath.row]
        cell.nameLabel.text = data.user
        if let imageData = data.avatar {
            cell.avatarImageView.image = UIImage(data: imageData)?.withRenderingMode(.automatic)
            cell.avatarImageView.clipsToBounds = true
            cell.avatarImageView.layer.cornerRadius = 35
        }
        return cell
    }
}
