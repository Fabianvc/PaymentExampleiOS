import Foundation
import RealmSwift
import IGListKit
import ObjectMapper

class StringObject: Object {
    @objc dynamic var value = "0"
}

class Installments: Object, Mappable {

    @objc dynamic var id: Int = .zero
    @objc dynamic var recommendedMessage: String = empty
    @objc dynamic var installmentAmount: Double = 0.0
    @objc dynamic var totalAmount: Double = 0.0
    var labels = List<StringObject>()

    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id                  <- map["installments"]
        recommendedMessage  <- map["recommended_message"]
        installmentAmount   <- map["installment_amount"]
        totalAmount         <- map["total_amount"]

        var label: [String]? = nil
        label   <- (map["labels"])
        label?.forEach { item in
            let index = StringObject()
            index.value = item
            self.labels.append(index)
        }
    }
}

extension Installments: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let other = object as? Installments else { return false }
        return self.id == other.id

    }
}

extension Installments {

    //Create a Realm Object
    class  func parseItem(json: JSONDictionary) -> Installments {
        guard let installment = Installments(JSON: json) else { return Installments() }

        return installment
    }

    class func parseCollection(array: [JSONDictionary]) -> [Installments] {
        do {
            let realm = try Realm()

            deleteAll()

            var installments = [Installments]()

            try realm.write {
                for info in array {
                    let installment: Installments = self.parseItem(json: info)

                    realm.add(installment)
                    installments.append(installment)
                }
            }
            return installments
        } catch {
            log.error("[Installments] Error Opening Realm Instance or Writing on parseCollection")
        }
        return [Installments()]
    }

    class func deleteAll() {
        do {
            let realm = try Realm()
            let oldInstallment = realm.objects(Installments.self)

            try realm.write {
                realm.delete(oldInstallment)
            }
        } catch {
            log.error("[Installments] Error Opening Realm Instance or Writing on deleteAll")
        }
    }

    class func parse(json: JSONDictionary) -> Installments {
        do {
            let realm = try Realm()

            guard let installment = Installments(JSON: json) else { return Installments() }

            try realm.write {
                realm.add(installment)
            }

            return installment
        } catch {
            log.error("[Installments] Error Opening Realm Instance or Writing on parse")
        }
        return Installments()
    }

    class func parseCollectionSync(array: [JSONDictionary]) -> [Installments] {
        do {
            let realm = try Realm()

            let original = Set(realm.objects(Installments.self))

            var installments = [Installments]()

            try realm.write {
                for info in array {
                    let Installment: Installments = self.parseItem(json: info)
                    realm.add(Installment)
                    installments.append(Installment)
                }
            }
            syncWithCloud(originalSet: original, actualArray: installments)

            return installments
        } catch {
            log.error("[Installments] Error Opening Realm Instance or Writing on parseCollectionSync")
        }
        return [Installments()]
    }

    class private func syncWithCloud(originalSet: Set<Installments>, actualArray: [Installments] ) {
        do {
            let realm = try Realm()

            let intersect = originalSet.intersection(actualArray)
            let itemsDeleted = originalSet.subtracting(intersect)

            try realm.write {
                for item in itemsDeleted {
                    if originalSet.contains(item) {
                        log.info("removing this item \(item.id)")
                        realm.delete(item)
                    }
                }
            }
        } catch {
            log.error("[Installments] Error Opening Realm Instance or Writing on syncWithCloud")
        }
    }

}
