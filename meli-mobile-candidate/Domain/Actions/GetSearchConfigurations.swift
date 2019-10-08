import Foundation

protocol GetSearchConfigurations {
    func execute() -> SearchConfigurations?
}

class GetSearchConfigurationsDefault: GetSearchConfigurations {
    private let searchConfigurationsRepository: SearchConfigurationsRepository
    
    init(searchConfigurationsRepository: SearchConfigurationsRepository) {
        self.searchConfigurationsRepository = searchConfigurationsRepository
    }
    
    func execute() -> SearchConfigurations? {
        return searchConfigurationsRepository.find()
    }
}
