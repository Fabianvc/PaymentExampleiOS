import UIKit
import SnapKit
import Combine

class HomeViewController: UIViewController {
    private lazy var checkoutButton = setupButton()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callNetwork()
        
        self.setupTab(title: Keys.Home.title.rawValue)
        self.configureUI()
        self.setupConstraints()
        self.subscribeUIComponents()
    }
    
    private func setupTab(title: String){
        guard let topViewController = self.navigationController?.topViewController else { return }
        topViewController.title = title
    }
    
    private func configureUI(){
        view.backgroundColor = Colors.black
        view.addSubview(checkoutButton)
    }
    
    private func setupConstraints() {
        checkoutButton.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.width.equalTo(250)
            $0.center.equalToSuperview()
        }
    }

    private func callNetwork() {
        Client.PaymentMethods.get { (success, data, error) in
            log.debug("PaymentMethods Success: \(success)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

private extension HomeViewController {
    func subscribeUIComponents() {
        checkoutButton
            .publisher(for: .touchUpInside)
            .sink { [weak self] _ in
                self?.option1Tapped()
            }
            .store(in: &cancellables)
    }

    private func option1Tapped(){
        log.debug("Buy")
        self.navigationController?.pushViewController(BuyViewController(), animated: true)
    }
}


private extension HomeViewController {    
    func setupButton() -> UIButton {
        let button = UIButton()
        button.setTitle(Keys.Home.button.rawValue, for: UIControlState.normal)
        button.backgroundColor = Colors.white
        button.setTitleColor(Colors.black, for: .normal)
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        button.layer.borderColor = Colors.white.cgColor
            
        return button
    }
}

