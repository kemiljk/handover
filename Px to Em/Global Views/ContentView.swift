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

struct ContentView: View {
    @ObservedObject var pxResults = PXResults()
    @ObservedObject var emResults = EMResults()
    @ObservedObject var lhResults = LHResults()
    var device = UIDevice.current.userInterfaceIdiom

    var body: some View {
        if device == .phone {
        TabView {
            PxToEm(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults)
                .tabItem {
                    Image(systemName: "arrow.right.circle.fill")
                    Text("Px ›› Rem")
                }
                .onTapGesture {
                    self.hideKeyboard()
                }
            EmToPx(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults)
                .tabItem {
                    Image(systemName: "arrow.backward.circle.fill")
                    Text("Rem ›› Px")
                }
                .onTapGesture {
                    self.hideKeyboard()
                }
            LineHeight(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults)
                .tabItem {
                    Image(systemName: "lineweight")
                    Text("Line-Height")
                }
                .onTapGesture {
                    self.hideKeyboard()
                }
        }
        .accentColor(Color("teal"))
        }
        else if device == .pad
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
            ContentView()
                .previewDevice("iPhone 12 Pro")
        }
    }
}
