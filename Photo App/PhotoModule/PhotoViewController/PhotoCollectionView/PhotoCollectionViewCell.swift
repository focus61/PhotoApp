import UIKit
class PhotoCollectionViewCell: UICollectionViewCell {
    static var cell = "Cell"
    let photosImageView: UIImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(photosImageView)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        NSLayoutConstraint.activate([
            photosImageView.topAnchor.constraint(equalTo: topAnchor),
            photosImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            photosImageView.rightAnchor.constraint(equalTo: rightAnchor),
            photosImageView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
}
