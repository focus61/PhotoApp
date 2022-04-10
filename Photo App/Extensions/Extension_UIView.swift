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

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
}

extension UIColor {
    func myColor() -> UIColor {
        return UIColor(red: 235.0 / 255.0, green: 215.0 / 255.0 , blue: 175.0 / 255.0 , alpha: 1)
    }
}
