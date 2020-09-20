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
import WidgetKit

struct EmToPx: View {
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.px-to-em"))
    var resultData: Data = Data()
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    @State private var show_modal: Bool = false
    @State var show_toast: Bool = false
    
    @State private var baseTextEmpty = ""
    @State private var emTextEmpty = ""
    @State private var scaleTextEmpty = ""
    
    func emToPxs(baseInt: Double, emInt: Double, scaleInt: Double) -> Double {
        let pxValue = (emInt * baseInt) / scaleInt
        return pxValue
    }
    
    func save(_ calcResult: String) {
        guard let calculation = try? JSONEncoder().encode(calcResult) else { return }
        self.resultData = calculation
        print("\(String(format: "%.2f", (Double(emTextEmpty) ?? 1.000)))em is \(String(format: "%.0f", emToPxs(baseInt: Double(baseTextEmpty) ?? 16, emInt: Double(emTextEmpty) ?? 1, scaleInt: Double(scaleTextEmpty) ?? 1)))px at a scale of \(String(format: "%.3f", (Double(scaleTextEmpty) ?? 1))) with a baseline of \(Int(baseTextEmpty) ?? 16)px")
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    let modal = UIImpactFeedbackGenerator(style: .light)
    
    let save = UINotificationFeedbackGenerator()
    
    var device = UIDevice.current.userInterfaceIdiom
    
        var body: some View {
            VStack {
                VStack (alignment: .leading)  {
                    Text("Em ›› Px").bold().padding()
                    .multilineTextAlignment(.leading)
                        .font(.system(.largeTitle, design: .rounded))

                    VStack (alignment: .leading) {
                        Text("Baseline pixel value").font(.headline)
                        TextField("16", text: $baseTextEmpty)
                        .font(.system(.title, design: .monospaced))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("teal"), lineWidth: 3))
                        .keyboardType(.decimalPad)
                    }.padding(20)
                VStack (alignment: .leading) {
                    HStack {
                        VStack (alignment: .leading) {
                        Text("Ems").font(.headline)
                        TextField("1.00", text: $emTextEmpty)
                        .font(.system(.title, design: .monospaced))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("orange"), lineWidth: 3))
                        .keyboardType(.decimalPad)
                        }.padding(.leading, 20).padding(.trailing, 20)
                        VStack (alignment: .leading) {
                            HStack {
                                Text("Scale").font(.headline)
                                Button(action: {
                                    self.show_modal = true
                                    if device == .phone {
                                    self.modal.impactOccurred()
                                    }
                                }) {
                                Image(systemName: "info.circle").padding(.leading, 16).padding(.trailing, 16)
                                    .foregroundColor(Color("orange"))
                                    .font(.system(size: 20, weight: .semibold))
                                }
                                .sheet(isPresented: self.$show_modal) {
                                ScaleModalView()
                            }
                        }
                        TextField("1.000", text: $scaleTextEmpty)
                        .font(.system(.title, design: .monospaced))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("orange"), lineWidth: 3))
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
                    Text("\(String(format: "%.2f", (Double(emTextEmpty) ?? 1.000)))em is \(String(format: "%.0f", emToPxs(baseInt: Double(baseTextEmpty) ?? 16, emInt: Double(emTextEmpty) ?? 1, scaleInt: Double(scaleTextEmpty) ?? 1)))px")
                        .font(.system(.title, design: .monospaced)).bold()
                    Spacer()
                    VStack {
                        Button(action: {
                            save("\(String(format: "%.2f", (Double(emTextEmpty) ?? 1.000)))em is \(String(format: "%.0f", emToPxs(baseInt: Double(baseTextEmpty) ?? 16, emInt: Double(emTextEmpty) ?? 1, scaleInt: Double(scaleTextEmpty) ?? 1)))px at a scale of \(String(format: "%.3f", (Double(scaleTextEmpty) ?? 1))) with a baseline of \(Int(baseTextEmpty) ?? 16)px")
                                if device == .phone {
                                save.notificationOccurred(.success)
                                }
                                self.show_toast = true
                            resetDefaults()
                        }, label: {
                            Text("Save result to widget").foregroundColor(.white).bold()
                        })
                        .padding(.vertical, 16)
                        .padding(.horizontal, 24)
                        .background(Color("orange"))
                        .clipShape(Capsule())
                        }
                    Spacer()
                }.padding()
            }
        }
        .popup(isPresented: $show_toast, type: .floater(verticalPadding: device == .phone ? 60 : 40), position: .top, autohideIn: 2) {
            HStack {
                Image(systemName: "checkmark").padding(.trailing, 4)
                    .font(.system(size: 20, weight: .semibold))
                Text("Saved").bold()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 32)
            .background(Color("lightGrey"))
            .clipShape(Capsule())
        }
    }
}

struct EmToPx_Previews: PreviewProvider {
    static var previews: some View {
        EmToPx()
    }
}
