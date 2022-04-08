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
        viewConstraints(subView: photosImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
