//
//  AppIconView.swift
//  Px ›› Em
//
//  Created by Karl Koch on 20/09/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct AppIconView: View {
    let success = UIImpactFeedbackGenerator(style: .medium)
    var device = UIDevice.current.userInterfaceIdiom
    @Environment(\.presentationMode) private var presentationMode
    
    
    
    let icons: [IconItem] = [
        IconItem(name: "AppIcon", image: "classicIcon"),
        IconItem(name: "shadow", image: "shadowIcon"),
        IconItem(name: "innerShadow", image: "innerShadowIcon"),
        IconItem(name: "neuomorphic", image: "neuomorphicIcon"),
        IconItem(name: "orangeMono", image: "orangeMonoIcon"),
        IconItem(name: "orangeGradient", image: "orangeGradientIcon"),
        IconItem(name: "orangeInnerShadow", image: "orangeInnerShadowIcon"),
        IconItem(name: "orangeNeuo", image: "orangeNeuoIcon"),
        IconItem(name: "black", image: "blackIcon"),
        IconItem(name: "blackSmall", image: "blackSmallIcon"),
        IconItem(name: "white", image: "whiteIcon", hasBorder: true),
        IconItem(name: "whiteSmall", image: "whiteSmallIcon", hasBorder: true),
        IconItem(name: "rainbowGradient", image: "rainbowGradientIcon"),
        IconItem(name: "rainbowGradientInverse", image: "rainbowGradientInverseIcon"),
        IconItem(name: "squareShape", image: "squareShapeIcon"),
        IconItem(name: "squareShapeOrange", image: "squareShapeOrangeIcon")
    ]
    
    var gridItems: [GridItem] = [GridItem(), GridItem(), GridItem(), GridItem()]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: gridItems, alignment: .center, spacing: device == .phone ? (UIScreen.screenHeight / 32) : 48) {
                ForEach(icons) { icon in
                    Button(action: {
                        UIApplication.shared.setAlternateIconName(icon.name)
                        self.success.impactOccurred()
                    }){
                        Image(icon.image)
                            .renderingMode(.original)
                            .cornerRadius(15)
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color("grey"), lineWidth: icon.hasBorder == true ? 1 : 0))
                    }
                    .padding(8)
                    .contentShape(RoundedRectangle(cornerRadius: 23, style: .continuous))
                    .hoverEffect(.highlight)
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("Change app icon")
    }
}
