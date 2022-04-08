//
//  UsersTableTableViewController.swift
//  Photo App
//
//  Created by Aleksandr on 05.04.2022.
//

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
        self.title = "Users"
        tableView.register(UsersTableVIewCell.self, forCellReuseIdentifier: UsersTableVIewCell.cell )
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableVIewCell.cell, for: indexPath) as? UsersTableVIewCell else {return UITableViewCell()}
        let data = array[indexPath.row]
        
        cell.nameLabel.text = data.user
        if let imageData = data.avatar {
            cell.avatarImageView.image = UIImage(data: imageData)?.withRenderingMode(.automatic)
        }
        return cell
    }
    

}
