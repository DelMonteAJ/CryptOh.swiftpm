import SwiftUI

struct BadPasswordView: View {
    let characterNumber: Int = 5
    @Binding var password: String
    @Binding var time: Double
    @Binding var page: Int
   
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading) {
                    Text("Why Do We Need A Longer Password?").font(.title).padding(.bottom, 10)
                    
                    Text("To do most things on the internet, we are required to create an account with a password that needs at least \(characterNumber) characters, an uppercase letter, a number, a special character and blah blah blah.")
                        .padding(.bottom, 5)
                    Text("But why? What would go wrong if we picked a password against their advice? I promise I won't peek.")
                        .padding(.bottom, 5)
                    
                    Spacer()
                    
                    
                }
                Spacer()
                VStack{
                    Spacer()
                    SecureField("Super Secure Password", text: $password)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // Adjust the corner radius as needed
                                .stroke(Color.gray, lineWidth: 1) // Add stroke to create a border
                        )
                        .padding(.horizontal)
                        .background(Color.clear)
                    
                    Text("Make a password that passes the following requirements:")
                    Text("\(characterNumber) characters or shorter").foregroundStyle(password.count <= characterNumber ? Color.green : Color.red)
                    Text("No uppercase characters").foregroundStyle(!password.contains(#/[A-Z]/#) ? Color.green : Color.red)
                    Text("No numbers").foregroundStyle(!password.contains(#/[0-9]/#) ? Color.green : Color.red)
                    Text("No special characters").foregroundStyle(!password.contains(#/[^A-Za-z0-9]/#) ? Color.green : Color.red)
                    
                    Spacer()
                    
                }
            }
            HStack {
                Button("Back"){
                    page -= 1
                }
                Spacer()
                Button("Next"){
                    print("Test")
                    

                    DispatchQueue.global().async {
                        let startTime = DispatchTime.now()
                        let generatedPassword = generateBadPasswords(for: password.lowercased())
                        let endTime = DispatchTime.now()
                        
                        let nanoTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
                        let timeInterval = Double(nanoTime) / 1_000_000_000
                        
                        print("Generated password: \(generatedPassword ?? "No clue")")
                        print("Time taken: \(timeInterval) seconds")
                        time = timeInterval
                    }

                    page += 1
                    //                        Alert(title: Text(""))
                }.disabled(!(password.count <= characterNumber) || password.contains(#/[0-9]/#) || password.contains(#/[A-Z]/#) || password.contains(#/[^A-Za-z0-9]/#) || password.count < 1)
            }
        }.padding(.all, 20)
    }
}

//#Preview {
//    PasswordView()
//}
