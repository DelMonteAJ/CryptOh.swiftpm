import SwiftUI

struct CompletedTutorialView: View {
    @Binding var page: Int
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading){
                    Text("Tutorial Complete")
                        .font(.title).padding(.bottom, 10)
                    
                    Text("You have completed my guide to better password security!").fixedSize(horizontal: false, vertical:true).padding(.bottom, 5)
                    
                    Text("Take this trophy as a token of my appreciation for your time and dedication to enhance your security.").padding(.bottom, 5)
                    
                    Text("This guide is merely a stepping stone. On the next page, CryptOh will become a password manager. I hope this guide may inspire you to learn more and stay secure.")
                    
                    Spacer()
                }
                Spacer()
                VStack {
                    Image(systemName: "trophy.fill").resizable().aspectRatio(contentMode: .fit).padding(.all)
                }
            }
            Spacer()
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
