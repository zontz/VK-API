import Foundation
import SwiftKeychainWrapper
// Класс-сервис-который выполняет бизнес-логику - управлять токеном 
final class Session{
    private init() {}
    
    static let shared = Session()
    
    let version: String = "5.131"

    
    var accessToken:String {
        get {
            return KeychainWrapper.standard.string(forKey: "accessToken") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "accessToken")
        }
    }
    
    var userid: Int {
        get {
            return UserDefaults.standard.integer(forKey: "userId")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userId")
        }
    }
    
    lazy var tokenDateFormatter : DateFormatter  = {
        let tokenDateFormatter = DateFormatter()
        tokenDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return tokenDateFormatter
    }()
    
    var expiresIn: String {
        get {
            return UserDefaults.standard.string(forKey: "expiresIn") ?? ""
        }
        set {
            let tokenDate = Date(timeIntervalSinceNow: Double(newValue) ?? 0)
            let tokenDateString = tokenDateFormatter.string(from: tokenDate)
            return UserDefaults.standard.set(tokenDateString, forKey: "expiresIn")
        }
    }
    
    
    var isTokenValid : Bool {
        let expiresDateString = UserDefaults.standard.string(forKey: "expiresIn") ?? ""
        guard let tokenDate = tokenDateFormatter.date(from: expiresDateString) else {return false}
        let currentDate = Date()
        print(tokenDate)
        print(currentDate)
        return currentDate < tokenDate && !accessToken.isEmpty
    }
    
    
}
