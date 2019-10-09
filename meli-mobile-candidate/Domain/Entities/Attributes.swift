import Foundation

struct Attributes {
    let valueStruct: ValueStruct
    let values: [ValuesDataResponse]
    let source: Int
    let attributeGroupId: String
    let attributeGroupName: String
    let id: String
    let name: String
    let valueId: String
    let valueName: String
    
    init(attributesDataResponse: AttributesDataResponse) {
        self.valueStruct = attributesDataResponse.valueStruct ?? ValueStruct(number: 0, unit: "")
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
