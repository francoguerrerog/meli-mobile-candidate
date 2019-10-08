import Foundation

struct FilterDataResponse: Codable {
    let id: String?
    let name: String?
    let type: String?
    let values: [FilterValuesDataResponse]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case values = "values"
    }
}
