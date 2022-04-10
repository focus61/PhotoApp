import UIKit
import Foundation
import Photos
enum AlbumCollectionSectionType: Int, CustomStringConvertible {
    case all, userCollections, favoriteAlbum
    var description: String {
        switch self {
        case .all: return "All Photos"
        case .userCollections: return "User Collections"
        case .favoriteAlbum: return "Smart Albums"
        }
    }
}

class AlbumsTableViewController: UITableViewController {
    private let sections: [AlbumCollectionSectionType] = [.all, .userCollections, .favoriteAlbum]
    private var allPhotos = PHFetchResult<PHAsset>()
    private var favoriteAlbum = PHFetchResult<PHAssetCollection>()
    private var userCollections = PHFetchResult<PHAssetCollection>()
    var delegate: ChangeAlbumProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        self.title = "Albums"
        view.backgroundColor = .white
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: AlbumsTableViewCell.cell)
        let buttonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(back))
        navigationItem.rightBarButtonItem = buttonItem
        self.getPermissionIfNecessary { granted in
            guard granted else { return }
            self.fetchAssets()
        }
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
//MARK: - Fetch albums data -
    private func fetchAssets() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [
            NSSortDescriptor(
                key: "creationDate",
                ascending: false)
        ]
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        userCollections = PHAssetCollection.fetchAssetCollections(
            with: .album,
            subtype: .albumRegular,
            options: nil)
        favoriteAlbum = PHAssetCollection.fetchAssetCollections(
            with: .smartAlbum,
            subtype: .smartAlbumFavorites,
            options: nil)
    }
}
//MARK: - TableView DataSource
extension AlbumsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .all: return 1
        case .userCollections: return userCollections.count
        case .favoriteAlbum: return favoriteAlbum.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumsTableViewCell.cell, for: indexPath) as? AlbumsTableViewCell else {return UITableViewCell()}
        var coverAsset: PHAsset?
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .all:
            coverAsset = allPhotos.firstObject
            cell.update(title: sectionType.description, count: allPhotos.count)
        case .userCollections:
            let fetchedAssets = PHAsset.fetchAssets(in: userCollections[indexPath.item], options: nil)
            coverAsset = fetchedAssets.firstObject
            cell.update(title: userCollections[indexPath.item].localizedTitle, count: fetchedAssets.count)
        case .favoriteAlbum:
            let fetchedAssets = PHAsset.fetchAssets(in: favoriteAlbum[indexPath.item], options: nil)
            coverAsset = fetchedAssets.firstObject
            cell.update(title: favoriteAlbum[indexPath.item].localizedTitle, count: fetchedAssets.count)
        }
        guard let asset = coverAsset else { return cell }
        cell.photoView.fetchImageAsset(asset, targetSize: cell.bounds.size) { success in
            cell.photoView.isHidden = !success
            cell.emptyView.isHidden = success
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionType = sections[indexPath.section]
        let item = indexPath.item
        let assets: PHFetchResult<PHAsset>
        let title: String
        switch sectionType {
        case .all:
            assets = allPhotos
            title = AlbumCollectionSectionType.all.description
        case .userCollections:
            let album = userCollections[item]
            assets = PHAsset.fetchAssets(in: album, options: nil)
            title = album.localizedTitle ?? ""
        case .favoriteAlbum:
            let album = favoriteAlbum[item]
            assets = PHAsset.fetchAssets(in: album, options: nil)
            title = album.localizedTitle ?? ""
        }
        dismiss(animated: true) {
            self.delegate?.changeAlbum(title: title, asset: assets)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
