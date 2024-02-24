import SwiftUI

struct HasherView: View {
    @Binding var input: String
    var time: Double
    @Binding var page: Int
    
    var body: some View {
        VStack {
            
            HStack {
                VStack(alignment: .center) {
                    HStack {
                        Text("Passwords Are Secret For A Reason")
                            .font(.title).padding(.bottom, 10)
                        Spacer()
                    }
                    
                    
                    HStack {
                        Text("Due to the insecure nature of our password, your device cracked it in \(time) seconds. Ignoring that terrifying detail, I added a visualizer to show what your password looks like on the company's side.")
                            .padding(.bottom, 5)
                        Spacer()
                    }
                    
                    HStack {
                        Text("In the rare occasion that the company has a data breach, the hash of your password will be revealed. Since hashes cannot transform back into your original password, you should be good right?")
                            .padding(.bottom, 5)
                        Spacer()
                    
                    }

                    HStack {
                        Text("I added a hash generator to the right so you can see what a password turns into, try changing your password a little and seeing if you see a pattern between hashes.")
                            .padding(.bottom, 5)
                        Spacer()
                    
                    }
                    Spacer()
                }

                Spacer()
                VStack {
                    Spacer()
                    Text("Hash Generator")
                        .foregroundStyle(Color.green)
                        .font(.custom("Courier", size: 36))

                    TextField("Try It Out!", text: $input)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // Adjust the corner radius as needed
                                .stroke(Color.gray, lineWidth: 1) // Add stroke to create a border
                        )
                        .padding(.horizontal)
                        .background(Color.clear)
                    
                    Image(systemName: "arrowshape.down")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:50)
                        .foregroundStyle(Color.green)
                    
                    
                    Text(cryptoblock(generateSHA256(input)))
                        .kerning(16)
                        .foregroundStyle(Color.green)
                        .font(.custom("Courier", size: 36))
                        .padding(.leading, 16.0)
                    Spacer()
                }
            }
            HStack {
                Button("Back"){
                    page -= 1
                }
                Spacer()
                Button("Next"){
                    page += 1
                }
            }
        }.padding(.all, 20)
    }
}

//#Preview {
//    Group {
//        @State var ins: String = ""
//        HasherView(input: $ins)
//    }
//}
