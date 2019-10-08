import Foundation
@testable import meli_mobile_candidate

class SearchConfigurationsRepositorySpy: SearchConfigurationsRepository {
    var hasFind = false
    var hasPut = false
    
    func find() -> SearchConfigurations? {
        hasFind = true
        return SearchConfigurations(query: "", sort: SortDataResponse(id: nil, name: nil), availableSorts: [], filters: [], availableFilters: [])
    }
    
    func put(_ searchConfigurations: SearchConfigurations) {
        hasPut = true
    }
}
