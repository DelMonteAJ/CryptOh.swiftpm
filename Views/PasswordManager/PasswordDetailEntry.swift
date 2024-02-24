import SwiftUI

struct PasswordDetailEntry: View {
    let title: String
    @Binding var detail: String
    @Binding var editMode: Bool
    var copyable: Bool = false
    var hidden: Bool = false
    @State var currentlyHidden: Bool = false
    @State var recentlyCopied: Bool = false
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
            }
            HStack{
                if (currentlyHidden){
                    Text("************")
                        .onTapGesture {
                            currentlyHidden.toggle()
                        }
                        .padding(.top, 5.0)
                }else{
                    TextField(title, text: $detail).disabled(!editMode).autocorrectionDisabled(true)
                    
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
                        recentlyCopied = true
                        DispatchQueue.global().async {
                            sleep(3)
                            recentlyCopied = false
                        }
                    } label: {
                        Image(systemName: recentlyCopied ? "checkmark.circle.fill" : "doc.on.doc")
                    }.padding(.horizontal)
                }
                
            }
            Spacer()
        }

    }
    
}

//#Preview {
//    PasswordDetailEntry(title: "User", detail: "steve@apple.com")
//}
