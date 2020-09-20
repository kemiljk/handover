//
//  AboutView.swift
//  Px ›› Em
//
//  Created by Karl Koch on 20/09/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack (alignment: .leading) {
            VStack (alignment: .leading,  spacing: 8) {
                Text("Need to handover to developers? Tired of trying to figure out what the relative em value would be for your pixels? Well, no longer.").font(.system(.body))
                Text("With Px ›› Em you can:").font(.system(.headline)).padding(.vertical, 16)
                Text("Convert any number from pixels to ems").font(.system(.body))
                    Text("Change the baseline pixel value to whatever you want it to be and see the relevant changes in em conversion").font(.system(.body))
                    Text("Change the conversion scale so you're not stuck with a 1.000 scale").font(.system(.body))
            }
            VStack (alignment: .leading,  spacing: 8) {
                Text("With Em ›› Px you can:").font(.system(.headline)).padding(.vertical, 16)
                    Text("Convert any number from ems to pixels").font(.system(.body))
                    Text("Change the baseline pixel value to whatever you want it to be and see the relevant changes in pixel conversion").font(.system(.body))
                    Text("Change the conversion scale so you're not stuck with a 1.000 scale").font(.system(.body))
                }
        }.navigationBarTitle(Text("About")).padding()
        Spacer()
    }
}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
