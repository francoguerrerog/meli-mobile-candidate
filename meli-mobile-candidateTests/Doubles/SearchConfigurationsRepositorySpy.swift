import Foundation
@testable import meli_mobile_candidate

class SearchConfigurationsRepositorySpy: SearchConfigurationsRepository {
    var hasFind = false
    var hasPut = false
    
    func find() -> SearchConfigurations? {
        hasFind = true
        return SearchConfigurations(query: "query", sort: SortDataResponse(id: "id", name: "name"), availableSorts: [], filters: [], availableFilters: [])
    }
    
    func put(_ searchConfigurations: SearchConfigurations) {
        hasPut = true
    }
}
