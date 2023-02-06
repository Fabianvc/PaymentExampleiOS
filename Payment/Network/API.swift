import Foundation
import Alamofire

typealias JSONDictionary = [String: Any]

struct Resource<A> {
    let url: URL
    let method: HTTPMethod
    let params: JSONDictionary?
    let parse: (Any?) -> A?
    
    init(url: URL, method: HTTPMethod = .get, params: JSONDictionary? = nil, parseJSON: @escaping (Any) -> A?) {
        self.url = url
        self.method = method
        self.params = params
        self.parse = { json in
            return json.flatMap { parseJSON($0) }
        }
    }
}

final class API {
    class func request<A>(resource: Resource<A>, completion: @escaping (A?, [JSONDictionary]?, String?) -> Void) {
        AlamofireAppManager.shared.request(
            resource.url.absoluteString,
            method: resource.method,
            parameters: resource.params,
            encoding: URLEncoding.default
            
            ).responseJSON { (response) in
                switch response.result {
                case .success:
                    log.verbose("[API][SUCCESS] URL:\(String(describing: response.request?.urlRequest?.url))")
                    break
                case .failure(let error):
                    log.verbose("[API][FAILURE] URL:\(String(describing: response.request?.urlRequest?.url))")
                    log.error("[API][FAILURE] ERROR:\(error)")
                    break
                }
                
                //Server Global Error
                guard let json = response.result.value as? [JSONDictionary] else { return }
                
                completion(resource.parse(json), nil, nil)
        }
    }
}
