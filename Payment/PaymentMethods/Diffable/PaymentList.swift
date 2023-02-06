import IGListKit

class PaymentList: NSObject, ListDiffable {
    var list: [PaymentMethods]
    
    let id: Int
    var sectionWidth: CGFloat = 0.0
    var amount: String = empty
    
    init(id: Int, list: [PaymentMethods]) {
        self.id = id
        self.list = list
        super.init()
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return NSNumber(value: id)
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard
            let other = object as? PaymentList,
            list.count == other.list.count,
            sectionWidth == other.sectionWidth,
            amount == other.amount
            else { return false }
        for (index, element) in list.enumerated() {
            if element.isEqual(toDiffableObject: other.list[index]) == false {
                return false
            }
        }
        return true
    }
}

