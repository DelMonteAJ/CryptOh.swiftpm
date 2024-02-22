import SwiftUI

struct PasswordDatabaseView: View {
    @State private var additionMode: Bool = false
    @State private var searchText: String = ""
    @State var loadedPasswords: [Password] = decodeData()
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(searchResults, id: \.id) { password in
                    NavigationLink {
                        PasswordView(password: password, passwords: $loadedPasswords)
                    } label: {
                        PasswordRow(password: password)
                            .navigationTitle("Passwords")
                    }
                }.onDelete(perform: { indexSet in
                    loadedPasswords.remove(atOffsets: indexSet)
                    encodeData(passwords: loadedPasswords)
                })
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        additionMode = true
                        print("Add a new password")
                        var i = 1
                        if (loadedPasswords.filter { password in
                            password.id.localizedCaseInsensitiveContains("NewPassword.com")
                        }.count == 0) {
                            loadedPasswords.insert(Password(id: "NewPassword.com", account_name: "", password: ""), at: 0)
                            encodeData(passwords: loadedPasswords)
                            
                            return
                        }
                        
                        while (loadedPasswords.filter { password in
                            password.id.localizedCaseInsensitiveContains("NewPassword.com (\(i))")
                        }.count > 0){
                           i += 1
                        }
                        
                        loadedPasswords.insert(Password(id: "NewPassword.com (\(i))", account_name: "", password: ""), at: 0)
                        encodeData(passwords: loadedPasswords)

                    }label: {
                        Image(systemName: "plus")
                    }
                }
            }
        } detail: {
                Text("Select an account")
        }.navigationSplitViewStyle(.balanced).searchable(text: $searchText)
            
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
