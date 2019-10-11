import Foundation

class ViewModelsFactory {
    
    static private let apiRepository = ApiSearchItemsRepository()
    static private let itemsRepository = InMemoryItemsRepository()
    static private let searchConfigurationsRepository = InMemorySearchConfigurationsRepository()
    static private let itemDetailsRepository = InMemoryItemDetailsRepository()
    
    static func createItemListViewModel() -> ItemListViewModel {
        let searchItems = createSearchItemsDefault()
        let setItemDetails = createSetItemDetailsDefault()
        let viewModel = ItemListViewModel(searchItemsAction: searchItems, setItemDetailsAction: setItemDetails)
        return viewModel
    }
    
    static func createItemDetailsDefault() -> ItemDetailViewModel {
        let getItemDetails = createGetItemDetailsDefault()
        let viewModel = ItemDetailViewModel(getItemDetailsAction: getItemDetails)
        return viewModel
    }
    
    static func createSearchItemsDefault() -> SearchItemsDefault {
        let searchItems = SearchItemsDefault(apiRepository: apiRepository, itemsRepository: itemsRepository, searchConfigurationsRepository: searchConfigurationsRepository)
        return searchItems
    }
    
    static func createSetItemDetailsDefault() -> SetItemDetailsDefault {
        let setItemDetails = SetItemDetailsDefault(itemsRepository: itemsRepository, itemDetailsRepository: itemDetailsRepository)
        return setItemDetails
    }
    
    static func createGetItemDetailsDefault() -> GetItemDetailsDefault {
        let getItemDetails = GetItemDetailsDefault(itemDetailsRepository: itemDetailsRepository)
        return getItemDetails
    }
}
