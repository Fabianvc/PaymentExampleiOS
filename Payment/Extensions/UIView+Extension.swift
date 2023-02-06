import UIKit
import SnapKit

extension UIView {
    
    func addBottomBorder(_ color: UIColor, height: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)
        
        border.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.snp.bottom).offset(5)
        }
    }
}

public extension UIView {
    /// This method returs the push time interval
    func getPushEffectTimeAnimation() -> TimeInterval {
        0.25
    }
    
    /// This method performs the action effect of a push inside
    func pushEffect(completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: getPushEffectTimeAnimation(),
            animations: {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            },
            completion: { _ in
                completion?()
            }
        )
    }
    
    /// This method performs the action uneffect of a push inside
    func unPushEffect(completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: getPushEffectTimeAnimation(),
            animations: {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            },
            completion: { _ in
                completion?()
            }
        )
    }
    
    /// This method performs the action effect of a push  inside and out
    func togglePushEffect(completion: (() -> Void)? = nil) {
        pushEffect {
            self.unPushEffect {
                completion?()
            }
        }
    }
}
