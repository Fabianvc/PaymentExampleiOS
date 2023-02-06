import Foundation
import Alamofire

struct AlamofireAppManager {
    
    static let shared: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Client.requestTimeout
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()
    
}
