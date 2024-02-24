import Foundation
import CryptoKit
func generateSHA256(_ input: String) -> String {
    String(CryptoKit.SHA256.hash(data: (input.data(using: .utf8) ?? "".data(using: .utf8))!).description.dropFirst(15))
}
func cryptoblock(_ input: String) -> String {
    input.components(withMaxLength: 8).joined(separator: "\n")
}


func generateBadPasswords(for targetPassword: String) -> String? {
    let alphabet = "abcdefghijklmnopqrstuvwxyz"
    let passwordLength = targetPassword.count
    
    // Recursive function to generate passwords
    func generate(_ prefix: String, passwordLength: Int) -> String? {
        if prefix.count == passwordLength {
            // Check if the generated password matches the target password
            if prefix == targetPassword {
                return prefix
            }
            return nil
        }
        
        for char in alphabet {
            if let result = generate(prefix + String(char), passwordLength: passwordLength) {
                return result
            }
        }
        
        return nil
    }
    
    // Start with single-character passwords and increment
    for length in 1...passwordLength {
        if let password = generate("", passwordLength: length) {
            return password
        }
    }
    
    return nil
}

extension String {
//https://stackoverflow.com/a/57289245 ~ Wujo
    func components(withMaxLength length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }
    static func randomString(length: Int, allowUppercase: Bool = true, allowNumbers: Bool = true, allowSymbols: Bool = true) -> String {
        var allowedChars = "abcdefghijklmnopqrstuvwxyz"

        if (allowUppercase){
            allowedChars += "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        }
        if (allowNumbers) {
            allowedChars += "0123456789"
        }
        if (allowSymbols) {
            allowedChars += "!@#$%^&*"
        }
        
        let allowedCharsCount = allowedChars.count
        var randomString = ""

        for _ in 0 ..< length {
            let newCharacter = allowedChars.randomElement()!
            randomString += String(newCharacter)
        }

        return randomString
    }
}


