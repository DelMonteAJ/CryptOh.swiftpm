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
                        print("Add a new password")
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
