import Foundation

struct Password: Codable, Identifiable, Comparable {

    let id: String
    let account_name: String
    let password: String
    
    init(id: String, account_name: String, password: String) {
        self.id = id
        self.account_name = account_name
        self.password = password
        
    }    
    
    static func < (lhs: Password, rhs: Password) -> Bool {
        return lhs.id < rhs.id
    }
}

struct Passwords: Codable {
    let passwords: [Password]
}
