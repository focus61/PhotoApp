//
//  AlbumsTableViewCell.swift
//  Photo App
//
//  Created by Aleksandr on 07.04.2022.
//

import Foundation
import UIKit
class AlbumsTableViewCell: UITableViewCell {
    let emptyView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "photo.on.rectangle")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    let photoView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    let albumTitle: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    let albumCount: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    static var cell = "Cell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: AlbumsTableViewCell.cell)
        addSubviews(emptyView, photoView,albumTitle, albumCount)
        constraint()
        albumTitle.text = "Untitled"
        albumCount.text = "0 photos"
        photoView.image = nil
        photoView.isHidden = true
        emptyView.isHidden = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func constraint() {
        NSLayoutConstraint.activate([
            
            photoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            photoView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10),
            photoView.heightAnchor.constraint(equalToConstant: 80),
            photoView.widthAnchor.constraint(equalToConstant: 80),
            
            emptyView.topAnchor.constraint(equalTo: photoView.topAnchor),
            emptyView.leftAnchor.constraint(equalTo: photoView.leftAnchor),
            emptyView.heightAnchor.constraint(equalToConstant: 80),
            emptyView.widthAnchor.constraint(equalToConstant: 80),
            
            albumTitle.leftAnchor.constraint(equalTo: photoView.rightAnchor, constant: 10),
            albumTitle.bottomAnchor.constraint(equalTo: albumCount.topAnchor),
            albumTitle.widthAnchor.constraint(equalToConstant: 200),
            albumTitle.heightAnchor.constraint(equalToConstant: 30),

            albumCount.leftAnchor.constraint(equalTo: photoView.rightAnchor, constant: 10),
            albumCount.bottomAnchor.constraint(equalTo: photoView.centerYAnchor, constant: 20),
            albumCount.widthAnchor.constraint(equalToConstant: 100),
            albumCount.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func update(title: String?, count: Int) {
      albumTitle.text = title ?? "Untitled"
      albumCount.text = "\(count.description) \(count == 1 ? "photo" : "photos")"
    }
}
