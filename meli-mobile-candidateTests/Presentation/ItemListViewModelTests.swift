import XCTest
import RxSwift
import RxBlocking
import RxTest
@testable import meli_mobile_candidate

class ItemListViewModelTests: XCTestCase {
    
    private var viewModel: ItemListViewModel!
    private var searchItems: SearchItemsSpy!
    private var setItemDetails: SetItemDetailsSpy!

    private var testScheduler: TestScheduler!
    private var itemListObserver: TestableObserver<[Item]>!
    private var filtersObserver: TestableObserver<[FilterViewData]>!
    private var goToItemDetailsObserver: TestableObserver<Void>!
    
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        testScheduler = TestScheduler(initialClock: 0)
        itemListObserver = testScheduler.createObserver([Item].self)
        filtersObserver = testScheduler.createObserver([FilterViewData].self)
        goToItemDetailsObserver = testScheduler.createObserver(Void.self)
    }
    
    func test_GetSearchResponse() {
        givenDependencies()
        givenAViewModel()
        viewModel = ItemListViewModel(searchItemsAction: searchItems, setItemDetailsAction: setItemDetails)
        
        whenSearch()
        
        thenSearch()
    }
    
    func test_EmitItems() {
        givenDependencies()
        givenAViewModel()
        
        viewModel.output.itemList.subscribe(itemListObserver).disposed(by: disposeBag)
        whenSearch()
        
        thenEmitItems()
    }
    
    func test_EmitSearchConfiguration() {
        givenDependencies()
        givenAViewModel()
        
        viewModel.output.filterList.subscribe(filtersObserver).disposed(by: disposeBag)
        whenSearch()
        
        thenEmitFilters()
    }
    
    func test_SelectItem() {
        givenDependencies()
        givenAViewModel()
        
        whenSelectItem()
        
        thenSelectItem()
    }
    
    func test_EmitGoToDetail() {
        givenDependencies()
        givenAViewModel()
        
        viewModel.output.goToItemDetails.subscribe(goToItemDetailsObserver).disposed(by: disposeBag)
        whenSelectItem()
        
        thenEmitGoToItemDetails()
    }
    
    fileprivate func givenDependencies() {
        searchItems = SearchItemsSpy()
        setItemDetails = SetItemDetailsSpy()
        setItemDetails = SetItemDetailsSpy()
    }
    
    fileprivate func givenAViewModel() {
        viewModel = ItemListViewModel(searchItemsAction: searchItems, setItemDetailsAction: setItemDetails)
    }
    
    fileprivate func whenSearch() {
        viewModel.search(queryParams: [])
    }
    
    fileprivate func whenSelectItem() {
        viewModel.selectItem(itemId: "itemId")
    }
    
    fileprivate func thenSearch() {
        XCTAssertTrue(searchItems.hasExecuted)
    }
    
    fileprivate func thenEmitItems() {
        let events = itemListObserver.events
        XCTAssertEqual(events.count, 1)
    }
    
    fileprivate func thenEmitFilters() {
        let events = filtersObserver.events
        XCTAssertEqual(events.count, 1)
    }
    
    fileprivate func thenSelectItem() {
        XCTAssertTrue(setItemDetails.hasExecuted)
    }
    
    fileprivate func thenEmitGoToItemDetails() {
        let events = goToItemDetailsObserver.events
        XCTAssertEqual(events.count, 1)
    }
}
