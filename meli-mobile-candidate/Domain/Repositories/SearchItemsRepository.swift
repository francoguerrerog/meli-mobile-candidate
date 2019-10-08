import Foundation
import RxSwift

protocol SearchItemsRepository {
    func search(filters: [QueryFilter]) -> Single<SearchDataResponse>
}
