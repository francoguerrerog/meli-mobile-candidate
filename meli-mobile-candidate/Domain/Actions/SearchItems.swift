import Foundation
import RxSwift

protocol SearchItems {
    func execute(filters: [QueryFilter]) -> Single<[ItemDataResponse]>
}

class SearchItemsDefault: SearchItems {
    private let apiRepository: SearchItemsRepository
    private let itemsRepository: ItemsRepository
    private let searchConfigurationsRepository: SearchConfigurationsRepository
    init(apiRepository: SearchItemsRepository, itemsRepository: ItemsRepository, searchConfigurationsRepository: SearchConfigurationsRepository) {
        self.apiRepository = apiRepository
        self.itemsRepository = itemsRepository
        self.searchConfigurationsRepository = searchConfigurationsRepository
    }
    
    func execute(filters: [QueryFilter]) -> Single<[ItemDataResponse]> {
        return apiRepository.search(filters: filters)
            .do(onSuccess: { (result) in
                self.saveItemsFromResponse(result)
                self.saveSearchConfigurationsFromResponse(result)
            }).map{$0.results}
    }
    
    private func saveItemsFromResponse(_ searchResponse: SearchDataResponse) {
        self.itemsRepository.put(searchResponse.results)
    }
    
    private func saveSearchConfigurationsFromResponse(_ searchResponse: SearchDataResponse) {
        let configurations = SearchConfigurations(query: searchResponse.query,
                                                  sort: searchResponse.sort,
                                                  availableSorts: searchResponse.availableSorts,
                                                  filters: searchResponse.filters,
                                                  availableFilters: searchResponse.availableFilters)
        self.searchConfigurationsRepository.put(configurations)
    }
}
