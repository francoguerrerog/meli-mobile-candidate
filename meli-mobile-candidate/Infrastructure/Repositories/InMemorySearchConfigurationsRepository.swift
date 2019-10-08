import Foundation

class InMemorySearchConfigurationsRepository: SearchConfigurationsRepository {
    private var searchConfigurations: SearchConfigurations?
    
    func find() -> SearchConfigurations? {
        return searchConfigurations
    }
    
    func put(_ searchConfigurations: SearchConfigurations) {
        self.searchConfigurations = searchConfigurations
    }
}
