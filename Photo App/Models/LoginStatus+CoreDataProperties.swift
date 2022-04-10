import Foundation
import CoreData
extension LoginStatus {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginStatus> {
        return NSFetchRequest<LoginStatus>(entityName: "LoginStatus")
    }
    @NSManaged public var isLogin: Bool
}

extension LoginStatus : Identifiable {}
