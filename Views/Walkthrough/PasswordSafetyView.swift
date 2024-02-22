//
//  PasswordSafetyView.swift
//  CryptOh?
//
//  Created by AJ Nettles on 2/19/24.
//

import SwiftUI

struct PasswordSafetyView: View {
    @Binding var page: Int
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading){
                    Text("Keep Your Password Safe By All Means")
                        .font(.title).padding(.bottom, 10)
                    
                    Text("A secure password does not matter if you freely give it away.").fixedSize(horizontal: false, vertical:true).padding(.bottom, 5)
                    
                    Text("Please do not leave a publicly available note with your login credentials on it. If you must keep a copy of your credentials, use a password manager.").padding(.bottom, 5)
                    
                    Text("Password managers keep all of your passwords in one place, secure behind a master password. All you need is to remember that one password and you will be good to go!")
                    Spacer()
                }
                Spacer()
                VStack {
                    StickyNoteView()
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
