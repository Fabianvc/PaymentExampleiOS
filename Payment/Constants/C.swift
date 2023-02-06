import Foundation

struct C {
    
    //Api
    struct Urls {
        //Options are: Local, Life, Prod, Device
        static let Domain = Domains.Prod
        static let AwsBucketDomain = BucketDomains.Prod
        
        static let Version = "v1"//Api
    }
    
    struct App {
        static let debug = false
        static let PublicKey = "ADD Public key"
        
    }

}

/// Global variable is just an empty string
public let empty = ""
