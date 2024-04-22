import SwiftUI
import LocalAuthentication

struct PasswordDatabaseView: View {
    //https://www.hackingwithswift.com/books/ios-swiftui/using-touch-id-and-face-id-with-swiftui
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "Your password is being used to decrypt your CryptOh passwords."

            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    loggedIn = true
                    loadedPasswords = decodeData()
                    // authenticated successfully
                }
            
            }
        } else {
            loggedIn = true
            loadedPasswords = decodeData()
        }
    }
    @Binding var managerShowing: Bool
    @State private var loggedIn = false
    @State private var additionMode: Bool = false
    @State private var searchText: String = ""
    @State var loadedPasswords: [Password] = []
    var body: some View {
        Group {
            if (loggedIn){
                NavigationSplitView {
                    List {
                        ForEach(searchResults, id: \.id) { password in
                            NavigationLink {
                                PasswordView(password: password, passwords: $loadedPasswords)
                            } label: {
                                PasswordRow(password: password)
                                    
                            }.deleteDisabled(loadedPasswords.count < 2)
                        }.onDelete(perform: { indexSet in
                            DispatchQueue.global().async {
                                loadedPasswords.remove(atOffsets: indexSet)
                                encodeData(passwords: loadedPasswords)
                            }
                        })
                    }.navigationTitle("Passwords")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                additionMode = true
                                print("Add a new password")
                                var i = 1
                                if (loadedPasswords.filter { password in
                                    password.id.localizedCaseInsensitiveContains("NewPassword.com")
                                }.count == 0) {
                                    DispatchQueue.global().async {
                                        loadedPasswords.insert(Password(id: "NewPassword.com", account_name: "", password: ""), at: 0)
                                        encodeData(passwords: loadedPasswords)
                                        return
                                    }
                                    
                                }else {
                                    DispatchQueue.global().async {
                                        while (loadedPasswords.filter { password in
                                            password.id.localizedCaseInsensitiveContains("NewPassword.com (\(i))")
                                        }.count > 0){
                                            i += 1
                                        }
                                        
                                        loadedPasswords.insert(Password(id: "NewPassword.com (\(i))", account_name: "", password: ""), at: 0)
                                            encodeData(passwords: loadedPasswords)
                                    }
                                }

                                
                                
                            }label: {
                                Image(systemName: "plus")
                            }
                        }
                        ToolbarItem(placement: .bottomBar) {
                            Button("Logout"){
                                print("Log out")
                                DispatchQueue.global().async {
                                    encodeData(passwords: loadedPasswords)
                                    loadedPasswords = []
                                    loggedIn = false
                                }
                            }
                        }
                    }
                } detail: {
                    Text("Select an account")
                }.navigationSplitViewStyle(.balanced).searchable(text: $searchText)
            }else {
                Spacer()
                Image("CryptOh_LargeTransparent").resizable().aspectRatio(contentMode: .fit).frame(width: 200)
                Text("CryptOh?")
                    .foregroundStyle(Color.green)
                    .font(.custom("Courier", size: 36))
                    .bold()
                    .padding(.all, 5)
                Text("Password Manager")
                    .foregroundStyle(Color.green)
                    .font(.custom("Courier", size: 36))
                    .bold()
                    .padding(.all, 5)
                Spacer()
                Button("Login"){
                    authenticate()
                }.padding(.all, 10).overlay(
                    RoundedRectangle(cornerRadius: 10) // Adjust the corner radius as needed
                        .stroke(Color.green, lineWidth: 1) // Add stroke to create a border
                )
                Button("Return to Main Menu"){
                    managerShowing = false
                }
                .padding(.all)
                Spacer()
            }
        }
    }
    
    var searchResults: [Password] {
        if searchText.isEmpty {
            return loadedPasswords
        }else {
            return loadedPasswords.filter { password in
                password.id.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

//#Ps
