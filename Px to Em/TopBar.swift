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
                .frame(width: 30, height: 16)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(self.selected == 0 ? Color("teal") : Color.clear)
                .clipShape(Capsule())
                .foregroundColor(self.selected == 0 ? Color.white : Color.primary)
            }
            
            Button(action: {
                self.selected = 1
                self.switcher.impactOccurred()
            })
            {
            Text("Em").bold()
            .frame(width: 30, height: 16)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(self.selected == 1 ? Color("orange") : Color.clear)
            .clipShape(Capsule())
            .foregroundColor(self.selected == 1 ? Color.white : Color.primary)
            }
            
        }.padding(4)
        .background(Color("grey"))
        .clipShape(Capsule())
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
