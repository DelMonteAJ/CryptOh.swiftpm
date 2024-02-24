import SwiftUI

struct PasswordView: View {
    @ObservedObject var password: Password
    @Binding var passwords: [Password]
    @State var editingMode: Bool = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                PasswordDetailEntry(title: "Entry Name", detail: $password.id, editMode: $editingMode)
                Divider()
                PasswordDetailEntry(title: "Account Name", detail: $password.account_name, editMode: $editingMode, copyable: true)
                Divider()
                PasswordDetailEntry(title: "Password", detail: $password.password, editMode: $editingMode, copyable: true, hidden: true, allowGeneration: true, currentlyHidden: true)
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
                            var i = 1
                            DispatchQueue.global().async{
                                while (passwords.filter { password in
                                    password.id.localizedCaseInsensitiveContains("\($password.id) (\(i))")
                                }.count > 0){
                                    i += 1
                                }
                            }
                            password.id = "\(password.id) (\(i))"
                            passwords = passwords.sorted()
                            print("Done editing")
                            
                        }
                    }
                }
            }.padding()
        }
    }
}

