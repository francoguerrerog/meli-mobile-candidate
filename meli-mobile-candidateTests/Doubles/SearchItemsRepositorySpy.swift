import Foundation
import RxSwift
@testable import meli_mobile_candidate

class SearchItemsRepositorySpy: SearchItemsRepository {
    
    var filters: [QueryFilter] = []
    var hasSearched = false
    
    func search(filters: [QueryFilter]) -> Single<SearchDataResponse> {
        hasSearched = true
        self.filters = filters
        return Single.just(SearchDataResponse(siteId: "siteId", query: "query", paging: PagingDataResponse(total: 0, offset: 0, limit: 0, primaryResults: 0), results: [], secondaryResults: [], relatedResults: [], sort: SortDataResponse(id: "id", name: "name"), availableSorts: [], filters: [], availableFilters: []))
    }
}
