import Foundation

struct PagingDataResponse: Codable {
    let total: Int?
    let offset: Int?
    let limit: Int?
    let primaryResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case total = "total"
        case offset = "offset"
        case limit = "limit"
        case primaryResults = "primary_results"
    }
}
