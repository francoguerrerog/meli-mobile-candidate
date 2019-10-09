import Foundation

struct AttributesDataResponse: Codable {
    let valueStruct: ValueStruct?
    let values: [ValuesDataResponse]?
    let source: Int?
    let attributeGroupId: String?
    let attributeGroupName: String?
    let id: String?
    let name: String?
    let valueId: String?
    let valueName: String?
    
    enum CodingKeys: String, CodingKey {
        case valueStruct = "value_struct"
        case values = "values"
        case source = "source"
        case attributeGroupId = "attribute_group_id"
        case attributeGroupName = "attribute_group_name"
        case id = "id"
        case name = "name"
        case valueId = "value_id"
        case valueName = "value_name"
    }
}
