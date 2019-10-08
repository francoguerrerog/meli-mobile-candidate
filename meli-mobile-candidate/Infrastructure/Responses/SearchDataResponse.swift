import Foundation

struct SearchDataResponse: Codable {
    let siteId: String
    let query: String
    let paging: PagingDataResponse
    let results: [ItemDataResponse]
    let secondaryResults: [ItemDataResponse]
    let relatedResults: [ItemDataResponse]
    let sort: SortDataResponse
    let availableSorts: [SortDataResponse]
    let filters: [FilterDataResponse]
    let availableFilters: [FilterDataResponse]
    
    enum CodingKeys: String, CodingKey {
        case siteId = "site_id"
        case query = "query"
        case paging = "paging"
        case results = "results"
        case secondaryResults = "secondary_results"
        case relatedResults = "related_results"
        case sort = "sort"
        case availableSorts = "available_sorts"
        case filters = "filters"
        case availableFilters = "available_filters"
    }
}
