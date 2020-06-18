//
//  ContentView.swift
//  Px to Em
//
//  Created by Karl Koch on 16/06/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    /* var scales = ["Browser default (1.000)", "Minor second (1.067)", "Major second (1.125)", "Minor third (1.200)", "Major third (1.250)", "Perfect fourth (1.333)", "Augmented fourth (1.414)", "Perfect fifth (1.500)", "Golden ratio (1.618)"] */

    //@State private var selectedScale = 0
    @State var baseText: String = "16"
    @State var pixelText: String = "16"
    
    lazy var pixelInt = Double(pixelText) ?? 0
    lazy var baseInt = Double(baseText) ?? 0
    
    func pxToEms(pixelInt: Double, baseInt: Double) -> Double {
    let emValue = pixelInt / baseInt
    return emValue
    }
    
    var body: some View {
        //NavigationView {
            VStack {
                VStack (alignment: .leading)  {
                    Text("Px ›› Em").bold().padding(.top, 48)
                    .multilineTextAlignment(.leading)
                    .font(.largeTitle)
                    .padding()
                    Text("Baseline pixel value").padding(.leading, 20.0).padding(.bottom, -16.0).padding(.top, 20.0).font(.headline)
                    TextField(baseText, text: $baseText)
                        .font(.largeTitle)
                    .padding(20)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 1.00, green: 0.60, blue: 0.00, opacity: 1.0), lineWidth: 3).padding(20))
                VStack (alignment: .leading) {
                    Text("Pixel value to convert").padding(.leading, 20.0).padding(.bottom, -16.0).padding(.top, 20.0).font(.headline)
                    TextField(pixelText, text: $pixelText)
                        .font(.largeTitle)
                    .padding(20)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0), lineWidth: 3).padding(20))
                    }
                }
                VStack (alignment: .center) {
                       Spacer()
                    Text("\(pixelText) Pixels is \(String(format: "%.3f",pxToEms(pixelInt: Double(pixelText) ?? 0, baseInt: Double(baseText) ?? 16))) Em")
                        .font(.largeTitle).bold()
                       Spacer()
                   }.padding()
                
                    /* Button(action: {
                        // TODO: Make button perform conversion
                    }) {
                      Text("Convert")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0))
                        .cornerRadius(8)
                    }
                        .frame(alignment: .center).padding() */
                
                Spacer()
            //}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

