import Foundation

protocol SearchConfigurationsRepository {
    func find() -> SearchConfigurations?
    func put(_ searchConfigurations: SearchConfigurations)
}
