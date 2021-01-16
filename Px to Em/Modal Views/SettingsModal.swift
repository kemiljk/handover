//
//  SettingsModal.swift
//  Px ›› Em
//
//  Created by Karl Koch on 22/07/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct SettingsModalView: View {
    
    let success = UIImpactFeedbackGenerator(style: .medium)
    @Environment(\.presentationMode) private var presentationMode
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
            NavigationView {
                VStack {
                    List {
                        NavigationLink(destination: AppIconView()) {
                            Text("Change app Icon").font(.system(.body))
                       }
                        NavigationLink(destination: RequestView()) {
                            Text("Submit a feature request").font(.system(.body))
                        }
                        NavigationLink(destination: ScalesView()) {
                            Text("Example scales").font(.system(.body))
                       }
//                        NavigationLink(destination: TipJarView()) {
//                            Text("Tip Jar").font(.system(.body))
//                       }
                        NavigationLink(destination: AboutView()) {
                            Text("About").font(.system(.body))
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .ignoresSafeArea()
                    .navigationTitle("Settings")
                        .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(
                        trailing:
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 16, height: 16, alignment: .center)
                                    .padding(4)
                            })
                            .foregroundColor(Color("teal"))
                            .padding(8)
                            .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .hoverEffect(.highlight)
                    )
                    Spacer()
                    VStack {
                        Text("Made with ❤️ and SwiftUI by Karl Koch")
                    }
                    .padding(.vertical, 12)
                }
                Spacer()
            }
            .accentColor(Color("teal"))
        }
    }

struct BaselineDefaultView: View {
    var body: some View {
        Text("Hello World")
    }
}

struct TipJarView: View {
    var body: some View {
        Text("Hello World")
    }
}

struct SettingsModal_Previews: PreviewProvider {
    static var previews: some View {
        SettingsModalView()
    }
}
