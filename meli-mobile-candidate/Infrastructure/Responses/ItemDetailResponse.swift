import Foundation

struct ItemDetailResponse: Codable {
    let id: String
    let site_id: String?
    let title: String?
    let subtitle: String?
    let seller_id: Int?
    let category_id: String?
    let official_store_id: String?
    let price: Double?
    let base_price: Double?
    let original_price: Double?
    let currency_id: String?
    let initial_quantity: Int?
    let available_quantity: Int?
    let sold_quantity: Int?
    let sale_terms: [SaleTermResponse]?
    let buying_mode: String?
    let listing_type_id: String?
    let start_time: Date?
    let stop_time: Date?
    let condition: String?
    let permalink: String?
    let thumbnail: String?
    let secure_thumbnail: String?
    let pictures: [PictureReponse]?
    let video_id: String?
    let descriptions: [DescriptionResponse]?
    let accepts_mercadopago: Bool?
    let non_mercado_pago_payment_methods: [String]?
    let shipping: ShippingDataResponse?
    let international_delivery_mode: String?
    let seller_address: SellerAddressResponse?
    let seller_contact: SellerDataResponse?
    let location: LocationResponse?
    let geolocation: GeoLocationResponse?
    let coverage_areas: [String]?
    let attributes: [AttributesDataResponse]?
    let warnings: [String]?
    let listing_source: String?
    let variations: [VariationReponse]?
    let status: String?
    let sub_status: [String]?
    let tags: [String]?
    let warranty: String?
    let catalog_product_id: String?
    let domain_id: String?
    let parent_item_id: String?
    let differential_pricing: String?
    let deal_ids: [String]?
    let automatic_relist: Bool?
    let date_created: Date?
    let last_updated: Date?
    let health: Double?
    let catalog_listing: Bool?
}

