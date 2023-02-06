import UIKit
import SDWebImage
import IGListKit
import RealmSwift

class CardSectionController: ListSectionController {
    var list = [CardIssuers]()
    
    var width: CGFloat = .zero
    var amount: String = empty
    var payment: String = empty
    
    override init() {
        super.init()
        minimumLineSpacing = .zero
        minimumInteritemSpacing = .zero
        inset = UIEdgeInsets(top: .zero, left: .zero, bottom: 10, right: .zero)
    }
}

extension CardSectionController {
    
    override func numberOfItems() -> Int {
        return list.count
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: width, height: 40)
    }
    
    override func didUpdate(to object: Any) {
        guard let dataList = object as? CardList else { fatalError("Incorrect class") }
        self.list = dataList.list
        self.width = dataList.sectionWidth
        self.amount = dataList.amount
        self.payment = dataList.payment
    }
    
    override func didSelectItem(at index: Int) {
        let data = list[index]
        log.debug(data.name)
        
        let installment = InstallmentViewController()
        installment.amount = self.amount
        installment.payment = self.payment
        installment.issuer = data.id
        
        Client.PaymentMethods.installments(amount: self.amount, payment: self.payment, issuer: data.id) { (success, data, error) in
            log.debug("Installment Success: \(success)")
            if success{
                self.viewController?.navigationController?.pushViewController(installment, animated: true)
            }else{
                log.error("[ERROR DIALOG]")
            }
        }
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext else { assertionFailure("collection context is nil"); return UICollectionViewCell() }
        let cell = context.dequeueReusableCell(of: CardCollectionViewCell.self, for: self, at: index) as! CardCollectionViewCell
        let data = list[index]
        
        cell.avatarUrl.sd_setImage(with: URL(string: data.thumbnail), placeholderImage: nil, options: [.cacheMemoryOnly])
        cell.labelTitle.text = data.name
        
        return cell
    }
}


