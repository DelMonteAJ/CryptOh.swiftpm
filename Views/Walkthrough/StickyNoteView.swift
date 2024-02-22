//
//  StickyNoteView.swift
//  CryptOh?
//
//  Created by AJ Nettles on 2/19/24.
//

import SwiftUI

struct StickyNoteView: View {
    var body: some View {
        ZStack {
            Image(systemName: "desktopcomputer")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(Color.gray)
            Image(systemName: "note")
                .resizable()
                .aspectRatio(contentMode: .fit)
                
                .frame(width: 200.0)
                .foregroundStyle(Color.yellow)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.yellow/*@END_MENU_TOKEN@*/)
                .offset(x:200,y:200)
            
            Text("Username:\nswiftyChallenger\nPassword:\nP4SSW0RD!")
                .offset(x: 200, y: 175)
                .foregroundStyle(Color.black)
                .font(.custom("Cochin", size: 24))
                
        }
    }
}

#Preview {
    StickyNoteView()
}
