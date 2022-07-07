import UIKit

extension UIView{
    func pinEdgesToSuperView(_ distance: CGFloat = 0){
        guard let superview = superview else {return}
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: distance),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: distance),
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: distance),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: distance)
        ])
        
    }
}

