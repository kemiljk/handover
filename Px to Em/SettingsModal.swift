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
        VStack {
            if device == .phone {
                Image(systemName: "chevron.compact.down").font(.system(size: 40, weight: .semibold)).padding(.top, 20).foregroundColor(Color.secondary)
            }
            else {
                HStack {
                    Spacer()
                    Button(action: {
                      self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done").bold()
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("teal"))
                    }
                    .padding()
                }
            }
            Spacer()
            NavigationView {
                VStack {
                    List {
                        NavigationLink(destination: AppIconView()) {
                            Text("Change app Icon").font(.system(.body))
                       }
                        NavigationLink(destination: ScalesView()) {
                            Text("Example scales").font(.system(.body))
                        }
//                        NavigationLink(destination: SavesModalView()) {
//                            Text("Recent conversion").font(.system(.body))
//                        }
//                        NavigationLink(destination: BaselineDefaultView()) {
//                            Text("Set default baseline value").font(.system(.body))
//                       }
//                        NavigationLink(destination: TipJarView()) {
//                            Text("Tip Jar").font(.system(.body))
//                       }
                        NavigationLink(destination: AboutView()) {
                            Text("About").font(.system(.body))
                        }
                    }.listStyle(InsetGroupedListStyle()).padding(.top, 8)
                    .navigationBarTitle("Settings")
                }
                Spacer()
            }.accentColor(Color("teal"))
        }
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
