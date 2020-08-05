//
//  Calculation.swift
//  Px to Em
//
//  Created by Karl Koch on 04/08/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct CalculationView: View {
//    @State private var baseText = "16"
//    @State private var pixelText = "16"
//    @State private var scaleText = "1.000"
//    @State private var baseTextEmpty = ""
//    @State private var pixelTextEmpty = ""
//    @State private var scaleTextEmpty = ""
//
//    lazy var pixelInt = Double(pixelText) ?? 16
//    lazy var baseInt = Double(baseText) ?? 16
//    lazy var scaleInt = Double(scaleText) ?? 1.000
    
    func pxToEms(baseInt: Double, pixelInt: Double, scaleInt: Double) -> Double {
        let emValue = (pixelInt / baseInt) * scaleInt
        return emValue
    }
    
    let resultText: ResultText
    
    var body: some View {
        Text("\(resultText.pixelTextEmpty)px is \(String(format: "%.3f", pxToEms(baseInt: resultText.baseTextEmpty, pixelInt: resultText.pixelTextEmpty, scaleInt: resultText.scaleTextEmpty)))em")
            .font(.system(.title, design: .monospaced)).bold()
    }
}
