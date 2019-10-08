import XCTest
import RxSwift
import RxBlocking
@testable import meli_mobile_candidate

class SearchItemsTests: XCTestCase {

    private var searchItems: SearchItemsDefault!
    private let query = QueryFilter(key: "q", value: "moto")
    private let category = QueryFilter(key: "category", value: "MLA1055")
    
    private var filters: [QueryFilter]!
    private var apiRepository: SearchItemsRepositorySpy!
    private var itemsRepository: ItemsRepositorySpy!
    private var searchConfigurationsRepository: SearchConfigurationsRepositorySpy!
    
    func test_SearchItems() {
        givenDependencies()
        givenAnAction()
        
        whenSearchItems()
        
        thenSaveInRepositories()
        
    }
    
    fileprivate func givenDependencies() {
        filters = [query, category]
        apiRepository = SearchItemsRepositorySpy()
        itemsRepository = ItemsRepositorySpy()
        searchConfigurationsRepository = SearchConfigurationsRepositorySpy()
    }
    
    fileprivate func givenAnAction() {
        searchItems = SearchItemsDefault(apiRepository: apiRepository, itemsRepository: itemsRepository, searchConfigurationsRepository: searchConfigurationsRepository)
    }
    
    fileprivate func whenSearchItems() {
        _ = searchItems.execute(filters: filters).toBlocking().materialize()
    }
    
    fileprivate func thenSaveInRepositories() {
        XCTAssertEqual(apiRepository.filters.count, filters.count)
        XCTAssertTrue(apiRepository.hasSearched)
        XCTAssertTrue(itemsRepository.hasPut)
        XCTAssertTrue(searchConfigurationsRepository.hasPut)
    }

}
