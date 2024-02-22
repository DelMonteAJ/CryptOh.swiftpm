import Foundation
let passwords: [Password] = decodeData()


func decodeData() -> [Password] {
    if let fileURL = Bundle.main.url(forResource: "example", withExtension: "json") {
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(Passwords.self, from: jsonData)
            print(decodedData.passwords)
            return decodedData.passwords.sorted()
        } catch {
            print("Error decoding data: \(error.localizedDescription)")
        }
    } else {
        print("File not found")
    }
    return []
}

