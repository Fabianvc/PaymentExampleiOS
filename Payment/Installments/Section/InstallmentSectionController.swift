import UIKit
import SDWebImage
import IGListKit
import RealmSwift

class InstallmentSectionController: ListSectionController {
    var list = [Installments]()
    
    var width: CGFloat = .zero
    var amount: String = empty
    var payment: String = empty
    var issuer: String = empty

    override init() {
        super.init()
        minimumLineSpacing = .zero
        minimumInteritemSpacing = .zero
        inset = UIEdgeInsets(top: .zero, left: .zero, bottom: 10, right: .zero)
    }
}

extension InstallmentSectionController {

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: width, height: 40)
    }

    override func didUpdate(to object: Any) {
        guard let dataList = object as? InstallmentList else { fatalError("Incorrect class") }
        self.list = dataList.list
        self.width = dataList.sectionWidth
        self.amount = dataList.amount
        self.payment = dataList.payment
        self.issuer = dataList.issuer
    }

    override func didSelectItem(at index: Int) {
        let data = list[index]
        presentAlet(data: data)
    }

    func presentAlet(data: Installments) {
        let message = "Esta seguro de realizar el siguiente pago:\n" +
        "\nMedio de pago: \(detailPayment(id: self.payment))" +
        "\nBanco: \(detailBank(id: self.issuer))" +
        "\nMonto: $\(amount) Pesos." +
        "\nCuotas: \(data.recommendedMessage)" +
        "\n"
        
        let alert = UIAlertController(
            title: Keys.Alert.title.rawValue,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert)

        alert.addAction(
            UIAlertAction(
                title: Keys.Alert.cancel.rawValue,
                style: .destructive,
                handler: { action in }
            )
        )

        alert.addAction(
            UIAlertAction(
                title: Keys.Alert.success.rawValue,
                style: .default,
                handler: { _ in
                    self.viewController?.navigationController?.popToRootViewController(animated: true)
                }
            )
        )

        self.viewController?.present(alert, animated: true, completion: nil)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext else {
            assertionFailure("collection context is nil"); return UICollectionViewCell()
        }
        let cell = context.dequeueReusableCell(
            of: InstallmentCollectionViewCell.self,
            for: self,
            at: index
        ) as! InstallmentCollectionViewCell
        
        let data = list[index]

        cell.avatarUrl.image = nil
        cell.labelTitle.text = data.recommendedMessage

        return cell
    }
}


private func detailPayment(id: String) -> String {
    do {
        let realm = try Realm()
        let temps = Array(realm.objects(PaymentMethods.self).filter({ $0.id == id }))
        var tempName = [String]()
        for t in temps { tempName.append(t.name) }
        return tempName.first!
    } catch {
        log.error("[Error] Error Opening Realm Instance detailPayment")
        return ""
    }
}

private func detailBank(id: String) -> String {
    do {
        let realm = try Realm()
        let temps = Array(realm.objects(CardIssuers.self).filter({ $0.id == id }))
        var tempName = [String]()
        for t in temps { tempName.append(t.name) }
        return tempName.first!
    } catch {
        log.error("[Error] Error Opening Realm Instance detailBank")
        return ""
    }
}
