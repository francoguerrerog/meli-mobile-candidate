import Foundation

struct SaleTermResponse: Codable {
    let id: String
    let name: String?
    let value_id: String?
    let value_name: String?
    let value_struct: ValueStruct?
    let values: [ValuesDataResponse]?
}
