import XCTest
@testable import meli_mobile_candidate

class GetItemDetailsTests: XCTestCase {
    
    private var itemsRepository: ItemsRepositorySpy!
    private var getItemDetails: GetItemDetailsDefault!
    
    func test_GetItemDetails() {
        givenDependencies()
        givenAnAction()
        
        whenGetItemDetails()
        
        thenFindItemDetails()
    }
    
    fileprivate func givenDependencies() {
        itemsRepository = ItemsRepositorySpy()
    }
    
    fileprivate func givenAnAction() {
        getItemDetails = GetItemDetailsDefault(itemsRepository: itemsRepository)
    }
    
    fileprivate func whenGetItemDetails() {
        _ = getItemDetails.execute(itemId: "1")
    }
    
    fileprivate func thenFindItemDetails() {
        XCTAssertTrue(itemsRepository.hasFind)
    }
}
