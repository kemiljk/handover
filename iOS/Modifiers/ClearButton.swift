//
//  ClearButton.swift
//  Px ›› Em
//
//  Created by Karl Koch on 13/10/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct ClearButton: ViewModifier {
    @Binding var text: String
    var device = UIDevice.current.userInterfaceIdiom

    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: device == .phone || device == .pad ? "delete.left" : "xmark.circle.fill" )
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                }
                .padding(.trailing, 12)
            }
        }
    }
}
