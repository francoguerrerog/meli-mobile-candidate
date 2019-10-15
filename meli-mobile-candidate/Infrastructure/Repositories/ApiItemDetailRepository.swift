import Foundation
import RxSwift

class ApiItemDetailRepository: ItemDetailRepository {
    
    private let urlSession = URLSession.shared
    
    func find(itemId: String) -> Single<ItemDetailResponse> {
        return Single<ItemDetailResponse>.create { single in
            guard let url = self.builSearchdUrlWithParameters(itemId) else {
                return single(.error(ApiError.urlError)) as! Disposable
            }
            
            var urlRequest = URLRequest(url: url,
                                        cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                        timeoutInterval: 10.0 * 1000)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            print("GET---- \(url)")
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
                    let responseObject = try? decoder.decode(ItemDetailResponse.self, from: data) else {
                        print("Api Error---- \(error.debugDescription)")
                        return single(.error(ApiError.fetchingError))
                }
                
                return single(.success(responseObject))
            }
            
            task.resume()
            return Disposables.create { }
        }
    }
    
    private func builSearchdUrlWithParameters(_ parameter: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.mercadolibre.com"
        urlComponents.path = "/items/\(parameter)"
        
        return urlComponents.url
        
    }
}
