import XCTest
import RxSwift
import RxBlocking
import RxTest
@testable import meli_mobile_candidate

class ItemListViewModelTests: XCTestCase {
    
    private var viewModel: ItemListViewModel!
    private var searchItems: SearchItemsSpy!

    private var testScheduler: TestScheduler!
    private var itemListObserver: TestableObserver<[Item]>!
    private var searchConfigurationsObserver: TestableObserver<SearchConfigurations>!
    
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        testScheduler = TestScheduler(initialClock: 0)
        itemListObserver = testScheduler.createObserver([Item].self)
        searchConfigurationsObserver = testScheduler.createObserver(SearchConfigurations.self)
    }
    
    func test_GetSearchResponse() {
        searchItems = SearchItemsSpy()
        viewModel = ItemListViewModel(searchItemsAction: searchItems)
        
        viewModel.search(queryParams: [])
        
        XCTAssertTrue(searchItems.hasExecuted)
    }
    
    func test_EmitItems() {
        testScheduler.start()
        searchItems = SearchItemsSpy()
        viewModel = ItemListViewModel(searchItemsAction: searchItems)
        
        viewModel.output.itemList.subscribe(itemListObserver).disposed(by: disposeBag)
        viewModel.search(queryParams: [])
        
        let events = itemListObserver.events
        XCTAssertEqual(events.count, 1)
    }
    
    func test_EmitSearchConfiguration() {
        testScheduler.start()
        searchItems = SearchItemsSpy()
        viewModel = ItemListViewModel(searchItemsAction: searchItems)
        
        viewModel.output.searchConfigurations.subscribe(searchConfigurationsObserver).disposed(by: disposeBag)
        viewModel.search(queryParams: [])
        
        let events = searchConfigurationsObserver.events
        XCTAssertEqual(events.count, 1)
    }
}
