import IGListKit

class InstallmentList: NSObject, ListDiffable {
    var list: [Installments]
    
    let id: Int
    var sectionWidth: CGFloat = 0.0
    var amount: String = empty
    var payment: String = empty
    var issuer: String = empty
    
    
    init(id: Int, list: [Installments]) {
        self.id = id
        self.list = list
        super.init()
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return NSNumber(value: id)
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard
            let other = object as? InstallmentList,
            list.count == other.list.count,
            sectionWidth == other.sectionWidth,
            amount == other.amount,
            payment == other.payment,
            issuer == other.issuer
            else { return false }
        for (index, element) in list.enumerated() {
            if element.isEqual(toDiffableObject: other.list[index]) == false {
                return false
            }
        }
        return true
    }
}



