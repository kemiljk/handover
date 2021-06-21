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
    var scaleItem: String
}

struct ClassNameItem: Identifiable {
    var id = UUID()
    var className: String
    var classNameTitle: String
}

struct ScalesView: View {
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.presentationMode) private var presentationMode
    
    let scaleItems: [ScaleItem] = [
        ScaleItem(scaleNumber: "1.000", scaleItem: ": Browser default"),
        ScaleItem(scaleNumber: "1.067", scaleItem: ": Minor second"),
        ScaleItem(scaleNumber: "1.125", scaleItem: ": Major second"),
        ScaleItem(scaleNumber: "1.200", scaleItem: ": Minor third"),
        ScaleItem(scaleNumber: "1.250", scaleItem: ": Minor third"),
        ScaleItem(scaleNumber: "1.333", scaleItem: ": Perfect fourth"),
        ScaleItem(scaleNumber: "1.414", scaleItem: ": Augmented fourth"),
        ScaleItem(scaleNumber: "1.500", scaleItem: ": Perfect fifth"),
        ScaleItem(scaleNumber: "1.618", scaleItem: ": Golden ratio"),
    ]
    
    var body: some View {
        VStack{
            VStack {
                HStack {
                    List(scaleItems) { scaleItem in
                        Text(scaleItem.scaleNumber + scaleItem.scaleItem).font(.system(.body, design: .monospaced)).bold()
                    }
                    .listStyle(InsetGroupedListStyle())
                }
                .navigationBarTitle("Example scales")
            }
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct ScaleModalView_Previews: PreviewProvider {
    static var previews: some View {
        ScalesView()
    }
}
