import XCTest
import RxTest
import RxSwift
@testable import meli_mobile_candidate

class ItemDetailViewModelTests: XCTestCase {
    
    private var viewModel: ItemDetailViewModel!
    private var getItemDetails: GetItemDetailsSpy!
    private var getItemFullDetails: GetItemFullDetailsSpy!
    
    private var testScheduler: TestScheduler!
    private var itemObserver: TestableObserver<Item>!
    private var itemDetailsObserver: TestableObserver<ItemDetailResponse>!
    
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        testScheduler = TestScheduler(initialClock: 0)
        itemObserver = testScheduler.createObserver(Item.self)
        itemDetailsObserver = testScheduler.createObserver(ItemDetailResponse.self)
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
    
    func test_GetItemFullDetails() {
        givenDependencies()
        givenAViewModel()
        
        whenGetItemDetails()
        
        thenGetItemDetails()
    }
    
    func test_EmitItemFullDetails() {
        testScheduler.start()
        givenDependencies()
        givenAViewModel()
        
        viewModel.output.itemDetails.subscribe(itemDetailsObserver).disposed(by: disposeBag)
        whenGetItemDetails()
        
        thenEmitItemFullDetails()
    }
    
    fileprivate func givenDependencies() {
        getItemDetails = GetItemDetailsSpy()
        getItemFullDetails = GetItemFullDetailsSpy()
    }
    
    fileprivate func givenAViewModel() {
        viewModel = ItemDetailViewModel(getItemDetailsAction: getItemDetails, getItemFullDetailsAction: getItemFullDetails)
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
    
    fileprivate func thenGetItemFullDetails() {
        XCTAssertTrue(getItemFullDetails.hasExecuted)
    }
    
    fileprivate func thenEmitItemFullDetails() {
        let events = itemDetailsObserver.events
        XCTAssertEqual(events.count, 1)
    }

}
