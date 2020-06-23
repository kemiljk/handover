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

struct AdaptsToSoftwareKeyboard: ViewModifier {
    
    @State var currentHeight: CGFloat = 0


    func body(content: Content) -> some View {
        content
            .padding(.bottom, currentHeight).animation(.easeOut(duration: 0.25))
            .edgesIgnoringSafeArea(currentHeight == 0 ? Edge.Set() : .bottom)
            .onAppear(perform: subscribeToKeyboardChanges)
    }

    //MARK: - Keyboard Height
    private let keyboardHeightOnOpening = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .map { $0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect }
        .map { $0.height }

    
    private let keyboardHeightOnHiding = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map {_ in return CGFloat(0) }
    
    //MARK: - Subscriber to Keyboard's changes
    
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
    /* @State private var scales = ["Browser default (1.000)", "Minor second (1.067)", "Major second (1.125)", "Minor third (1.200)", "Major third (1.250)", "Perfect fourth (1.333)", "Augmented fourth (1.414)", "Perfect fifth (1.500)", "Golden ratio (1.618)"] */
    let scales = [1.000, 1.067, 1.125, 1.200, 1.250, 1.333, 1.414, 1.500, 1.618]
    
    @State private var baseText = "16"
    @State private var pixelText = "16"
    
    lazy var pixelInt = Double(pixelText) ?? 0
    lazy var baseInt = Double(baseText) ?? 16
   
    @State private var scaleSelector = 0
    
    func pxToEms(baseInt: Double, pixelInt: Double, scales: Double) -> Double {
        let emValue = (pixelInt / baseInt) * scales
        return emValue
    }
    
    var body: some View {
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
                    Picker(selection: $scaleSelector, label: Text("Scale")) {
                            ForEach(0..<scales.count) {
                                Text("\(String(format: "%.3f", (self.scales[$0])))")
                        }
                    }
                    .padding()
                }
                
                VStack (alignment: .center) {
                    Spacer()
                    Text("\(pixelText) Pixels is \(String(format: "%.3f", pxToEms(baseInt: Double(baseText) ?? 16, pixelInt: Double(pixelText) ?? 0, scales: Double(scales[scaleSelector])))) Em")
                        .font(.largeTitle).bold()
                        .labelsHidden()
                       Spacer()
                   }.padding()
                
                    /* Button(action: {
                        // TODO: Make button copy conversion to clipboard
                    }) {
                      Text("Convert")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0))
                        .cornerRadius(8)
                    }
                        .frame(alignment: .center).padding()*/
                
                Spacer()
        }.modifier(AdaptsToSoftwareKeyboard())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

