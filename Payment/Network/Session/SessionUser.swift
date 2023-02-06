import Foundation
import Alamofire

class SessionUser {
    func paymentMethods(completion: @escaping ((Bool, [JSONDictionary]?, String?) -> Void)) -> Resource<[PaymentMethods]> {
        log.verbose("[SessionUser] paymentMethods() Perfom: \((C.Urls.ApiPaymentMethods))")
        let url = URL(string: C.Urls.ApiPaymentMethods)!

        let params: JSONDictionary = [
            "public_key": C.App.PublicKey
        ]

        return Resource(url: url, method: .get, params: params, parseJSON: { (response) -> [PaymentMethods]? in
            guard let responseJson = response as? [JSONDictionary] else {
                    log.warning("[SessionUser] paymentMethods() error detected")
                    return nil
            }

            let paymentMethods = PaymentMethods.parseCollection(array: responseJson)
            return paymentMethods
        })
    }

    func cardIssuers(code: String ,completion: @escaping ((Bool, [JSONDictionary]?, String?) -> Void)) -> Resource<[CardIssuers]> {
        log.verbose("[SessionUser] paymentMethods() Perfom: \((C.Urls.ApiCardIssues))")
        let url = URL(string: C.Urls.ApiCardIssues)!

        let params: JSONDictionary = [
            "public_key": C.App.PublicKey,
            "payment_method_id": code
        ]

        return Resource(url: url, method: .get, params: params, parseJSON: { (response) -> [CardIssuers]? in
            guard let responseJson = response as? [JSONDictionary] else {
                log.warning("[SessionUser] paymentMethods() error detected")
                return nil
            }

            let cardIssuers = CardIssuers.parseCollection(array: responseJson)
            return cardIssuers
        })
    }

    func installments(amount: String, payment: String , issuer: String ,completion: @escaping ((Bool, [JSONDictionary]?, String?) -> Void)) -> Resource<[Installments]> {
        log.verbose("[SessionUser] installments() Perfom: \((C.Urls.ApiInstallments))")
        let url = URL(string: C.Urls.ApiInstallments)!

        let params: JSONDictionary = [
            "public_key": C.App.PublicKey,
            "amount" : amount,
            "payment_method_id": payment,
            "issuer.id": issuer
        ]

        return Resource(url: url, method: .get, params: params, parseJSON: { (response) -> [Installments]? in
            guard let responseJson = response as? [JSONDictionary],
                let dataArray = responseJson.first,
                let data = dataArray["payer_costs"] as? [JSONDictionary] else {
                log.warning("[SessionUser] installments() error detected")
                return nil
            }

            let installments = Installments.parseCollection(array: data)
            return installments
        })
    }
}
