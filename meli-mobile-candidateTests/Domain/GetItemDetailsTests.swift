import XCTest
@testable import meli_mobile_candidate

class GetItemDetailsTests: XCTestCase {
    
    private var itemDetailsRepository: ItemDetailsRepositorySpy!
    private var getItemDetails: GetItemDetailsDefault!
    
    func test_GetItemDetails() {
        givenDependencies()
        givenAnAction()
        
        whenGetItemDetails()
        
        thenFindItemDetails()
    }
    
    fileprivate func givenDependencies() {
        itemDetailsRepository = ItemDetailsRepositorySpy()
    }
    
    fileprivate func givenAnAction() {
        getItemDetails = GetItemDetailsDefault(itemDetailsRepository: itemDetailsRepository)
    }
    
    fileprivate func whenGetItemDetails() {
        _ = getItemDetails.execute()
    }
    
    fileprivate func thenFindItemDetails() {
        XCTAssertTrue(itemDetailsRepository.hasFind)
    }
}
