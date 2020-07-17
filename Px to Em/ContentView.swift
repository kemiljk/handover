//
//  ContentView.swift
//  Px to Em
//
//  Created by Karl Koch on 16/06/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import UIKit

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct AdaptsToSoftwareKeyboard: ViewModifier {
    
    @State var currentHeight: CGFloat = 0


    func body(content: Content) -> some View {
        content
            .padding(.bottom, currentHeight).animation(.easeOut(duration: 0.25))
            .edgesIgnoringSafeArea(currentHeight == 0 ? Edge.Set() : .bottom)
            .onAppear(perform: subscribeToKeyboardChanges)
    }

    private let keyboardHeightOnOpening = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .map { $0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect }
        .map { $0.height }

    
    private let keyboardHeightOnHiding = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map {_ in return CGFloat(0) }
    
    private func subscribeToKeyboardChanges() {
        
        _ = Publishers.Merge(keyboardHeightOnOpening, keyboardHeightOnHiding)
            .subscribe(on: RunLoop.main)
            .sink { height in
                if self.currentHeight == 0 || height == 0 {
                    self.currentHeight = height
                }
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

struct ContentView: View {
    @State private var baseText = "16"
    @State private var pixelText = "16"
    @State private var scaleText = "1.000"
    @State private var baseTextEmpty = ""
    @State private var pixelTextEmpty = ""
    @State private var scaleTextEmpty = ""
    
    lazy var pixelInt = Double(pixelText) ?? 0
    lazy var baseInt = Double(baseText) ?? 16
    lazy var scaleInt = Double(scaleText) ?? 0
    
    func pxToEms(baseInt: Double, pixelInt: Double, scaleInt: Double) -> Double {
        let emValue = (pixelInt / baseInt) * scaleInt
        return emValue
    }
    
    let pxOrange = Color(red: 1.00, green: 0.60, blue: 0.00, opacity: 1.0)
    let pxTeal = Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0)
    
    var body: some View {
            VStack {
                VStack (alignment: .leading)  {
                    Text("Px ›› Em").bold().padding(.top, 44)
                    .multilineTextAlignment(.leading)
                        .font(.system(.largeTitle, design: .rounded))
                    .padding()
                    Text("Baseline pixel value").padding(.leading, 20.0).padding(.bottom, -16.0).padding(.top, 20.0).font(.headline)
                    TextField("16", text: $baseTextEmpty)
                    .font(.system(.title, design: .monospaced))
                    .padding(20)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 1.00, green: 0.60, blue: 0.00, opacity: 1.0), lineWidth: 3).padding(20))
                    .keyboardType(.decimalPad)
                VStack (alignment: .leading) {
                    HStack {
                        VStack (alignment: .leading) {
                        Text("Pixel value to convert").padding(.leading, 20.0).padding(.bottom, -16.0).padding(.top, 20.0).font(.headline)
                        TextField("16", text: $pixelTextEmpty)
                        .font(.system(.title, design: .monospaced))
                        .padding(20)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0), lineWidth: 3).padding(20))
                        .keyboardType(.decimalPad)
                        }
                        VStack (alignment: .leading) {
                        Text("Conversion scale").padding(.leading, 20.0).padding(.bottom, -16.0).padding(.top, 20.0).font(.headline)
                        TextField("1.000", text: $scaleTextEmpty)
                        .font(.system(.title, design: .monospaced))
                        .padding(20)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0), lineWidth: 3).padding(20))
                        .keyboardType(.decimalPad)
                        }
                    }
                }
            }
            VStack (alignment: .center) {
                Spacer()
                Text("\(pixelTextEmpty)px is \(String(format: "%.3f", pxToEms(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 0, scaleInt: Double(scaleTextEmpty) ?? 0)))em")
                .font(.system(.title, design: .monospaced)).bold()
                Spacer()
               }.padding()
                
            VStack {
                Button("Dismiss") {
                    self.hideKeyboard()
                }.padding()
            }
        }.modifier(AdaptsToSoftwareKeyboard())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

