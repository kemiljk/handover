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
    private let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack (alignment: .leading,  spacing: 8) {
                Text("What is Hand››over?")
                    .font(.title)
                    .bold()
                Text("Need to handover to developers? Tired of trying to figure out what the relative rem value would be for your pixels? Tired of not being sure what the best line-height is and how it'll look? Well, no longer.").font(.system(.body))
                Text("With Hand››over you can:")
                    .font(.system(.headline))
                    .padding(.vertical, 16)
                
                VStack(alignment: .leading) {
                    GroupBox("PIXELS TO REM") {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .top) {
                                Image(systemName: "chevron.right.2")
                                Text("Convert any number from pixels to rem")
                                Spacer()
                            }
                            HStack(alignment: .top) {
                                Image(systemName: "chevron.right.2")
                                Text("Change the baseline pixel value")
                                Spacer()
                            }
                            HStack(alignment: .top) {
                                Image(systemName: "chevron.right.2")
                                Text("Change the conversion scal")
                                Spacer()
                            }
                        }
                        .padding(.top, 4)
                    }
                    GroupBox("REM TO PIXELS") {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .top) {
                                Image(systemName: "chevron.right.2")
                                Text("Pixels to Rem, but in reverse!")
                                Spacer()
                            }
                        }
                        .padding(.top, 4)
                    }
                    GroupBox("PIXELS TO TAILWIND") {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .top) {
                                Image(systemName: "chevron.right.2")
                                Text("Find the correct Tailwind class value")
                                Spacer()
                            }
                            HStack(alignment: .top) {
                                Image(systemName: "chevron.right.2")
                                Text("Change the baseline pixel value")
                                Spacer()
                            }
                        }
                        .padding(.top, 4)
                    }
                    GroupBox("LINE-HEIGHT") {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .top) {
                                Image(systemName: "chevron.right.2")
                                Text("Find the perfect line-height")
                                Spacer()
                            }
                            HStack(alignment: .top) {
                                Image(systemName: "chevron.right.2")
                                Text("Change the conversion scale")
                                Spacer()
                            }
                        }
                        .padding(.top, 4)
                    }
                    GroupBox("PERFECT RADIUS") {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(alignment: .top) {
                                Image(systemName: "chevron.right.2")
                                Text("Find perfect inner or outer radii")
                                Spacer()
                            }
                        }
                        .padding(.top, 4)
                    }
                }
                .font(.system(.callout))
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
