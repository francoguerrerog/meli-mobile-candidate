import Foundation

struct VariationReponse: Codable {
    let id: Int
    let price: Double?
    let attribute_combinations: [AttributesDataResponse]?
    let available_quantity: Int?
    let sold_quantity: Int?
    let sale_terms: [SaleTermResponse]?
    let picture_ids: [String]?
    let catalog_product_id: Int?
}
