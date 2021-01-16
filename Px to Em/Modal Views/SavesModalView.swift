//
//  SavesModalView.swift
//  Px ›› Em
//
//  Created by Karl Koch on 05/08/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct SavesModalView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var pxResults: PXResults
    @ObservedObject var emResults: EMResults
    @ObservedObject var lhResults: LHResults
    
    var device = UIDevice.current.userInterfaceIdiom
    @State private var showingAddResult = false
    
    var body: some View {
            NavigationView {
                if pxResults.items.count <= 0 && emResults.items.count <= 0 && lhResults.items.count <= 0 {
                    VStack {
                        Text("Your saved conversions will appear here")
                            .font(.system(.body))
                            .foregroundColor(.secondary)
                            .padding()
                        Spacer()
                        .navigationBarTitle("Saved conversions").padding(.top, 8)
                        .padding(.bottom, 8)
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
                    }
                } else {
                    List {
                        Section (header: Text("PIXELS")) {
                            ForEach(pxResults.items) { item in
                                Text(item.pxResult)
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.vertical, 8)
                                }
                            .onDelete(perform: removePxItems)
                            }
                        Section (header: Text("REM")) {
                            ForEach(emResults.items) { item in
                                Text(item.emResult)
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.vertical, 8)
                                }
                            .onDelete(perform: removeEmItems)
                            }
                        Section (header: Text("LINE-HEIGHT")) {
                            ForEach(lhResults.items) { item in
                                Text(item.lhResult)
                                    .font(.system(.body, design: .monospaced))
                                    .padding(.vertical, 8)
                                }
                            .onDelete(perform: removeLhItems)
                            }
                    }
                    .listStyle(InsetGroupedListStyle())
                    .ignoresSafeArea()
                    .navigationBarTitle("Saved conversions")
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
                    }
                }
            }
    
    func removePxItems(at offsets: IndexSet) {
        pxResults.items.remove(atOffsets: offsets)
    }
    
    func removeEmItems(at offsets: IndexSet) {
        emResults.items.remove(atOffsets: offsets)
    }
    
    func removeLhItems(at offsets: IndexSet) {
        lhResults.items.remove(atOffsets: offsets)
    }
}
