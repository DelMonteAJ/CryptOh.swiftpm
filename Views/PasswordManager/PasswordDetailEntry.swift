import SwiftUI

struct PasswordDetailEntry: View {
    let title: String
    var detail: String
    var copyable: Bool = false
    var hidden: Bool = false
    @State var currentlyHidden: Bool = false
    var body: some View {
        if (!detail.isEmpty){
            VStack {
                HStack {
                    Text(title)
                        .font(.headline)
                    Spacer()
                }
                HStack{
                    if (currentlyHidden){
                        Text("************")
                    }else{
                        Text(detail)
                    }
                    Spacer()
                    if (hidden){
                        Button {
                            currentlyHidden.toggle()
                        } label: {
                            Image(systemName: currentlyHidden ? "eye" : "eye.slash")
                        }
                    }
                    if (copyable){
                        Button {
                            print("Copy me to the clipboard")
                            UIPasteboard.general.string = detail
                        } label: {
                            Image(systemName: "doc.on.doc")
                        }
                    }
                    
                }
                Spacer()
            }

        }
        else{
            EmptyView()
        }

    }
}

#Preview {
    PasswordDetailEntry(title: "User", detail: "steve@apple.com")
}
