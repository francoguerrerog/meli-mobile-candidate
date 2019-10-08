import XCTest
@testable import meli_mobile_candidate

class GetItemsTests: XCTestCase {
    
    private var itemsRepository: ItemsRepositorySpy!
    private var getItems: GetItemsDefault!
    
    func test_GetItems() {
        givenDependencies()
        givenAnAction()
        
        whenGetItems()
        
        thenFindItems()
    }
    
    fileprivate func givenDependencies() {
        itemsRepository = ItemsRepositorySpy()
    }
    
    fileprivate func givenAnAction() {
        getItems = GetItemsDefault(itemsRepository: itemsRepository)
    }
    
    fileprivate func whenGetItems() {
        _ = getItems.execute()
    }
    
    fileprivate func thenFindItems() {
        XCTAssertTrue(itemsRepository.hasFind)
    }
}
