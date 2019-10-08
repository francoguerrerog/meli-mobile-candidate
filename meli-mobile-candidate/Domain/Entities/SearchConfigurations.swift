import Foundation

struct SearchConfigurations {
    let query: String
    let sort: SortDataResponse
    let availableSorts: [SortDataResponse]
    let filters: [FilterDataResponse]
    let availableFilters: [FilterDataResponse]
}
