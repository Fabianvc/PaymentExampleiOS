import UIKit
import RealmSwift
import IGListKit
import SnapKit

class CardIssuerViewController: UIViewController {
    
    // MARK: - IGList sections
    var card = CardList(id: .zero, list: [])
    
    var amount: String = empty
    var payment: String = empty
    
    private lazy var bankLabel = setupBankLabel()
    private lazy var collectionView = setupCollectionView()
    private lazy var adapter = setupAdapter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dataLocal = self.localData() {
            self.card.list = Array(dataLocal)
            log.debug("\(card.list.count)")
        }
        self.card.sectionWidth = self.view.frame.width
        self.card.amount = self.amount
        self.card.payment = self.payment
        
        self.setupTab(title: Keys.Transversal.titleBank.rawValue)
        self.configureUI()
        self.setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupTab(title: String){
        guard let topViewController = self.navigationController?.topViewController else {
            return
        }
        
        topViewController.title = title
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.black
        view.addSubview(bankLabel)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        bankLabel.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.width.equalTo(250)
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(bankLabel.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    private func localData() -> Results<CardIssuers>? {
        do {
            let realm = try Realm()
            let query = realm.objects(CardIssuers.self)
            return query
        } catch {
            log.error("[Error] Error Opening Realm Instance on it on CardIssuerViewController on viewDidLoad")
        }
        return nil
    }
    
}

// MARK: - IGList ListAdapterDataSource
extension CardIssuerViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return [card]
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is CardList {
            return CardSectionController()
        }
        return ListSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return UIView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        card.sectionWidth = view.frame.width
        adapter.reloadData(completion: nil)
    }
}

//MARK: Components

extension CardIssuerViewController {
    func setupBankLabel() -> UILabel {
        let label = UILabel()
        label.text = Keys.Transversal.bank.rawValue
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
