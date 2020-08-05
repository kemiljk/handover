//
//  TopBar.swift
//  Px ›› Em
//
//  Created by Karl Koch on 05/08/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct TopBar : View {
    @Binding var selected : Int
    let switcher = UIImpactFeedbackGenerator(style: .medium)
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Button(action: {
                self.selected = 0
                self.switcher.impactOccurred()
            })
            {
            Text("Px").bold()
                .frame(width: 24, height: 16)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(self.selected == 0 ? Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0) : Color.clear)
                .clipShape(Capsule())
                .foregroundColor(self.selected == 0 ? Color.black : Color.primary)
            }
            
            Button(action: {
                self.selected = 1
                self.switcher.impactOccurred()
            })
            {
            Text("Em").bold()
            .frame(width: 24, height: 16)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(self.selected == 1 ? Color(red: 1.00, green: 0.60, blue: 0.00, opacity: 1.0) : Color.clear)
            .clipShape(Capsule())
            .foregroundColor(self.selected == 1 ? Color.black : Color.primary)
            }
            
        }.padding(4)
        .background(Color("grey"))
        .clipShape(Capsule())
    }
}