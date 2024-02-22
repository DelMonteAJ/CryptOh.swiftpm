import SwiftUI

struct PasswordView: View {
    @ObservedObject var password: Password
    @State var editingMode: Bool = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                PasswordDetailEntry(title: "Entry Name", detail: $password.id, editMode: $editingMode)
                Divider()
                PasswordDetailEntry(title: "Account Name", detail: $password.account_name, editMode: $editingMode, copyable: true)
                Divider()
                PasswordDetailEntry(title: "Password", detail: $password.password, editMode: $editingMode, copyable: true, hidden: true, currentlyHidden: true)
            }.toolbar {
                ToolbarItem {
                    if (!editingMode){
                        Button("Edit") {
                            editingMode = true
                            print("Editing")
                        }
                    }else{
                        Button("Done") {
                            editingMode = false
                            print("Save \(encodeData() ? "successful" : "failed")")
                            print("Done editing")
                        }
                    }
                }
            }.padding()
        }
    }
}

