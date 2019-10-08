import XCTest
@testable import meli_mobile_candidate

class GetSearchConfigurationsTests: XCTestCase {
    private var searchConfigurationsRepository: SearchConfigurationsRepositorySpy!
    private var getSearchConfigurations: GetSearchConfigurationsDefault!
    
    func test_GetSearchConfigurations() {
        givenDependencies()
        givenAnAction()
        
        whenGetSearchConfigurations()
        
        thenFindSearchConfigurations()
    }
    
    fileprivate func givenDependencies() {
        searchConfigurationsRepository = SearchConfigurationsRepositorySpy()
    }
    
    fileprivate func givenAnAction() {
        getSearchConfigurations = GetSearchConfigurationsDefault(searchConfigurationsRepository: searchConfigurationsRepository)
    }
    
    fileprivate func whenGetSearchConfigurations() {
        _ = getSearchConfigurations.execute()
    }
    
    fileprivate func thenFindSearchConfigurations() {
        XCTAssertTrue(searchConfigurationsRepository.hasFind)
    }
}
