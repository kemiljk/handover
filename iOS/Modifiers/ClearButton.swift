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

    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "delete.left")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                }
                .padding(.trailing, 12)
            }
        }
    }
}
