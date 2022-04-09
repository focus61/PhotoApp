import UIKit
import Photos
protocol ChangeAlbumProtocol {
    func changeAlbum(title: String, asset: PHFetchResult<PHAsset>)
}

class PhotosViewController: UIViewController {
    var assets = PHFetchResult<PHAsset>()
    let collectionView = PhotosCollectionView()
    let albumsVC = AlbumsTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        self.getPermissionIfNecessary {[weak self] granted in
            guard granted, let self = self else { return }
            self.fetchAssets()
            self.collectionView.reloadData()
        }
    }
    
    private func fetchAssets() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [
            NSSortDescriptor(
                key: "creationDate",
                ascending: false)
        ]
        assets = PHAsset.fetchAssets(with: allPhotosOptions)
    }
    
    private func configure() {
        self.title = "All Photos"
        self.view.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubviews(collectionView)
        constraint()
        let rightButton = UIBarButtonItem(title: "Albums", style: .plain, target: self, action: #selector(watchAlbums))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    private func constraint() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        ])
    }
    
    @objc func watchAlbums() {
        let vc = AlbumsTableViewController()
        let navCont = UINavigationController(rootViewController: vc)
        vc.delegate = self
        self.present(navCont, animated: true)
    }
}
extension PhotosViewController: ChangeAlbumProtocol {
    func changeAlbum(title: String, asset: PHFetchResult<PHAsset>) {
        self.title = title
        self.assets = asset
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
