import Foundation
import RealmSwift
import IGListKit
import ObjectMapper

class CardIssuers: Object, Mappable {

    @objc dynamic var id: String = empty
    @objc dynamic var name: String = empty
    @objc dynamic var secureThumbnail: String = empty
    @objc dynamic var thumbnail: String = empty

    //Impl. of Mappable protocol
    required convenience init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["name"]
        secureThumbnail     <- map["secure_thumbnail"]
        thumbnail           <- map["thumbnail"]
    }
}

extension CardIssuers: ListDiffable {
    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let other = object as? CardIssuers else { return false }

        return self.id == other.id
    }
}

extension CardIssuers {

    //Create a Realm Object
    class  func parseItem(json: JSONDictionary) -> CardIssuers {
        guard let cardIssuer = CardIssuers(JSON: json) else { return CardIssuers() }

        return cardIssuer
    }

    class func parseCollection(array: [JSONDictionary]) -> [CardIssuers] {
        do {
            let realm = try Realm()

            deleteAll()

            var cardIssuers = [CardIssuers]()

            try realm.write {
                for info in array {
                    let CardIssuer: CardIssuers = self.parseItem(json: info)

                    let tempImage = UIImageView()
                    tempImage.sd_setImage(with: URL(string: CardIssuer.thumbnail), placeholderImage: nil, options: [.continueInBackground, .highPriority])

                    realm.add(CardIssuer)
                    cardIssuers.append(CardIssuer)
                }
            }
            return cardIssuers
        } catch {
            log.error("[CardIssuers] Error Opening Realm Instance or Writing on parseCollection")
        }
        return [CardIssuers()]
    }

    class func deleteAll() {
        do {
            let realm = try Realm()
            let oldCardIssuer = realm.objects(CardIssuers.self)

            try realm.write {
                realm.delete(oldCardIssuer)
            }
        } catch {
            log.error("[CardIssuers] Error Opening Realm Instance or Writing on deleteAll")
        }
    }

    class func parse(json: JSONDictionary) -> CardIssuers {
        do {
            let realm = try Realm()

            guard let cardIssuer = CardIssuers(JSON: json) else { return CardIssuers() }
            
            try realm.write {
                realm.add(cardIssuer)
            }

            return cardIssuer
        } catch {
            log.error("[CardIssuers] Error Opening Realm Instance or Writing on parse")
        }
        return CardIssuers()
    }

    class func parseCollectionSync(array: [JSONDictionary]) -> [CardIssuers] {
        do {
            let realm = try Realm()

            let original = Set(realm.objects(CardIssuers.self))

            var cardIssuers = [CardIssuers]()

            try realm.write {
                for info in array {
                    let CardIssuer: CardIssuers = self.parseItem(json: info)
                    realm.add(CardIssuer)
                    cardIssuers.append(CardIssuer)
                }
            }
            syncWithCloud(originalSet: original, actualArray: cardIssuers)

            return cardIssuers
        } catch {
            log.error("[CardIssuers] Error Opening Realm Instance or Writing on parseCollectionSync")
        }
        return [CardIssuers()]
    }

    class private func syncWithCloud(originalSet: Set<CardIssuers>, actualArray: [CardIssuers] ) {
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
            log.error("[CardIssuers] Error Opening Realm Instance or Writing on syncWithCloud")
        }
    }
}
