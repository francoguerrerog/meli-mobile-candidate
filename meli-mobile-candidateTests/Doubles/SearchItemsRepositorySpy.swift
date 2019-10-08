import Foundation
import RxSwift
@testable import meli_mobile_candidate

class SearchItemsRepositorySpy: SearchItemsRepository {
    
    var filters: [QueryFilter] = []
    var hasSearched = false
    
    func search(filters: [QueryFilter]) -> Single<SearchDataResponse> {
        hasSearched = true
        self.filters = filters
        return Single.just(SearchDataResponse(siteId: "", query: "", paging: PagingDataResponse(total: nil, offset: nil, limit: nil, primaryResults: nil), results: [], secondaryResults: [], relatedResults: [], sort: SortDataResponse(id: nil, name: nil), availableSorts: [], filters: [], availableFilters: []))
    }
}
