//
//  HandoverTextField.swift
//  Handover (iOS)
//
//  Created by Karl Koch on 29/06/2021.
//

import SwiftUI

struct HandoverTextField: TextFieldStyle {
    var device = UIDevice.current.userInterfaceIdiom
    @Binding var focused: Bool
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical, 2)
            .padding(.horizontal, 10)
        .background(
            RoundedRectangle(cornerRadius: device == .mac ? 6 : 10, style: .continuous)
                .stroke(focused ? Color("teal") : Color("grey"), lineWidth: device == .mac ? 2.5 : 3)
        )
    }
}
