import IGListKit

class CardList: NSObject, ListDiffable {
    var list: [CardIssuers]
    
    let id: Int
    var sectionWidth: CGFloat = 0.0
    var amount: String = empty
    var payment: String = empty
    
    init(id: Int, list: [CardIssuers]) {
        self.id = id
        self.list = list
        super.init()
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return NSNumber(value: id)
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard
            let other = object as? CardList,
            list.count == other.list.count,
            sectionWidth == other.sectionWidth,
            amount == other.amount,
            payment == other.payment
            else { return false }
        for (index, element) in list.enumerated() {
            if element.isEqual(toDiffableObject: other.list[index]) == false {
                return false
            }
        }
        return true
    }
}


