import SwiftUI

struct PasswordDetailEntry: View {
    let title: String
    @Binding var detail: String
    @Binding var editMode: Bool
    var copyable: Bool = false
    var hidden: Bool = false
    var allowGeneration: Bool = false
    @State var currentlyHidden: Bool = false
    @State var recentlyCopied: Bool = false
    
    //Generator variables
    @State private var presentGenerationModal: Bool = false
    @State private var generatorItem: String = ""
    @State private var generatorLength: Float = 16.0
    @State private var generatorLowercase: Bool = true
    @State private var generatorUppercase: Bool = true
    @State private var generatorNumbers: Bool = true
    @State private var generatorSymbols: Bool = true
    
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
                if (allowGeneration){
                    Button {
                        presentGenerationModal = true
                        generatorItem = ""
                    } label : {
                        Image(systemName: "gearshape.arrow.triangle.2.circlepath")
                    }.padding(.horizontal,5)
                }
                if (hidden){
                    Button {
                        currentlyHidden.toggle()
                    } label: {
                        Image(systemName: currentlyHidden ? "eye" : "eye.slash")
                    }.padding(.horizontal,5)
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
                    }.padding(.horizontal,5)
                }
                
            }
            Spacer()
        }.sheet(isPresented: $presentGenerationModal, content: {
            VStack (alignment: .center){
                HStack{
                    Button("Cancel"){
                        print("No new password")
                        presentGenerationModal = false
                    }.padding(.horizontal)
                    Spacer()
                    Button("Update") {
                        print("Updating password")
                        presentGenerationModal = false
                        detail = generatorItem
                    }.padding(.horizontal)
                }
                Spacer()
                Text("\(title) Generation")
                TextField("New \(title)", text: $generatorItem)
                HStack {
                    Text("Length: \(Int(generatorLength))")
                    Spacer()
                    Slider(
                        value: $generatorLength,
                        in: 1...50,
                        step: 1
                    )
                }
                Toggle("a-z", isOn: $generatorLowercase).disabled(true)
                Toggle("A-Z", isOn: $generatorUppercase)
                Toggle("0-9", isOn: $generatorNumbers)
                Toggle("!@#$%^&*", isOn: $generatorSymbols)

                Button("Regenerate"){
                    generatorItem = String.randomString(length: Int(generatorLength), allowUppercase: generatorUppercase, allowNumbers: generatorNumbers, allowSymbols: generatorSymbols)
                    
                }.padding(.all, 10).overlay(
                    RoundedRectangle(cornerRadius: 10) // Adjust the corner radius as needed
                        .stroke(Color.green, lineWidth: 1) // Add stroke to create a border
                )
                Spacer()
                Spacer()
            }.padding(.all)
        })

    }
    
}

//#Preview {
//    PasswordDetailEntry(title: "User", detail: "steve@apple.com")
//}
