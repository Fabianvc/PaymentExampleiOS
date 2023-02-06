import UIKit

extension UITextField {
    
    //image Click
    @objc func image(text: UITextField, _ imageBtn: String) {
        let imageButton = UIButton(type: .custom)
        let image = UIImage(named: imageBtn)?.maskWithColor(color: Colors.darkGray)
        imageButton.setImage(image, for: .normal)
        
        imageButton.frame = CGRect(x: 0.0, y: 0.0, width: 13, height: 8)
        imageButton.contentMode = .scaleAspectFill
        imageButton.addTarget(self, action: #selector(UITextField.imageClick(sender:)), for: .touchUpInside)
        
        rightView = imageButton
        rightViewMode = .always
    }
    @objc func imageClick(sender: UIButton) {
        self.becomeFirstResponder()
    }
    
}
