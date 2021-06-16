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
    
    @State private var defaultView = 0
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        if device == .pad {
            List {
                NavigationLink(
                    destination: PxToEm(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults),
                    label: {
                        HStack {
                            Image(systemName: "arrow.right.circle.fill")
                            Text("Px››Rem")
                        }
                    }).tag(0)
                NavigationLink(
                    destination: EmToPx(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults),
                    label: {
                        HStack {
                            Image(systemName: "arrow.left.circle.fill")
                            Text("Rem››Px")
                        }
                    }).tag(1)
                NavigationLink(
                    destination: LineHeight(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults),
                    label: {
                        HStack {
                            Image(systemName: "lineweight")
                            Text("Line››height")
                        }
                    }).tag(2)
                NavigationLink(
                    destination: PxToTw(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults),
                    label: {
                        HStack {
                            Image(systemName: "text.and.command.macwindow")
                            Text("Px››Tailwind")
                        }
                    }).tag(3)
            }
            .navigationTitle("Hand››over")
            .listStyle(SidebarListStyle())
        }
        
        else {
            List {
                NavigationLink(
                    destination: PxToEm(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults),
                    label: {
                        HStack {
                            Image(systemName: "arrow.right.circle.fill")
                            Text("Px››Rem")
                        }
                    }).tag(0)
                NavigationLink(
                    destination: EmToPx(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults),
                    label: {
                        HStack {
                            Image(systemName: "arrow.left.circle.fill")
                            Text("Rem››Px")
                        }
                    }).tag(1)
                NavigationLink(
                    destination: LineHeight(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults),
                    label: {
                        HStack {
                            Image(systemName: "lineweight")
                            Text("Line››height")
                        }
                    }).tag(2)
                NavigationLink(
                    destination: PxToTw(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults),
                    label: {
                        HStack {
                            Image(systemName: "text.and.command.macwindow")
                            Text("Px››Tailwind")
                        }
                    }).tag(3)
                NavigationLink(
                    destination: SavesModalView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults),
                    label: {
                        HStack {
                            Image(systemName: "bookmark.circle.fill")
                            Text("Saved results")
                        }
                    }).tag(4)
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
    
    var body: some View {
        PxToEm(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults)
    }
}


struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}





