//
//  PxToEm.swift
//  Px ›› Em
//
//  Created by Karl Koch on 21/07/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct PxToRem: View {
    @ObservedObject var pxResults: PXResults
    @ObservedObject var emResults: EMResults
    @ObservedObject var lhResults: LHResults
    @ObservedObject var twResults: TWResults
    @ObservedObject var prResults: PRResults
    var device = UIDevice.current.userInterfaceIdiom
    @State private var selectedSegment = 0
    @Namespace var segmentedController
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if device == .phone {
            NavigationView {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.secondary).opacity(colorScheme == .light ? 0.2 : 0.4)
                            .frame(width: 196, height: 38, alignment: .center)
                        RoundedRectangle(cornerRadius: 6)
                            .foregroundColor(colorScheme == .light ? .white : .secondary.opacity(0.5))
                            .frame(width: 96, height: 32, alignment: .center)
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 0)
                            .offset(x: selectedSegment == 0 ? -46 : 46)
                        HStack(spacing: 28) {
                            Button(action: {
                                withAnimation(.spring()) {
                                    self.selectedSegment = 0
                                }
                            }, label: {
                                Text("Px››Rem")
                                    .foregroundColor(.primary)
                            })
                            .tag(0)
                            .gesture(
                                DragGesture()
                                    .onEnded { _ in
                                    withAnimation(.spring()) {
                                        self.selectedSegment = 1
                                    }
                                }
                            )
                            Button(action: {
                                withAnimation(.spring()) {
                                    self.selectedSegment = 1
                                }
                            }, label: {
                                Text("Rem››Px")
                                    .foregroundColor(.primary)
                            })
                            .tag(1)
                            .gesture(
                                DragGesture()
                                    .onEnded { _ in
                                    withAnimation(.spring()) {
                                        self.selectedSegment = 0
                                    }
                                }
                            )
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .padding()
                    if self.selectedSegment == 0 {
                        PxToEmView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
                    }
                    else {
                        EmToPxView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
                    }
                }
            }
        } else {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.secondary).opacity(colorScheme == .light ? 0.2 : 0.4)
                        .frame(width: 196, height: 38, alignment: .center)
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(colorScheme == .light ? .white : .secondary.opacity(0.5))
                        .frame(width: 96, height: 32, alignment: .center)
                        .shadow(color: .black.opacity(0.1), radius: 4, x: 2, y: 0)
                        .offset(x: selectedSegment == 0 ? -46 : 46)
                    HStack(spacing: 28) {
                        Button(action: {
                            withAnimation(.spring()) {
                                self.selectedSegment = 0
                            }
                        }, label: {
                            Text("Px››Rem")
                                .foregroundColor(.primary)
                        })
                        .tag(0)
                        .gesture(
                            DragGesture()
                                .onEnded { _ in
                                withAnimation(.spring()) {
                                    self.selectedSegment = 1
                                }
                            }
                        )
                        Button(action: {
                            withAnimation(.spring()) {
                                self.selectedSegment = 1
                            }
                        }, label: {
                            Text("Rem››Px")
                                .foregroundColor(.primary)
                        })
                        .tag(1)
                        .gesture(
                            DragGesture()
                                .onEnded { _ in
                                withAnimation(.spring()) {
                                    self.selectedSegment = 0
                                }
                            }
                        )
                    }
                }
                .frame(width: UIScreen.main.bounds.width / 4)
                if self.selectedSegment == 0 {
                    PxToEmView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
                }
                else {
                    EmToPxView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
                }
            }
        }
    }
}
