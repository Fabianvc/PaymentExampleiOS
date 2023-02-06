import Foundation

extension C.Urls {
    
    struct Domains {
        static let Prod = "https://api.mercadopago.com"
        static let Local = ""
        static let Device = ""
    }
    
    public struct BucketDomains {
        static let Prod = "cl"
        static let Local = "local"
        static let Device = "local"
    }
    
    public struct EndPoints {
        static let paymentMethods = "payment_methods"
        static let cardIssues = "payment_methods/card_issuers"
        static let installments = "payment_methods/installments"
    }
    
    struct Routes {
        static let Api = "/v1/"
    }
    
    static let Route = Routes.Api
    static let BaseURL = Domain + Route
    
    static var AppBaseUrl: String {
        return BaseURL
    }
    
    static var AppVersion: String {
        return Version
    }
    
    static var ContentType: String {
        return "application/json"
        
    }
    
    static var ApiPaymentMethods: String {
        return BaseURL + EndPoints.paymentMethods
    }
    
    static var ApiCardIssues: String {
        return BaseURL + EndPoints.cardIssues
    }
    
    static var ApiInstallments: String {
        return BaseURL + EndPoints.installments
    }
}
