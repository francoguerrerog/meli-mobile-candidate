import XCTest
import RxSwift
@testable import meli_mobile_candidate

class GetItemFullDetailsTests: XCTestCase {

    private let itemId = "1234"
    
    private var getItemDetail: GetItemFullDetailsDefault!
    private var itemDetailRepository: ItemDetailRepositorySpy!
    
    func test_GetItemDetail() {
        itemDetailRepository = ItemDetailRepositorySpy()
        getItemDetail = GetItemFullDetailsDefault(itemDetailRepository: itemDetailRepository)
        
        _ = getItemDetail.execute(itemId: itemId).toBlocking().materialize()
        
        XCTAssertTrue(itemDetailRepository.hasFind)
    }
}

