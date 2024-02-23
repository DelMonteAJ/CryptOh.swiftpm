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
    if let decoded = try? JSONDecoder().decode(Passwords.self, from: decryptEncryptedData().data(using: .utf8)!) {
        return decoded.passwords.sorted()
    }
    // Should never reach
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
        
        print(String(data: encoded, encoding: .utf8)!)
        UserDefaults.standard.set(encryptDecryptedData(information: String(data:encoded, encoding:.utf8)!), forKey: "SavedData")
        print(passwords.count)
        saveSuccessful = true
    }
    return saveSuccessful
    
}

func decryptEncryptedData() -> String{
    let privateKey = loadPrivateKey()
    var error: Unmanaged<CFError>?
    
    
    // Decrypting the provided data using the private key.
    let algorithm: SecKeyAlgorithm = .eciesEncryptionCofactorX963SHA256AESGCM
    
    guard SecKeyIsAlgorithmSupported(privateKey, .decrypt, algorithm) else {
        return "{\"passwords\":[{\"password\":\"MrJobsiCEO\",\"id\":\"Apple.com\",\"account_name\":\"steve\"}]}"
    }

    if let data = UserDefaults.standard.data(forKey: "SavedData") {
        return String(data: SecKeyCreateDecryptedData(privateKey, algorithm, data as CFData, &error)! as Data, encoding: .utf8)!
    }
    return "{\"passwords\":[{\"password\":\"MrJobsiCEO\",\"id\":\"Apple.com\",\"account_name\":\"steve\"}]}"
}

func encryptDecryptedData(information: String) -> Data{

    
    // Encrypting the provided data using the public key of our private key.
    let privateKey = loadPrivateKey()
    var error: Unmanaged<CFError>?
    
    let algorithm: SecKeyAlgorithm = .eciesEncryptionCofactorX963SHA256AESGCM
    
    let pubKey = SecKeyCopyPublicKey(privateKey)!
    let gibberish = SecKeyCreateEncryptedData(pubKey, algorithm, information.data(using: .utf8)! as CFData, &error) as Data?
    print("GIB \(gibberish!)")
    return gibberish!

}

func loadPrivateKey() -> SecKey{
    let tag = "com.ajnettles.cryptoh.manager"
    let access = SecAccessControlCreateWithFlags(
        kCFAllocatorDefault,
        kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
        .privateKeyUsage,
        nil)! // Ignore errors.


    let attributes: NSDictionary = [
        kSecAttrKeyType: kSecAttrKeyTypeECSECPrimeRandom,
        kSecAttrKeySizeInBits: 256,
        kSecAttrTokenID: kSecAttrTokenIDSecureEnclave,
        kSecPrivateKeyAttrs: [
            kSecAttrIsPermanent: true,
            kSecAttrApplicationTag: tag,
            kSecAttrAccessControl: access
        ]
    ]

    var error: Unmanaged<CFError>?

    let query: [String: Any] = [
        kSecClass as String: kSecClassKey,
        kSecAttrKeyType as String: kSecAttrKeyTypeECSECPrimeRandom,
        kSecAttrApplicationTag as String: tag,
        kSecReturnRef as String: true
    ]
    
    // Attempt to retrieve the private key reference from the Secure Enclave
    var privateKey: SecKey
    var privateKeyRef: CFTypeRef?
    let status = SecItemCopyMatching(query as CFDictionary, &privateKeyRef)
    
    if (status != errSecSuccess) {
        print("There is nothing here.")
        privateKey = SecKeyCreateRandomKey(attributes, &error)!
    }else{
        privateKey = (privateKeyRef as! SecKey)
    }
    return privateKey
}
