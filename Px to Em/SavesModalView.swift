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

struct Calculation: Codable {
    var resultData: String
}

struct SavesModalView: View {
    @Environment(\.presentationMode) private var presentationMode
    var device = UIDevice.current.userInterfaceIdiom
    
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.px-to-em"))
    var resultData: Data = Data()

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

//    func calculationStore(_ result: String) {
//        guard let calculation = try? JSONDecoder().decode(String.self, from: resultData) else { return }
//        self.resultData = calculation
//        print("\(Int(pixelTextEmpty) ?? 16)px is \(String(format: "%.3f", pxToEms(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16, scaleInt: Double(scaleTextEmpty) ?? 1)))em")
//    }
    
//    var result = try? JSONDecoder().decode(Calculation.self, from: Data())
    
//    func getCalculation() {
//        let
//    }
    
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
                    Text("Your saved conversions").bold()
                        .font(.system(.title, design: .rounded))
                        .padding()
                }
                VStack (alignment: .leading, spacing: 16) {
//                    Text("\(entry.calculation)")
                }
            }.padding(.leading, 32).padding(.trailing, 32).padding(.top, 32)
        Spacer()
        }
    }

struct SavesModalView_Previews: PreviewProvider {
    static var previews: some View {
        SavesModalView()
    }
}
