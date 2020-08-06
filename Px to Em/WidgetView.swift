//
//  WidgetView.swift
//  Px to Em
//
//  Created by Karl Koch on 06/08/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

let pxTeal = Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0)

struct WidgetView: View {
    var body: some View {
    VStack (alignment: .leading) {
        Text("Recent result").font(.system(.title2, design: .rounded)).bold()
            .foregroundColor(pxTeal)
        Spacer()
        Text("")
            .font(.system(.body, design: .monospaced))
        Spacer()
    }.padding()
}

struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView()
    }
}
