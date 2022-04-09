import UIKit
extension UIView {

    
    func addSubviews(_ views: UIView...) {
        for i in views {
            i.translatesAutoresizingMaskIntoConstraints = false
            addSubview(i)
        }
    }
    
    func viewConstraints(subView: UIView) {
        NSLayoutConstraint.activate([
            subView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            subView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            subView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -10),
            subView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 10)
        ])
    }
    
    func alert(message: String, target: UIViewController) {
        let alertCont = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        let alertAct = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertCont.addAction(alertAct)
        target.present(alertCont, animated: true, completion: nil)
    }
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        layer.addSublayer(border)
    }
}
