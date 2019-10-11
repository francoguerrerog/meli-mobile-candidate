import XCTest
import RxTest
import RxSwift
@testable import meli_mobile_candidate

class ItemDetailViewModelTests: XCTestCase {
    
    private var viewModel: ItemDetailViewModel!
    private var getItemDetails: GetItemDetailsSpy!
    
    private var testScheduler: TestScheduler!
    private var itemObserver: TestableObserver<Item>!
    
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        testScheduler = TestScheduler(initialClock: 0)
        itemObserver = testScheduler.createObserver(Item.self)
    }
    
    func test_GetItemDetails() {
        givenDependencies()
        givenAViewModel()
        
        whenGetItemDetails()
        
        thenGetItemDetails()
    }
    
    func test_EmitItemDetails() {
        testScheduler.start()
        givenDependencies()
        givenAViewModel()
        
        viewModel.output.item.subscribe(itemObserver).disposed(by: disposeBag)
        whenGetItemDetails()
        
        thenEmitItemDetails()
    }
    
    fileprivate func givenDependencies() {
        getItemDetails = GetItemDetailsSpy()
    }
    
    fileprivate func givenAViewModel() {
        viewModel = ItemDetailViewModel(getItemDetailsAction: getItemDetails)
    }
    
    fileprivate func whenGetItemDetails() {
        viewModel.getItemDetails()
    }
    
    fileprivate func thenGetItemDetails() {
        XCTAssertTrue(getItemDetails.hasExecuted)
    }
    
    fileprivate func thenEmitItemDetails() {
        let events = itemObserver.events
        XCTAssertEqual(events.count, 1)
    }

}
