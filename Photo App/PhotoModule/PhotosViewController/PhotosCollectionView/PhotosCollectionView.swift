import UIKit
class PhotosCollectionView: UICollectionView {
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.cell)
        alwaysBounceVertical = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.cell, for: indexPath) as? PhotosCollectionViewCell else {return UICollectionViewCell()}
        let asset = assets[indexPath.item]
        cell.photosImageView.fetchImageAsset(asset, targetSize: cell.photosImageView.bounds.size, completionHandler: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoRedactorViewController()
        vc.asset = assets[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }
}
