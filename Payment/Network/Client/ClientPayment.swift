import Foundation

extension Client {
    
    struct PaymentMethods {
        
        static func get(completion: ((Bool, [JSONDictionary]?, String?) -> Void)?) {
            
            let sessionUser = SessionUser()
            let query = sessionUser.paymentMethods { (_, error, code) in
                completion?(false, error, code)
            }
            
            API.request(resource: query) { (state, error, code) in
                completion?(state != nil, error, code)
            }
        }
        
        static func cardIssuers(code: String, completion: ((Bool, [JSONDictionary]?, String?) -> Void)?) {
            
            let sessionUser = SessionUser()
            let query = sessionUser.cardIssuers(code: code, completion: { (_, error, code) in
                completion?(false, error, code)
            })
            
            API.request(resource: query) { (state, error, code) in
                completion?(state != nil, error, code)
            }
        }
        
        static func installments(amount: String, payment: String, issuer: String, completion: ((Bool, [JSONDictionary]?, String?) -> Void)?) {
            
            let sessionUser = SessionUser()
            let query = sessionUser.installments(amount: amount, payment: payment, issuer: issuer, completion: { (_, error, code) in
                completion?(false, error, code)
            })
            
            API.request(resource: query) { (state, error, code) in
                completion?(state != nil, error, code)
            }
        }
        
    }
}
