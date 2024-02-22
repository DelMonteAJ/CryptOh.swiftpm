//
//  HashQuestionView.swift
//  CryptOh?
//
//  Created by AJ Nettles on 2/17/24.
//

import SwiftUI

struct HashQuestionView: View {
    @Binding var page: Int
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading){
                    Text("How Safe Are Hashes?")
                        .font(.title).padding(.bottom, 10)
                    
                    Text("Hashes are only safe if the passwords used to create them are not compromised.").fixedSize(horizontal: false, vertical:true).padding(.bottom, 5)
                    
                    Text("If someone knows that 'password' is equal to a specific hash, then it is possible to deduce that any user connected to that hash has 'password' as their password.").padding(.bottom, 5)
                    
                    Text("Companies do not want to be responsible for holding such private data and will store the hash of your password instead. Whenever you attempt to login, the servers will hash your potential password and see if it matches what is stored. If it matches, you will be logged in.")
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
