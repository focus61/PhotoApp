import UIKit
extension UIView {
//MARK: - Add subviews
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
}
