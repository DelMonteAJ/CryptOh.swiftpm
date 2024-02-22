import SwiftUI

struct PasswordDatabaseView: View {
    @State private var additionMode: Bool = false
    @State private var searchText: String = ""
    var body: some View {
        NavigationSplitView {
            List (searchResults, id: \.id){ password in
                NavigationLink {
                    PasswordView(password: password)
                    
                } label: {
                    PasswordRow(password: password)
                        .navigationTitle("Passwords")
                    
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        additionMode = true
                        print("Add a new password")
                        var i = 1
                        if (passwords.filter { password in
                            password.id.localizedCaseInsensitiveContains("NewPassword.com")
                        }.count == 0) {
                            passwords.insert(Password(id: "NewPassword.com", account_name: "", password: ""), at: 0)
                            return
                        }
                        
                        while (passwords.filter { password in
                            password.id.localizedCaseInsensitiveContains("NewPassword.com (\(i))")
                        }.count > 0){
                           i += 1
                        }
                        
                        passwords.insert(Password(id: "NewPassword.com (\(i))", account_name: "", password: ""), at: 0)

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
            return passwords
        }else {
            return passwords.filter { password in
                password.id.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
    PasswordDatabaseView()
}
