//
//  ScaleModalView.swift
//  Px ›› Em
//
//  Created by Karl Koch on 22/07/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct ScaleItem: Identifiable {
    var id = UUID()
    var scaleNumber: String
    var scaleName: String
}

struct ScaleModalView: View {
    @Environment(\.presentationMode) private var presentationMode
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        VStack {
            if device == .phone {
            Image(systemName: "chevron.compact.down").font(.system(size: 40, weight: .semibold)).padding(.top, 20).foregroundColor(Color.secondary)
            }
            else {
                HStack {
                    Spacer()
                    Button(action: {
                      self.presentationMode.wrappedValue.dismiss()
                    }) {
                    Text("Done").bold()
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("teal"))
                    }
                    .padding()
                }
            }
            ScalesView()
        Spacer()
        }
    }
}

struct ScalesView: View {
    let scaleItems: [ScaleItem] = [
        ScaleItem(scaleNumber: "1.000:", scaleName: "Browser default"),
        ScaleItem(scaleNumber: "1.067:", scaleName: "Minor second"),
        ScaleItem(scaleNumber: "1.125:", scaleName: "Major second"),
        ScaleItem(scaleNumber: "1.200:", scaleName: "Minor third"),
        ScaleItem(scaleNumber: "1.250:", scaleName: "Minor third"),
        ScaleItem(scaleNumber: "1.333:", scaleName: "Perfect fourth"),
        ScaleItem(scaleNumber: "1.414:", scaleName: "Augmented fourth"),
        ScaleItem(scaleNumber: "1.500:", scaleName: "Perfect fifth"),
        ScaleItem(scaleNumber: "1.618:", scaleName: "Golden ratio")
    ]
    
    var body: some View {
        VStack{
            HStack {
                List(scaleItems) { scaleItem in
                    Text(scaleItem.scaleNumber).font(.system(.body, design: .monospaced)).bold()
                    Text(scaleItem.scaleName).font(.system(.body, design: .default))
                  }.listStyle(InsetGroupedListStyle()).padding(.top, 8)
            }.navigationBarTitle(Text("Example scales"))
        }
    }
}

struct ScaleModalView_Previews: PreviewProvider {
    static var previews: some View {
        ScaleModalView()
    }
}
