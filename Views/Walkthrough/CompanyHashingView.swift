import SwiftUI

struct CompanyHashingView: View {
    @Binding var page: Int
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading){
                    Text("What Do Companies Do With Your Password?")
                        .font(.title).padding(.bottom, 10)
                    
                    Text("Oddly, the company does not actually need your password, they just need to confirm that it matches what they have in their system. This may sound confusing at first, but there is a way to represent your password without needing the password. This is called a **hash**.").fixedSize(horizontal: false, vertical:true).padding(.bottom, 5)
                    
                    Text("Similar to fingerprints, anyone can look at your hand and discover your fingerprints. However, no one is able to look at your fingerprints and know that it is yours without prior knowledge.").padding(.bottom, 5)
                    
                    Text("Companies do not want to be responsible for holding such private data and will store the hash of your password instead. Whenever you attempt to login, the servers will hash your password and see if it matches what is stored. If it matches, you will be logged in.")
                    Spacer()
                }
                Spacer()
                VStack {
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable().aspectRatio(contentMode: .fit).padding(.all)
                        Image(systemName: "arrowshape.right")
                            .resizable().aspectRatio(contentMode: .fit).padding(.all)
                        Image(systemName: "hand.raised.fill")
                            .resizable().aspectRatio(contentMode: .fit).padding(.all)
                    }
                    
                    HStack {
                        Image(systemName: "hand.raised.fill")
                            .resizable().aspectRatio(contentMode: .fit).padding(.all)
                        ZStack{
                            Image(systemName: "arrowshape.right")
                                .resizable().aspectRatio(contentMode: .fit).padding(.all)
                            Image(systemName: "xmark")
                                .resizable().aspectRatio(contentMode: .fit).padding(.all)
                        }
                        Image(systemName: "person.fill")
                            .resizable().aspectRatio(contentMode: .fit).padding(.all)
                    }
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
//
//#Preview {
//    CompanyHashingView()
//}
