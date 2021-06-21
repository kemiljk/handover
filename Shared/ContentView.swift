//
//  ContentView.swift
//  Px ›› Em
//
//  Created by Karl Koch on 11/10/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct MacButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color("teal") : Color.white)
            .background(configuration.isPressed ? Color.white : Color("teal"))
            .cornerRadius(8)
            .padding()
    }
}

struct ContentView: View {
    @ObservedObject var pxResults = PXResults()
    @ObservedObject var emResults = EMResults()
    @ObservedObject var lhResults = LHResults()
    @ObservedObject var twResults = TWResults()
    @ObservedObject var prResults = PRResults()
    var device = UIDevice.current.userInterfaceIdiom

    var body: some View {
        if device == .phone {
        TabView {
            PxToEm(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
                .tabItem {
                    Label("Px››Rem", systemImage: "arrow.uturn.right.circle")
                }
                .onTapGesture {
                    self.hideKeyboard()
                }
            EmToPx(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
                .tabItem {
                    Label("Rem››Px", systemImage: "arrow.uturn.left.circle")
                }
                .onTapGesture {
                    self.hideKeyboard()
                }
            LineHeight(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
                .tabItem {
                    Label("Line-height", systemImage: "lineweight")
                }
                .onTapGesture {
                    self.hideKeyboard()
                }
            PxToTw(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
                .tabItem {
                    Label("Tailwind", systemImage: "paintpalette.fill")
                }
                .onTapGesture {
                    self.hideKeyboard()
                }
            PerfectRadius(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
                .tabItem {
                    Label("Radius", systemImage: "rectangle.inset.fill")
                }
                .onTapGesture {
                    self.hideKeyboard()
                }
        }
        .accentColor(Color("teal"))
        }
        else
        {
        NavigationView {
                SidebarView()
                SecondaryView()
            .navigationTitle("Hand››over")
            }
            .accentColor(Color("teal"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
