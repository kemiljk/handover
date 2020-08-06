//
//  PxToEm.swift
//  Px ›› Em
//
//  Created by Karl Koch on 21/07/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit

struct PxToEm: View {
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.px-to-em"))
    var resultData: Data = Data()
    
    @State private var show_modal: Bool = false
    
    @State private var baseText = "16"
    @State private var pixelText = "16"
    @State private var scaleText = "1.000"
    @State private var baseTextEmpty = ""
    @State private var pixelTextEmpty = ""
    @State private var scaleTextEmpty = ""
    
    lazy var pixelInt = Double(pixelText) ?? 16
    lazy var baseInt = Double(baseText) ?? 16
    lazy var scaleInt = Double(scaleText) ?? 1.000
    
    func pxToEms(baseInt: Double, pixelInt: Double, scaleInt: Double) -> Double {
        let emValue = (pixelInt / baseInt) * scaleInt
        return emValue
    }
    
    func save(_ calcResult: String) {
        guard let calculation = try? JSONEncoder().encode(calcResult) else { return }
        self.resultData = calculation
        print("\(Int(pixelTextEmpty) ?? 16)px is \(String(format: "%.3f", pxToEms(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16, scaleInt: Double(scaleTextEmpty) ?? 1)))em at \(String(format: "%.3f", (Double(scaleTextEmpty) ?? 1))) with a baseline of \(Int(baseTextEmpty) ?? 16)px")
    }
    
    let modal = UIImpactFeedbackGenerator(style: .light)
    
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
         VStack {
               VStack (alignment: .leading)  {
                    Text("Px ›› Em").bold().padding()
                    .multilineTextAlignment(.leading)
                        .font(.system(.largeTitle, design: .rounded))

                   VStack (alignment: .leading) {
                       Text("Baseline pixel value").font(.headline)
                       TextField("16", text: $baseTextEmpty)
                       .font(.system(.title, design: .monospaced))
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 1.00, green: 0.60, blue: 0.00, opacity: 1.0), lineWidth: 3))
                       .keyboardType(.decimalPad)
                   }.padding(20)
               VStack (alignment: .leading) {
                   HStack {
                       VStack (alignment: .leading) {
                       Text("Pixels").font(.headline)
                       TextField("16", text: $pixelTextEmpty)
                       .font(.system(.title, design: .monospaced))
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                           .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0), lineWidth: 3))
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
                                   .foregroundColor(Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0))
                                   .font(.system(size: 20, weight: .semibold))
                               }
                               .sheet(isPresented: self.$show_modal) {
                               ScaleModalView()
                           }
                       }
                       TextField("1.000", text: $scaleTextEmpty)
                       .font(.system(.title, design: .monospaced))
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0), lineWidth: 3))
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
                    Text("\(Int(pixelTextEmpty) ?? 16)px is \(String(format: "%.3f", pxToEms(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16, scaleInt: Double(scaleTextEmpty) ?? 1)))em")
                    .font(.system(.title, design: .monospaced)).bold()
                    Spacer()
                    VStack {
                        Button(action: {
                            save("\(Int(pixelTextEmpty) ?? 16)px is \(String(format: "%.3f", pxToEms(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16, scaleInt: Double(scaleTextEmpty) ?? 1)))em at \(String(format: "%.3f", (Double(scaleTextEmpty) ?? 1))) with a baseline of \(Int(baseTextEmpty) ?? 16)px")
                        }, label: {
                            Text("Save result").foregroundColor(.white).bold()
                        })
                        .foregroundColor(.primary)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 24)
                        .background(Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0))
                        .clipShape(Capsule())
                    }
                    Spacer()
                }.padding()
            }
       }
   }
}

struct PxToEm_Previews: PreviewProvider {
    static var previews: some View {
        PxToEm()
    }
}
