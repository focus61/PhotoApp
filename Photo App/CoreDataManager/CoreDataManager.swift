import UIKit
import CoreData
class CoreDataManager {
    static let shared = CoreDataManager()
    init() {}
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Photo_App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createUser(user: String?) -> User? {
        guard let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: viewContext) as? User else {return nil}
        newUser.user = user
        newUser.isLoad = true
        newUser.avatar = UIImage(named: "Contact")?.jpegData(compressionQuality: 0)
        saveContext()
        return newUser
    }
    
    func users() -> [User]? {
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        if let users = try? viewContext.fetch(fetchRequest) {
            saveContext()
            return users
        }
        return []
    }
    
    func currentUser(userName: String?) -> User? {
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "user == %@", userName ?? "")
        if let users = try? viewContext.fetch(fetchRequest) {
            users.first?.isLoad = true
            return users.first
        }
        return nil
    }
    
    func signOut(object: User) {
        object.isLoad = false
        saveContext()
    }
    
    func updateAvatar(object: User, imageData: Data) {
        object.avatar = imageData
        saveContext()
    }
    
    func deleteUser(user: String) {
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "user == %@", user)
        if let users = try? viewContext.fetch(fetchRequest) {
            guard let deleteUser = users.first else {return}
            viewContext.delete(deleteUser)
            saveContext()
        }
    }
    
    func containsUser(text: String?) -> Bool {
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "user == %@", text ?? "")
        if let users = try? viewContext.fetch(fetchRequest), !users.isEmpty {
            return true
        }
        return false
    }
//Check isLogin
    func loginIsEmpty() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginStatus")
        if let login = try? viewContext.fetch(fetchRequest) as? [LoginStatus] {
            if login.isEmpty {
                let status = LoginStatus(context: viewContext)
                status.isLogin = false
                saveContext()
            }
        }
    }
    
    func loginUpdate(isLogin: Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginStatus")
        if let login = try? viewContext.fetch(fetchRequest) as? [LoginStatus] {
            if login.isEmpty {
                let status = LoginStatus(context: viewContext)
                status.isLogin = false
                saveContext()
            }
            guard let data = login.first else {return}
            data.isLogin = isLogin
            saveContext()
        }
    }
    
    func isLogin() -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginStatus")
        if let login = try? viewContext.fetch(fetchRequest) as? [LoginStatus], !login.isEmpty {
            guard let data = login.first else {return false}
            return data.isLogin
        }
        return false
    }
}
