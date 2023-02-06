import UIKit
import SDWebImage
import IGListKit
import RealmSwift

class PaymentSectionController: ListSectionController {
    var list = [PaymentMethods]()
    
    var width: CGFloat = 0.0
    var amount: String = empty
    
    override init() {
        super.init()
        minimumLineSpacing = 1
        minimumInteritemSpacing = .zero
        inset = UIEdgeInsets(top: .zero, left: .zero, bottom: 10, right: .zero)
    }
}

extension PaymentSectionController {
    
    override func numberOfItems() -> Int {
        return list.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: width, height: 40)
    }
    
    override func didUpdate(to object: Any) {
        guard let dataList = object as? PaymentList else { fatalError("Incorrect class") }
        self.list = dataList.list
        self.width = dataList.sectionWidth
        self.amount = dataList.amount
    }
    
    override func didSelectItem(at index: Int) {
        let data = list[index]
        log.debug(data.name)
        
        let card = CardIssuerViewController()
        card.amount = self.amount
        card.payment = data.id
        
        Client.PaymentMethods.cardIssuers(code: data.id) { (success, data, error) in
            log.debug("CardIssuer Success: \(success)")
            if success{
                self.viewController?.navigationController?.pushViewController(card, animated: true)
            }else{
                log.error("[ERROR]")
            }
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext else { assertionFailure("collection context is nil"); return UICollectionViewCell() }
        let cell = context.dequeueReusableCell(of: PaymentCollectionViewCell.self, for: self, at: index) as! PaymentCollectionViewCell
        
        let data = list[index]
        
        cell.avatarUrl.sd_setImage(with: URL(string: data.thumbnail), placeholderImage: nil, options: [.cacheMemoryOnly])
        cell.labelTitle.text = data.name
        
        return cell
    }
}

