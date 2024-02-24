import SwiftUI

struct TitleView: View {
    @Binding var page: Int
    @Binding var preferences: CryptOhPreferences
    @State private var showManager: Bool = false
    var body: some View {
        if (!showManager){
            VStack{
                Text("CryptOh?")
                    .foregroundStyle(Color.green)
                    .font(.custom("Courier", size: 36))
                    .bold()
                    .padding(.all, 5)
                Text("Your Guide to Better Password Security")
                    .font(.custom("Courier", size: 18))
                    .padding(.bottom, 25)
                if (!preferences.tutorialCompleted){
                    Button("Begin Decryption Tutorial"){
                        page = 1
                    }   .padding(.all)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // Adjust the corner radius as needed
                                .stroke(Color.gray, lineWidth: 1) // Add stroke to create a border
                        )
                    Button("Skip Tutorial"){
                        showManager = true
                        preferences.tutorialCompleted = true
                        encodePreferences(preferences: preferences)
                    }   .padding(.all)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // Adjust the corner radius as needed
                                .stroke(Color.gray, lineWidth: 1) // Add stroke to create a border
                        )
                }else {
                    Button("Begin Password Decryption"){
                        showManager = true
                    }   .padding(.all)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // Adjust the corner radius as needed
                                .stroke(Color.gray, lineWidth: 1) // Add stroke to create a border
                        )
                    Button("Replay Tutorial"){
                        page = 1
                    }   .padding(.all)
                    
                }
                
            }
            
        }else {
          PasswordDatabaseView()
        }

    }
}

