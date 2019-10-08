import Foundation

struct Attributes {
    let valueStruct: String
    let values: [ValuesDataResponse]
    let source: Int
    let attributeGroupId: String
    let attributeGroupName: String
    let id: String
    let name: String
    let valueId: String
    let valueName: String
    
    init(attributesDataResponse: AttributesDataResponse) {
        self.valueStruct = attributesDataResponse.valueStruct ?? ""
        self.values = attributesDataResponse.values ?? []
        self.source = attributesDataResponse.source ?? 0
        self.attributeGroupId = attributesDataResponse.attributeGroupId ?? ""
        self.attributeGroupName = attributesDataResponse.attributeGroupName ?? ""
        self.id = attributesDataResponse.id ?? ""
        self.name = attributesDataResponse.name ?? ""
        self.valueId = attributesDataResponse.valueId ?? ""
        self.valueName = attributesDataResponse.valueName ?? ""
    }
}
