import SwiftUI

struct PasswordView: View {
    let password: Password
//    @State var editingMode: Bool = true
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                PasswordDetailEntry(title: "Entry Name", detail: password.id)
                Divider()
                PasswordDetailEntry(title: "Account Name", detail: password.account_name, copyable: true)
                Divider()
                PasswordDetailEntry(title: "Password", detail: password.password, copyable: true, hidden: true, currentlyHidden: true)
            }.toolbar {
                ToolbarItem {
                    Button("Edit") {
                        print("Editing")
                    }
                }
            }.padding()
        }
    }
}

