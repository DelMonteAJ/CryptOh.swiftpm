import Foundation



//func decodeData() -> [Password] {
//    if let fileURL = Bundle.main.url(forResource: "example", withExtension: "json") {
//        do {
//            let jsonData = try Data(contentsOf: fileURL)
//            let decoder = JSONDecoder()
//            let decodedData = try decoder.decode(Passwords.self, from: jsonData)
//            print(decodedData.passwords)
//            return decodedData.passwords.sorted()
//        } catch {
//            print("Error decoding data: \(error.localizedDescription)")
//        }
//    } else {
//        print("File not found")
//    }
//    return []
//}

func decodeData() -> [Password] {
    if let data = UserDefaults.standard.data(forKey: "SavedData") {
        if let decoded = try? JSONDecoder().decode(Passwords.self, from: data) {
            return decoded.passwords.sorted()
        }
    }
    return [Password(id: "Apple.com", account_name: "steve", password: "MrJobsiCEO"), Password(id: "AppleAgain.com", account_name: "timmy", password: "MrCookiCEO")]
}

//func encodeData() -> Bool {
//    var saveSuccessful = false
//    if let encoded = try? JSONEncoder().encode(Passwords(passwords: passwords)) {
//        UserDefaults.standard.set(encoded, forKey: "SavedData")
//        print(passwords.count)
//        saveSuccessful = true
//    }
//    return saveSuccessful
//    
//}

func encodeData(passwords: [Password]) -> Bool {
    var saveSuccessful = false
    if let encoded = try? JSONEncoder().encode(Passwords(passwords: passwords)) {
        UserDefaults.standard.set(encoded, forKey: "SavedData")
        print(passwords.count)
        saveSuccessful = true
    }
    return saveSuccessful
    
}

