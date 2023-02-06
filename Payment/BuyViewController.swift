import UIKit
import SnapKit
import Combine

class BuyViewController: UIViewController {
    var amount: String = empty
    
    private lazy var barButtonItem = setupBarBtnItem()
    private lazy var amountLabel = setupLabel()
    private lazy var amountText = setupText()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTab(title: Keys.Transversal.titleBuy.rawValue)
        self.configureUI()
        self.setupConstraints()
    }
    
    private func setupTab(title: String){
        guard let topViewController = self.navigationController?.topViewController else { return }
        topViewController.title = title
        topViewController.navigationItem.rightBarButtonItems = [barButtonItem]
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.black
        view.addSubview(amountLabel)
        view.addSubview(amountText)
    }
    
    private func setupConstraints() {
        amountLabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(250)
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
        }
        
        amountText.snp.makeConstraints { 
            $0.height.equalTo(40)
            $0.width.equalTo(250)
            $0.top.equalTo(amountLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc private func nextTapped() {
        let payment = PaymentViewController(amount: amountText.text ?? empty)
        
        if payment.amount.isEmpty {
            presentAlertMessage(Keys.Transversal.messageAlertOne.rawValue)
            
        }else if Int(payment.amount)! <= .zero {
            presentAlertMessage(Keys.Transversal.messageAlertTwo.rawValue)
            
        }else{
            self.navigationController?.pushViewController(payment, animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: Components

private extension BuyViewController {
    func presentAlertMessage(_ message: String) {
        let alert = UIAlertController(
            title: Keys.Transversal.titleAlert.rawValue,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        alert.addAction(UIAlertAction(title: Keys.Transversal.ok.rawValue, style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func setupBarBtnItem() -> UIBarButtonItem {
        UIBarButtonItem(
            title: Keys.Transversal.next.rawValue,
            style: .plain,
            target: self,
            action: #selector(nextTapped)
        )
    }
    
    func setupLabel() -> UILabel {
        let label = UILabel()
        label.text = Keys.Transversal.insertAmount.rawValue
        label.textColor = Colors.white
        label.textAlignment = .center
        
        return label
    }
    
    func setupText() -> UITextField {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = Colors.white
        text.textAlignment = .center
        text.placeholder = Keys.Transversal.placeholder.rawValue
        text.keyboardType = .decimalPad
        text.addBottomBorder(Colors.lightGray, height: 1)
        
        return text
    }
}
