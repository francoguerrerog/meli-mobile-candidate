import Foundation
import RxSwift
@testable import meli_mobile_candidate

class SearchItemsSpy: SearchItems {
    var hasExecuted = false
    func execute(filters: [QueryFilter]) -> Single<SearchResponse> {
        hasExecuted = true
        return Single.just(SearchResponse(items: [], searchConfigurations: SearchConfigurations(query: "", sort: SortDataResponse(id: nil, name: nil), availableSorts: [], filters: [], availableFilters: [])))
    }
}
