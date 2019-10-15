import Foundation
import RxSwift
@testable import meli_mobile_candidate

class GetItemFullDetailsSpy: GetItemFullDetails {
    var hasExecuted = false
    func execute(itemId: String) -> Single<ItemDetailResponse> {
        return Single.just(ItemDetailResponse(id: "1234", site_id: nil, title: nil, subtitle: nil, seller_id: nil, category_id: nil, official_store_id: nil, price: nil, base_price: nil, original_price: nil, currency_id: nil, initial_quantity: nil, available_quantity: nil, sold_quantity: nil, sale_terms: nil, buying_mode: nil, listing_type_id: nil, start_time: nil, stop_time: nil, condition: nil, permalink: nil, thumbnail: nil, secure_thumbnail: nil, pictures: nil, video_id: nil, descriptions: nil, accepts_mercadopago: nil, non_mercado_pago_payment_methods: nil, shipping: nil, international_delivery_mode: nil, seller_address: nil, seller_contact: nil, location: nil, geolocation: nil, coverage_areas: nil, attributes: nil, warnings: nil, listing_source: nil, variations: nil, status: nil, sub_status: nil, tags: nil, warranty: nil, catalog_product_id: nil, domain_id: nil, parent_item_id: nil, differential_pricing: nil, deal_ids: nil, automatic_relist: nil, date_created: nil, last_updated: nil, health: nil, catalog_listing: nil))
    }
}
