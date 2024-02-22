//
//  NewPasswordView.swift
//  CryptOh?
//
//  Created by AJ Nettles on 2/17/24.
//

import SwiftUI

struct NewPasswordView: View {
    let characterNumber: Int = 12
    @Binding var password: String
    @Binding var page: Int
    
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading) {
                    Text("Let's Make A Better Password").font(.title).padding(.bottom, 10)
                    
                    Text("Your passwords should be different from one another on each site that you use.")
                        .padding(.bottom, 5)
                    
                    Text("If your password is compromised for one account, sharing the same password could threaten the safety for all of your other accounts.")
                        .padding(.bottom, 5)
                    
                    Text("We should create a new password that will stand up better against brute force login attempts, prioritizing length means a longer brute force time.")
                    
                    Spacer()
                    
                    
                }
                Spacer()
                VStack{
                    Spacer()
                    SecureField("Really Super Secure Password", text: $password)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // Adjust the corner radius as needed
                                .stroke(Color.gray, lineWidth: 1) // Add stroke to create a border
                        )
                        .padding(.horizontal)
                        .background(Color.clear)
                    
                    Text("Make a password that passes the following requirements:")
                    Text("\(characterNumber) characters or longer").foregroundStyle(password.count >= characterNumber ? Color.green : Color.red)
                    Text("At least 1 uppercase character").foregroundStyle(password.contains(#/[A-Z]/#) ? Color.green : Color.red)
                    Text("At least 1 number").foregroundStyle(password.contains(#/[0-9]/#) ? Color.green : Color.red)
                    Text("At least 1 special character").foregroundStyle(password.contains(#/[^A-Za-z0-9]/#) ? Color.green : Color.red)
                    
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
                    //                        Alert(title: Text(""))
                }.disabled((password.count < characterNumber) || !password.contains(#/[0-9]/#) || !password.contains(#/[A-Z]/#) || !password.contains(#/[^A-Za-z0-9]/#))
            }
        }.padding(.all, 20)
    }
}
//#Preview {
//    NewPasswordView()
//}
