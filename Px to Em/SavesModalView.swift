//
//  SavesModalView.swift
//  Px ›› Em
//
//  Created by Karl Koch on 05/08/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

//
//  ScaleModalView.swift
//  Px ›› Em
//
//  Created by Karl Koch on 22/07/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct SavesModalView: View {
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
                    Text("Done")
                        .foregroundColor(Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0))
                    }
                    .padding()
                }
            }
            VStack (alignment: .leading, spacing: 16) {
                Text("Example scales").bold()
                    .font(.system(.title, design: .rounded))
                    .padding()
            }
            VStack (alignment: .leading, spacing: 16) {
                HStack {
                    Text("1.000:").font(.system(.body, design: .monospaced)).bold()
                    Text("Browser default").font(.system(.body, design: .default))
                }
            }.padding(.leading, 32).padding(.trailing, 32).padding(.top, 32)
        Spacer()
        }
    }
}

struct SavesModalView_Previews: PreviewProvider {
    static var previews: some View {
        SavesModalView()
    }
}
