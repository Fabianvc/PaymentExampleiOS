import UIKit
import RealmSwift
import IGListKit
import SnapKit

class InstallmentViewController: UIViewController {
    
    // MARK: - IGList sections
    var installment = InstallmentList(id: .zero, list: [])
    
    var amount: String = empty
    var payment: String = empty
    var issuer: String = empty
    
    private lazy var installmentLabel = setupQuaotaLabel()
    private lazy var collectionView = setupCollectionView()
    private lazy var adapter = setupAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dataLocal = self.localData() {
            self.installment.list = Array(dataLocal)
            log.debug("\(installment.list.count)")
        }
        self.installment.sectionWidth = self.view.frame.width
        self.installment.amount = self.amount
        self.installment.payment = self.payment
        self.installment.issuer = self.issuer
        
        self.setupTab(title: Keys.Transversal.quotas.rawValue)
        self.configureUI()
        self.setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupTab(title: String){
        guard let topViewController = self.navigationController?.topViewController else { return }
        topViewController.title = title
    }
    
    private func configureUI(){
        view.backgroundColor = Colors.black
        view.addSubview(installmentLabel)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        installmentLabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(250)
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(installmentLabel.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    private func localData() -> Results<Installments>? {
        do {
            let realm = try Realm()
            let query = realm.objects(Installments.self)
            return query
        } catch {
            log.error("[Error] Error Opening Realm Instance on it on InstallmentViewController on viewDidLoad")
        }
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - IGList ListAdapterDataSource
extension InstallmentViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [installment]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is InstallmentList {
            return InstallmentSectionController()
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return UIView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        installment.sectionWidth = view.frame.width
        adapter.reloadData(completion: nil)
    }
}

//MARK: Components

extension InstallmentViewController {
    func setupQuaotaLabel() -> UILabel {
        let label = UILabel()
        label.text = Keys.Transversal.quotas.rawValue
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
