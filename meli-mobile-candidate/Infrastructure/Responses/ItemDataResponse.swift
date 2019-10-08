import Foundation

struct ItemDataResponse: Codable {
    let id: String?
    let siteId: String?
    let title: String?
    let seller: SellerDataResponse?
    let price: Double?
    let currencyId: String?
    let availableQuantity: Int?
    let buyingMode: String?
    let listingTypeId: String?
    let stopTime: Date?
    let condition: String?
    let permalink: String?
    let thumbnail: String?
    let acceptsMercadopago: Bool?
    let installments: InstallmentsDataResponse?
    let address: AddressDataResponse?
    let shipping: ShippingDataResponse?
    let sellerAddress: SellerAddressDataResponse?
    let attributes: [AttributesDataResponse]?
    let originalPrice: Double?
    let categoryId: String?
    let officialStoreId: Int?
    let catalogProductId: String?
    let tags: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case siteId = "site_id"
        case title = "title"
        case seller = "seller"
        case price = "price"
        case currencyId = "currency_id"
        case availableQuantity = "available_quantity"
        case buyingMode = "buying_mode"
        case listingTypeId = "listing_type_id"
        case stopTime = "stop_time"
        case condition = "condition"
        case permalink = "permalink"
        case thumbnail = "thumbnail"
        case acceptsMercadopago = "accepts_mercadopago"
        case installments = "installments"
        case address = "address"
        case shipping = "shipping"
        case sellerAddress = "seller_address"
        case attributes = "attributes"
        case originalPrice = "original_price"
        case categoryId = "category_id"
        case officialStoreId = "official_store_id"
        case catalogProductId = "catalog_product_id"
        case tags = "tags"
    }
}
