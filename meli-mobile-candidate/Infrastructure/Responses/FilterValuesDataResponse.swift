import Foundation

struct FilterValuesDataResponse: Codable {
    let id: String?
    let name: String?
    let path_from_root: [PathFromRootDataResponse]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case path_from_root = "path_from_root"
    }
}
