import Foundation
import RxSwift

protocol SearchItems {
    func execute(filters: [QueryFilter]) -> Single<SearchResponse>
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
    
    func execute(filters: [QueryFilter]) -> Single<SearchResponse> {
        return apiRepository.search(filters: filters)
            .do(onSuccess: { (result) in
                self.saveItemsFromResponse(result)
                self.saveSearchConfigurationsFromResponse(result)
            }).map{self.createSearchResponse($0)}
    }
    
    private func createSearchResponse(_ searchDataResponse: SearchDataResponse) -> SearchResponse {
        let items = createItems(searchDataResponse)
        let configurations = createSearchConfigurations(searchDataResponse)
        
        return SearchResponse(items: items, searchConfigurations: configurations)
    }
    
    private func createItems(_ searchDataResponse: SearchDataResponse) -> [Item] {
        return searchDataResponse.results.map{Item(itemDataResponse: $0)}
    }
    
    private func createSearchConfigurations(_ searchDataResponse: SearchDataResponse) -> SearchConfigurations {
        return SearchConfigurations(query: searchDataResponse.query,
                                    sort: searchDataResponse.sort,
                                    availableSorts: searchDataResponse.availableSorts,
                                    filters: searchDataResponse.filters,
                                    availableFilters: searchDataResponse.availableFilters)
    }
    
    private func saveItemsFromResponse(_ searchDataResponse: SearchDataResponse) {
        let items = createItems(searchDataResponse)
        self.itemsRepository.put(items)
    }
    
    private func saveSearchConfigurationsFromResponse(_ searchDataResponse: SearchDataResponse) {
        let configurations = createSearchConfigurations(searchDataResponse)
        self.searchConfigurationsRepository.put(configurations)
    }
}
