//
//  AboutView.swift
//  Px ›› Em
//
//  Created by Karl Koch on 20/09/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack (alignment: .leading) {
            VStack (alignment: .leading,  spacing: 8) {
                Text("What is Hand››over?")
                    .font(.title)
                Text("Need to handover to developers? Tired of trying to figure out what the relative rem value would be for your pixels? Tired of not being sure what the best line-height is and how it'll look? Well, no longer.").font(.system(.body))
                Text("With Hand››over you can:").font(.system(.headline)).padding(.vertical, 16)
                Group {
                    Section (header: Text("PIXELS TO REM")) {
                        List {
                            HStack {
                                Image(systemName: "chevron.right.2")
                                Text("Convert any number from pixels to rem").font(.system(.body))
                            }
                            HStack {
                                Image(systemName: "chevron.right.2")
                                Text("Change the baseline pixel value to whatever you want it to be and see the relevant changes in rem conversion").font(.system(.body))
                            }
                            HStack {
                                Image(systemName: "chevron.right.2")
                                Text("Change the conversion scale so you're not stuck with a 1.000 scale").font(.system(.body))
                            }
                        }
                    }
                    Section (header: Text("REM TO PIXELS")) {
                        List {
                            HStack {
                                Image(systemName: "chevron.right.2")
                                Text("Convert any number from rem to pixels").font(.system(.body))
                            }
                            HStack {
                                Image(systemName: "chevron.right.2")
                                Text("Change the baseline pixel value to whatever you want it to be and see the relevant changes in pixel conversion").font(.system(.body))
                            }
                            HStack {
                                Image(systemName: "chevron.right.2")
                                Text("Change the conversion scale so you're not stuck with a 1.000 scale").font(.system(.body))
                            }
                        }
                    }
                    Section (header: Text("LINE-HEIGHT")) {
                        List {
                            HStack {
                                Image(systemName: "chevron.right.2")
                                Text("Find the perfect line-height based on a pixel size").font(.system(.body))
                            }
                            HStack {
                                Image(systemName: "chevron.right.2")
                                Text("Change the conversion ratio based on what you need").font(.system(.body))
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .navigationBarTitle("About")
        Spacer()
    }
}


struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
