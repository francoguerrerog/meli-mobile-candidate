import Foundation
import RxSwift

class ApiSearchItemsRepository: SearchItemsRepository {
    
    private let urlSession = URLSession.shared
    
    func search(filters: [QueryFilter]) -> Single<SearchDataResponse> {
        return Single<SearchDataResponse>.create { single in
            guard let url = self.builSearchdUrlWithParameters(filters) else {
                return single(.error(ApiError.urlError)) as! Disposable
            }
            
            var urlRequest = URLRequest(url: url,
                                        cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                        timeoutInterval: 10.0 * 1000)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = self.urlSession.dataTask(with: urlRequest) { (data, response, error) -> Void in
                guard error == nil else {
                    print("Api Error---- \(error.debugDescription)")
                    return single(.error(ApiError.fetchingError))
                }
                
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.timeZone = TimeZone(secondsFromGMT: 0)
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                
                guard let data = data,
                    let responseObject = try? decoder.decode(SearchDataResponse.self, from: data) else {
                        print("Api Error---- \(error.debugDescription)")
                        return single(.error(ApiError.fetchingError))
                }
                
                return single(.success(responseObject))
            }
            
            task.resume()
            return Disposables.create { }
        }
    }
    
    private func builSearchdUrlWithParameters(_ parameters: [QueryFilter]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.mercadolibre.com"
        urlComponents.path = "/sites/MLA/search"
        let queryParams: [String: String] = parameters.reduce([String: String](), { (dict, query) -> [String: String] in
            var dict = dict
            dict[query.key] = query.value
            return dict
        })
        urlComponents.setQueryItems(with: queryParams)
        
        return urlComponents.url
    
    }
}
