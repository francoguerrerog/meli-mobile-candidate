import XCTest
import RxSwift
import RxBlocking
@testable import meli_mobile_candidate

class SetItemDetailsTests: XCTestCase {
    
    private var itemsRepository: ItemsRepositorySpy!
    private var itemDetailsRepository: ItemDetailsRepositorySpy!
    private var setItemDetails: SetItemDetailsDefault!
    

    func test_SetItemDetails() {
        itemsRepository = ItemsRepositorySpy()
        itemDetailsRepository = ItemDetailsRepositorySpy()
        setItemDetails = SetItemDetailsDefault(itemsRepository: itemsRepository, itemDetailsRepository: itemDetailsRepository)
        
        let result = setItemDetails.execute(itemId: "itemId").toBlocking().materialize()
        
        switch result {
        case .completed:
            XCTAssertTrue(itemsRepository.hasFind)
            XCTAssertTrue(itemDetailsRepository.hasPut)
        default:
            XCTFail()
        }
    }
}
