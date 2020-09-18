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

extension SceneDelegate: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

struct ContentView: View {
    @State var selected = 0
    @State private var show_settings_modal: Bool = false
    @State private var show_saves_modal: Bool = false
    var device = UIDevice.current.userInterfaceIdiom
    
    let modal = UIImpactFeedbackGenerator(style: .light)
    let swipe = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
            if device == .phone || device == .pad {
            ZStack {
                GeometryReader { geo in
                PageControl(current: self.selected)
                  .position(x: geo.size.width/2, y: geo.size.height)
                 VStack {
                    TopBar(selected: self.$selected).padding(.top, 16)
                     
                         if self.selected == 0 {
                             PxToEm()
                         }
                         else {
                             EmToPx()
                        }
                 }
                Spacer()
                    HStack {
    //                    Button(action: {
    //                        self.show_saves_modal = true
    //                        self.modal.impactOccurred()
    //                    }) {
    //                        Image(systemName: "equal.square.fill").padding()
    //                            .font(.title)
    //                            .foregroundColor(Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0))
    //                    }.padding(.top, 4)
    //                    .sheet(isPresented: self.$show_saves_modal) {
    //                        SavesModalView()
    //                     }
                       Spacer()
                           Button(action: {
                               self.show_settings_modal = true
                               self.modal.impactOccurred()
                           }) {
                               Image(systemName: "square.grid.2x2.fill").padding()
                                   .font(.title)
                                   .foregroundColor(Color("teal"))
                           }.padding(.top, 4)
                           .sheet(isPresented: self.$show_settings_modal) {
                            SettingsModalView()
                             }
                    }
                }
                .gesture(
                    DragGesture()
                      .onEnded {
                        if $0.translation.width < -100 {
                          self.selected = min(1, self.selected + 1)
                          self.swipe.impactOccurred()
                        } else if $0.translation.width > 100 {
                          self.selected = max(0, self.selected - 1)
                          self.swipe.impactOccurred()
                        }
                    }
                )
            }
            if device == .mac {
                GeometryReader { geo in
                    PageControl(current: self.selected)
                      .position(x: geo.size.width/2, y: geo.size.height)
                     VStack {
                        TopBar(selected: self.$selected).padding(.top, 16)
                         
                             if self.selected == 0 {
                                 PxToEm()
                             }
                             else {
                                 EmToPx()
                            }
                     }
                }
            }
        }
    }
}


struct PageControl : UIViewRepresentable {

  var current = 0

  func makeUIView(context: UIViewRepresentableContext<PageControl>) -> UIPageControl {
    let page = UIPageControl()
    page.numberOfPages = 2
    page.currentPageIndicatorTintColor = .clear
    page.pageIndicatorTintColor = .clear
    return page
  }

  func updateUIView(_ uiView: UIPageControl, context: UIViewRepresentableContext<PageControl>) {
    uiView.currentPage = current
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
