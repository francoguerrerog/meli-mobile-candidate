import Foundation

struct ValuesDataResponse: Codable {
    let id: String?
    let name: String?
    let struc: String?
    let source: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case struc = "struct"
        case source = "source"
    }
}
