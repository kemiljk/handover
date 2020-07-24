//
//  EmToPx.swift
//  Px ›› Em
//
//  Created by Karl Koch on 21/07/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit

struct EmToPx: View {
    @State private var show_modal: Bool = false
    @State private var show_settings_modal: Bool = false
    
    @State private var baseText = "16"
    @State private var emText = "1"
    @State private var scaleText = "1.000"
    @State private var baseTextEmpty = ""
    @State private var emTextEmpty = ""
    @State private var scaleTextEmpty = ""
    
    lazy var emInt = Double(emText) ?? 1
    lazy var baseInt = Double(baseText) ?? 16
    lazy var scaleInt = Double(scaleText) ?? 1.000
    
    func emToPxs(baseInt: Double, emInt: Double, scaleInt: Double) -> Double {
        let pxValue = (emInt * baseInt) / scaleInt
        return pxValue
    }
    
    let modal = UIImpactFeedbackGenerator(style: .light)
    
        var body: some View {
            VStack {
                VStack (alignment: .leading)  {
                    HStack {
                        Text("Em ›› Px").bold().padding()
                        .multilineTextAlignment(.leading)
                            .font(.system(.largeTitle, design: .rounded))
                        Spacer()
                        Button(action: {
                            self.show_settings_modal = true
                            self.modal.impactOccurred()
                        }) {
                            Image(systemName: "square.grid.2x2.fill").padding()
                                .font(.title)
                                .foregroundColor(Color(red: 1.00, green: 0.60, blue: 0.00, opacity: 1.0))
                        }
                        .sheet(isPresented: self.$show_settings_modal) {
                        SettingsModalView()
                    }
                    }
                    VStack (alignment: .leading) {
                        Text("Baseline pixel value").font(.headline)
                        TextField("16", text: $baseTextEmpty)
                        .font(.system(.title, design: .monospaced))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0), lineWidth: 3))
                        .keyboardType(.decimalPad)
                    }.padding(20)
                VStack (alignment: .leading) {
                    HStack {
                        VStack (alignment: .leading) {
                        Text("Ems to convert").font(.headline)
                        TextField("1.000", text: $emTextEmpty)
                        .font(.system(.title, design: .monospaced))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 1.00, green: 0.60, blue: 0.00, opacity: 1.0), lineWidth: 3))
                        .keyboardType(.decimalPad)
                        }.padding(.leading, 20).padding(.trailing, 20)
                        VStack (alignment: .leading) {
                            HStack {
                                Text("Scale").font(.headline)
                                Button(action: {
                                    self.show_modal = true
                                    self.modal.impactOccurred()
                                }) {
                                Image(systemName: "info.circle").padding(.leading, 16).padding(.trailing, 16)
                                    .foregroundColor(Color(red: 1.00, green: 0.60, blue: 0.00, opacity: 1.0))
                                    .font(.system(size: 20, weight: .semibold))
                                }
                                .sheet(isPresented: self.$show_modal) {
                                ScaleModalView()
                            }
                        }
                        TextField("1.000", text: $scaleTextEmpty)
                        .font(.system(.title, design: .monospaced))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 1.00, green: 0.60, blue: 0.00, opacity: 1.0), lineWidth: 3))
                        .keyboardType(.decimalPad)
                        }.padding(.leading, 20).padding(.trailing, 20)
                    }
                }
            }
            ZStack {
                Rectangle()
                    .fill(Color("shape"))
                VStack (alignment: .center) {
                    Spacer()
                    Text("\(String(format: "%.3f", (Double(emTextEmpty) ?? 1.000)))em is \(String(format: "%.0f", emToPxs(baseInt: Double(baseTextEmpty) ?? 16, emInt: Double(emTextEmpty) ?? 1, scaleInt: Double(scaleTextEmpty) ?? 1)))px")
                        .font(.system(.title, design: .monospaced)).bold()
                    Spacer()
                }.padding()
                }
        }.modifier(AdaptsToSoftwareKeyboard())
    }
}

struct EmToPx_Previews: PreviewProvider {
    static var previews: some View {
        EmToPx()
    }
}
