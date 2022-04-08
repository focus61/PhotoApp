
import UIKit
import Photos
class PhotoViewController: UIViewController {
    
    var imageArray = [UIImage]()
    var assets: PHFetchResult<PHAsset>?
    let collectionView = PhotoCollectionView()
    let albumsVC = AlbumsTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configure()
    }
    override func viewWillAppear(_ animated: Bool) {
        albumsVC.callback = { title, assets in
            self.assets = assets
            self.title = title
        }
    }
    func configure() {
        self.title = "All photos"
        self.view.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubviews(collectionView)
        view.viewConstraints(subView: collectionView)
        let rightButton = UIBarButtonItem(title: "Albums", style: .plain, target: self, action: #selector(watchAlbums))
        navigationItem.rightBarButtonItem = rightButton
        grabPhotos()

    }
    @objc func watchAlbums() {
        let navCont = UINavigationController(rootViewController: AlbumsTableViewController())
        self.present(navCont, animated: true)
    }
    func grabPhotos() {
        let imageManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        guard let assets = assets else {
            return
        }
        if assets.count > 0 {
            for i in 0..<assets.count {
                imageManager.requestImage(for: assets.object(at: i), targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: requestOptions) { [weak self]
                    image, error in
                    guard let self = self else {return}
                    self.imageArray.append(image!)
                }
            }
        }
    }
}
