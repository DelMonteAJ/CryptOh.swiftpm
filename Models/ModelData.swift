import Foundation


func decodeData() -> [Password] {
    if let decoded = try? JSONDecoder().decode(Passwords.self, from: decryptEncryptedData().data(using: .utf8)!) {
        return decoded.passwords.sorted()
    }
    // Should never reach
    return [Password(id: "Apple.com", account_name: "steve", password: "MrJobsiCEO"), Password(id: "AppleAgain.com", account_name: "timmy", password: "MrCookiCEO")]
}
func decodePreferences() -> CryptOhPreferences {
    
    if let data = UserDefaults.standard.data(forKey: "Preferences") {
        if let decoded = try? JSONDecoder().decode(CryptOhPreferences.self, from: data) {
            print("DEcoded: \(decoded)")
            return decoded
            
        }
        print("Data: \(data)")
    }

    return CryptOhPreferences(tutorialCompleted: false)
}

func encodePreferences(preferences: CryptOhPreferences){
    
    if let encoded = try? JSONEncoder().encode(preferences) {
        UserDefaults.standard.set(encoded, forKey: "Preferences")
        
    }
}

func encodeData(passwords: [Password]){
    if let encoded = try? JSONEncoder().encode(Passwords(passwords: passwords)) {
        

        UserDefaults.standard.set(encryptDecryptedData(information: String(data:encoded, encoding:.utf8)!), forKey: "SavedData")
        print(passwords.count)
    }
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
