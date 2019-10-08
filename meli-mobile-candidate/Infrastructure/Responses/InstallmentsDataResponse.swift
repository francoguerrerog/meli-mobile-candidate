import Foundation

struct InstallmentsDataResponse: Codable {
    let quantity: Int?
    let amount: Double?
    let rate: Double?
    let currencyId: String?
    
    enum CodingKeys: String, CodingKey {
        case quantity = "quantity"
        case amount = "amount"
        case rate = "rate"
        case currencyId = "currency_id"
    }
}
