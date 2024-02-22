//
//  Functions.swift
//  CryptOh?
//
//  Created by AJ Nettles on 2/9/24.
//

import Foundation
import CryptoKit
func generateSHA256(_ input: String) -> String {
    String(CryptoKit.SHA256.hash(data: (input.data(using: .utf8) ?? "".data(using: .utf8))!).description.dropFirst(15))
}
func cryptoblock(_ input: String) -> String {
    input.components(withMaxLength: 8).joined(separator: "\n")
}

//func generatePasswords(for targetPassword: String) -> String {
//    let alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
//    let passwordLength = targetPassword.count
//    
//    var currentPassword = ""
//    
//    // Iterate until a match is found
//    while true {
//        // Iterate over each character in the alphabet
//        for char in alphabet {
//            // Check if adding the current character creates a match
//            if currentPassword + String(char) == targetPassword {
//                return currentPassword + String(char)
//            }
//        }
//        
//        // Try adding each character from the alphabet
//        for char in alphabet {
//            let attempt = currentPassword + String(char)
//            // Check if the attempt matches the beginning of the target password
//            if targetPassword.hasPrefix(attempt) {
//                currentPassword = attempt
//                break
//            }
//        }
//    }
//}

func generatePasswords(for targetPassword: String) -> String? {
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

//let passwords = 

extension String {
//https://stackoverflow.com/a/57289245 ~ Wujo
    func components(withMaxLength length: Int) -> [String] {
        return stride(from: 0, to: self.count, by: length).map {
            let start = self.index(self.startIndex, offsetBy: $0)
            let end = self.index(start, offsetBy: length, limitedBy: self.endIndex) ?? self.endIndex
            return String(self[start..<end])
        }
    }
}
