import Foundation

class Password: Identifiable, Comparable, ObservableObject, Codable {
    static func == (lhs: Password, rhs: Password) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum CodableKeys: CodingKey {
        case id
        case account_name
        case password
    }
    

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodableKeys.self)
        id = try container.decode(String.self, forKey: .id)
        account_name = try container.decode(String.self, forKey: .account_name)
        password = try container.decode(String.self, forKey: .password)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodableKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(account_name, forKey: .account_name)
        try container.encode(password, forKey: .password)
    }
    
    @Published var id: String
    @Published var account_name: String
    @Published var password: String
    
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
