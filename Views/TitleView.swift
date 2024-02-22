//
//  TitleView.swift
//  CryptOh?
//
//  Created by AJ Nettles on 2/19/24.
//

import SwiftUI

struct TitleView: View {
    @Binding var page: Int
    var body: some View {
        VStack{
            Text("CryptOh?")
                .foregroundStyle(Color.green)
                .font(.custom("Courier", size: 36))
                .bold()
                .padding(.all, 5)
            Text("Your Guide to Better Password Security")
                .font(.custom("Courier", size: 18))
                .padding(.bottom, 25)
            Button("Begin Encryption"){
                page += 1
            }   .padding(.all)
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Adjust the corner radius as needed
                        .stroke(Color.gray, lineWidth: 1) // Add stroke to create a border
                    )
                
        }
    }
}

