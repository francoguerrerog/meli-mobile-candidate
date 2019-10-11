import Foundation
import RxSwift
@testable import meli_mobile_candidate

class SearchItemsSpy: SearchItems {
    var hasExecuted = false
    func execute(filters: [QueryFilter]) -> Single<SearchResponse> {
        hasExecuted = true
        return Single.just(SearchResponse(items: [], searchConfigurations: SearchConfigurations(query: "query", sort: SortDataResponse(id: "id", name: "name"), availableSorts: [], filters: [], availableFilters: [])))
    }
}
