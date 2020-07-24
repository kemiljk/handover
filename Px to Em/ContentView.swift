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

struct ContentView: View {
    @State var selected = 0
    let swipe = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
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
    }
}

struct TopBar : View {
    @Binding var selected : Int
    let switcher = UIImpactFeedbackGenerator(style: .medium)
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Button(action: {
                self.selected = 0
                self.switcher.impactOccurred()
            })
            {
            Text("Px").bold()
                .frame(width: 24, height: 16)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(self.selected == 0 ? Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0) : Color.clear)
                .clipShape(Capsule())
                .foregroundColor(self.selected == 0 ? Color.black : Color.primary)
                
            }
            
            Button(action: {
                self.selected = 1
                self.switcher.impactOccurred()
            })
            {
            Text("Em").bold()
            .frame(width: 24, height: 16)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(self.selected == 1 ? Color(red: 1.00, green: 0.60, blue: 0.00, opacity: 1.0) : Color.clear)
            .clipShape(Capsule())
            }
            .foregroundColor(self.selected == 1 ? Color.black : Color.primary)
        }.padding(4)
        .background(Color("grey"))
        .clipShape(Capsule())
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
