import Foundation

class ViewModelsFactory {
    
    static private let apiRepository = ApiSearchItemsRepository()
    static private let itemsRepository = InMemoryItemsRepository()
    static private let searchConfigurationsRepository = InMemorySearchConfigurationsRepository()
    
    static func createItemListViewModel() -> ItemListViewModel {
        let searchItems = createSearchItemsDefault()
        let viewModel = ItemListViewModel(searchItemsAction: searchItems)
        return viewModel
    }
    
    static func createSearchItemsDefault() -> SearchItemsDefault {
        let searchItems = SearchItemsDefault(apiRepository: apiRepository, itemsRepository: itemsRepository, searchConfigurationsRepository: searchConfigurationsRepository)
        return searchItems
    }
}
