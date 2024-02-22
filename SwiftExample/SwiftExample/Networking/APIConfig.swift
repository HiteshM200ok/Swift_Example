import Foundation

typealias queryParameter = [String: Any]

protocol APIConfigProtocol {
      var baseURL: BaseURLPath {get set}
      var endPoint: String { get set }
      var httpMethod: HTTPMethodType  { get set }
      var queryParameter:queryParameter  { get set }
}

struct  APIConfig: APIConfigProtocol {
    var baseURL: BaseURLPath
    var endPoint: String
    var httpMethod: HTTPMethodType
    var queryParameter: queryParameter
    
    init(endPoint: String, 
         httpMethod: HTTPMethodType = .get,
         queryParameter: queryParameter = [:], 
         baseUrl: BaseURLPath = .development) {
        
        self.endPoint = endPoint
        self.httpMethod = httpMethod
        self.queryParameter = queryParameter
        self.baseURL = baseUrl
    }
}
   
