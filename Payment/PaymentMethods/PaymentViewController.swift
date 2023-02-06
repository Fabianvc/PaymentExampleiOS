import UIKit
import RealmSwift
import IGListKit
import SnapKit

class PaymentViewController: UIViewController {
    
    // MARK: - IGList sections
    var payment = PaymentList(id: .zero, list: [])
    
    var amount: String = empty
    
    private lazy var paymentLabel = setupPaymentLabel()
    private lazy var collectionView = setupCollectionView()
    private lazy var adapter = setupAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dataLocal = self.localData() {
            self.payment.list = Array(dataLocal)
            log.debug("\(payment.list.count)")
        }
        self.payment.sectionWidth = self.view.frame.width
        self.payment.amount = self.amount
        
        self.setupTab(title: Keys.Transversal.titlePayment.rawValue)
        self.configureUI()
        self.setupConstraints()
    }
    
    init() {
        super.init(nibName: .none, bundle: .none)
    }

    convenience init(amount: String) {
        self.init()
        self.amount = amount
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTab(title: String){
        guard let topViewController = self.navigationController?.topViewController else { return }
        topViewController.title = title
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.black
        view.addSubview(paymentLabel)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        paymentLabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(250)
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(paymentLabel.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    private func localData() -> Results<PaymentMethods>? {
        do {
            let realm = try Realm()
            let query = realm.objects(PaymentMethods.self)
            return query
        } catch {
            log.error("[Error] Error Opening Realm Instance on it on PaymentViewController on viewDidLoad")
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - IGList ListAdapterDataSource
extension PaymentViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] { [payment] }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is PaymentList {
            return PaymentSectionController()
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? { UIView() }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        payment.sectionWidth = view.frame.width
        adapter.reloadData(completion: nil)
    }
}

//MARK: Components

extension PaymentViewController {
    func setupPaymentLabel() -> UILabel {
        let label = UILabel()
        label.text = Keys.Transversal.payment.rawValue
        label.textColor = Colors.white
        label.textAlignment = .center
        
        return label
    }
    
    // MARK: - IGList privates
    func setupCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = Colors.black
        return collectionView
    }
    
    func setupAdapter() -> ListAdapter {
        ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: .zero)
    }
}
