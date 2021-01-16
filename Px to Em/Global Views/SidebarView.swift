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
    @State private var defaultView = 0
    
    var body: some View {
        List {
            NavigationLink(
                destination: PxToEm(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults),
                label: {
                    HStack {
                        Image(systemName: "arrow.right.circle.fill")
                        Text("Px ›› Rem")
                    }
                }).tag(0)
            NavigationLink(
                destination: EmToPx(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults),
                label: {
                    HStack {
                        Image(systemName: "arrow.left.circle.fill")
                        Text("Rem ›› Px")
                    }
                }).tag(1)
            NavigationLink(
                destination: LineHeight(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults),
                label: {
                    HStack {
                        Image(systemName: "lineweight")
                        Text("Line››height")
                    }
                }).tag(2)
        }
        .navigationTitle("Hand››over")
        .listStyle(SidebarListStyle())
    }
}

struct SecondaryView: View {
    @ObservedObject var pxResults = PXResults()
    @ObservedObject var emResults = EMResults()
    @ObservedObject var lhResults = LHResults()
    
    var body: some View {
        PxToEm(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults)
    }
}


struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}





