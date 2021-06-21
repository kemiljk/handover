//
//  SidebarView.swift
//  Px ›› Em
//
//  Created by Karl Koch on 12/10/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct SidebarView: View {
    @ObservedObject var pxResults = PXResults()
    @ObservedObject var emResults = EMResults()
    @ObservedObject var lhResults = LHResults()
    @ObservedObject var twResults = TWResults()
    @ObservedObject var prResults = PRResults()
    
    @State private var defaultView = 0
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        if device == .pad {
            List {
                NavigationLink(
                    destination: PxToEm(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults),
                    label: {
                        HStack {
                            Label("Px››Rem", systemImage: "arrow.uturn.right.circle.fill")
                        }
                    }).tag(0)
                NavigationLink(
                    destination: EmToPx(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults),
                    label: {
                        HStack {
                            Label("Rem››Px", systemImage: "arrow.uturn.left.circle.fill")
                        }
                    }).tag(1)
                NavigationLink(
                    destination: LineHeight(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults),
                    label: {
                        HStack {
                            Label("Line››height", systemImage: "lineweight")
                        }
                    }).tag(2)
                NavigationLink(
                    destination: PxToTw(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults),
                    label: {
                        HStack {
                            Label("Px››Tailwind", systemImage: "paintpalette.fill")
                        }
                    }).tag(3)
                NavigationLink(
                    destination: PxToTw(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults),
                    label: {
                        HStack {
                            Label("Perfect››radius", systemImage: "rectangle.inset.fill")
                        }
                    }).tag(4)
            }
            .navigationTitle("Hand››over")
            .listStyle(SidebarListStyle())
        }
        
        else {
            List {
                NavigationLink(
                    destination: PxToEm(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults),
                    label: {
                        HStack {
                            Label("Px››Rem", systemImage: "arrow.uturn.right.circle.fill")
                        }
                    }).tag(0)
                NavigationLink(
                    destination: EmToPx(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults),
                    label: {
                        HStack {
                            Label("Rem››Px", systemImage: "arrow.uturn.left.circle.fill")
                        }
                    }).tag(1)
                NavigationLink(
                    destination: LineHeight(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults),
                    label: {
                        HStack {
                            Label("Line››height", systemImage: "lineweight")
                        }
                    }).tag(2)
                NavigationLink(
                    destination: PxToTw(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults),
                    label: {
                        HStack {
                            Label("Px››Tailwind", systemImage: "paintpalette.fill")
                        }
                    }).tag(3)
                NavigationLink(
                    destination: PxToTw(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults),
                    label: {
                        HStack {
                            Label("Perfect››radius", systemImage: "rectangle.inset.fill")
                        }
                    }).tag(4)
                NavigationLink(
                    destination: SavesModalView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults),
                    label: {
                        HStack {
                            Image(systemName: "bookmark.circle")
                            Text("Saved results")
                        }
                    }).tag(5)
            }
            .navigationTitle("Hand››over")
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct SecondaryView: View {
    @ObservedObject var pxResults = PXResults()
    @ObservedObject var emResults = EMResults()
    @ObservedObject var lhResults = LHResults()
    @ObservedObject var twResults = TWResults()
    @ObservedObject var prResults = PRResults()
    
    var body: some View {
        PxToEm(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
    }
}


struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}





