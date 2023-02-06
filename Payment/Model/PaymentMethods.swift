import Foundation
import RealmSwift
import IGListKit
import ObjectMapper

class PaymentMethods: Object, Mappable {
    
    @objc dynamic var id: String = empty
    @objc dynamic var name: String = empty
    @objc dynamic var paymentTypeId: String = empty
    @objc dynamic var status: String = empty
    @objc dynamic var secureThumbnail: String = empty
    @objc dynamic var thumbnail: String = empty
    
    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["name"]
        paymentTypeId       <- map["payment_type_id"]
        status              <- map["status"]
        secureThumbnail     <- map["secure_thumbnail"]
        thumbnail           <- map["thumbnail"]
    }
}

extension PaymentMethods: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let other = object as? PaymentMethods else { return false }
        return self.id == other.id
        
    }
}

extension PaymentMethods {
    
    //Create a Realm Object
    class  func parseItem(json: JSONDictionary) -> PaymentMethods {
        guard let paymentMethod = PaymentMethods(JSON: json) else { return PaymentMethods() }
        
        return paymentMethod
    }
    
    class func parseCollection(array: [JSONDictionary]) -> [PaymentMethods] {
        do {
            let realm = try Realm()
            
            deleteAll()
            
            var paymentMethods = [PaymentMethods]()
            
            try realm.write {
                for info in array {
                    let PaymentMethod: PaymentMethods = self.parseItem(json: info)
                    
                    let tempImage = UIImageView()
                    tempImage.sd_setImage(with: URL(string: PaymentMethod.thumbnail), placeholderImage: nil, options: [.continueInBackground, .highPriority])
                    
                    realm.add(PaymentMethod)
                    paymentMethods.append(PaymentMethod)
                }
            }
            return paymentMethods
        } catch {
            log.error("[PaymentMethods] Error Opening Realm Instance or Writing on parseCollection")
        }
        return [PaymentMethods()]
    }
    
    class func deleteAll() {
        do {
            let realm = try Realm()
            let oldPaymentMethod = realm.objects(PaymentMethods.self)
            
            try realm.write {
                realm.delete(oldPaymentMethod)
            }
        } catch {
            log.error("[PaymentMethods] Error Opening Realm Instance or Writing on deleteAll")
        }
    }
    
    class func parse(json: JSONDictionary) -> PaymentMethods {
        do {
            let realm = try Realm()
            
            guard let paymentMethod = PaymentMethods(JSON: json) else { return PaymentMethods() }
            
            try realm.write {
                realm.add(paymentMethod)
            }
            
            return paymentMethod
        } catch {
            log.error("[PaymentMethods] Error Opening Realm Instance or Writing on parse")
        }
        return PaymentMethods()
    }
    
    class func parseCollectionSync(array: [JSONDictionary]) -> [PaymentMethods] {
        do {
            let realm = try Realm()
            
            let original = Set(realm.objects(PaymentMethods.self))
            
            var paymentMethods = [PaymentMethods]()
            
            try realm.write {
                for info in array {
                    let PaymentMethod: PaymentMethods = self.parseItem(json: info)
                    realm.add(PaymentMethod)
                    paymentMethods.append(PaymentMethod)
                }
            }
            syncWithCloud(originalSet: original, actualArray: paymentMethods)
            
            return paymentMethods
        } catch {
            log.error("[PaymentMethods] Error Opening Realm Instance or Writing on parseCollectionSync")
        }
        return [PaymentMethods()]
    }
    
    class private func syncWithCloud(originalSet: Set<PaymentMethods>, actualArray: [PaymentMethods] ) {
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
            log.error("[PaymentMethods] Error Opening Realm Instance or Writing on syncWithCloud")
        }
    }
    
}
