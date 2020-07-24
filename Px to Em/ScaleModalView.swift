//
//  ScaleModalView.swift
//  Px ›› Em
//
//  Created by Karl Koch on 22/07/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct ScaleModalView: View {
    var body: some View {
        VStack {
            Image(systemName: "chevron.compact.down").font(.system(size: 40, weight: .semibold)).padding(.top, 20).foregroundColor(Color.secondary)
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
                HStack {
                    Text("1.067:").font(.system(.body, design: .monospaced)).bold()
                    Text("Minor second").font(.system(.body, design: .default))
                }
                HStack {
                    Text("1.125:").font(.system(.body, design: .monospaced)).bold()
                    Text("Major second").font(.system(.body, design: .default))
                }
                HStack {
                    Text("1.200:").font(.system(.body, design: .monospaced)).bold()
                    Text("Minor third").font(.system(.body, design: .default))
                }
                HStack {
                    Text("1.250:").font(.system(.body, design: .monospaced)).bold()
                    Text("Major third").font(.system(.body, design: .default))
                }
                HStack {
                    Text("1.333:").font(.system(.body, design: .monospaced)).bold()
                    Text("Perfect fourth").font(.system(.body, design: .default))
                }
                HStack {
                    Text("1.414:").font(.system(.body, design: .monospaced)).bold()
                    Text("Augmented fourth").font(.system(.body, design: .default))
                }
                HStack {
                    Text("1.500:").font(.system(.body, design: .monospaced)).bold()
                    Text("Perfect fifth").font(.system(.body, design: .default))
                }
                HStack {
                    Text("1.618:").font(.system(.body, design: .monospaced)).bold()
                    Text("Golden ratio").font(.system(.body, design: .default))
                }
            }.padding()
        Spacer()
        }
    }
}

struct ScaleModalView_Previews: PreviewProvider {
    static var previews: some View {
        ScaleModalView()
    }
}
