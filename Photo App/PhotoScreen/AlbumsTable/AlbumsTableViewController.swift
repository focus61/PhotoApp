//
//  AlbumsTableViewController.swift
//  Photo App
//
//  Created by Aleksandr on 07.04.2022.
//

import UIKit
import Foundation
import Photos

enum AlbumCollectionSectionType: Int, CustomStringConvertible {
    case all, userCollections
    var description: String {
        switch self {
        case .all: return "All Photos"
        case .userCollections: return "User Collections"
        }
    }
}

class AlbumsTableViewController: UITableViewController {
    var sections: [AlbumCollectionSectionType] = [.all, .userCollections]
    var allPhotos = PHFetchResult<PHAsset>()
    var userCollections = PHFetchResult<PHAssetCollection>()
    var callback: ((String,PHFetchResult<PHAsset>) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Albums"
        view.backgroundColor = .white
        tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: AlbumsTableViewCell.cell)
        let buttonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(back))
        navigationItem.rightBarButtonItem = buttonItem
        getPermissionIfNecessary { granted in
            guard granted else { return }
            self.fetchAssets()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        PHPhotoLibrary.shared().register(self)
    }
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .all: return 1
        case .userCollections: return userCollections.count
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
        let vc = PhotoViewController()
        switch sectionType {
        case .all:
            assets = allPhotos
            title = AlbumCollectionSectionType.all.description
            callback?(title, assets)
        case .userCollections:
            let album = userCollections[item]
            assets = PHAsset.fetchAssets(in: album, options: nil)
            title = album.localizedTitle ?? ""
            callback?(title, assets)
        }
        dismiss(animated: true, completion: nil)
    }
    func getPermissionIfNecessary(completionHandler: @escaping (Bool) -> Void) {
        guard PHPhotoLibrary.authorizationStatus() != .authorized else {
            completionHandler(true)
            return
        }
        PHPhotoLibrary.requestAuthorization { status in
            completionHandler(status == .authorized ? true : false)
        }
    }
    
    func fetchAssets() {
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
    }
}

extension AlbumsTableViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.async {
            if let changeDetails = changeInstance.changeDetails(for: self.allPhotos) {
                self.allPhotos = changeDetails.fetchResultAfterChanges
            }
            if let changeDetails = changeInstance.changeDetails(for: self.userCollections) {
                self.userCollections = changeDetails.fetchResultAfterChanges
            }
            self.tableView.reloadData()
        }
    }
}
