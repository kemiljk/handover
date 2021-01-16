//
//  LineHeight.swift
//  Px ›› Em
//
//  Created by Karl Koch on 12/10/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI
import WidgetKit

struct RatioItem: Identifiable {
    var id = UUID()
    var scaleNumber: String
    var scaleItem: String
}

struct LineHeight: View {
    @ObservedObject var pxResults: PXResults
    @ObservedObject var emResults: EMResults
    @ObservedObject var lhResults: LHResults
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        
        if device == .phone {
            NavigationView {
                LineHeightContent(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults)
            }
        } else {
            LineHeightContent(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults)
        }
    }
}

struct LineHeightContent: View {
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.px-to-em"))
    var resultData: Data = Data()
    
    let ratioItems: [RatioItem] = [
        RatioItem(scaleNumber: "1.000", scaleItem: ": Browser default"),
        RatioItem(scaleNumber: "1.067", scaleItem: ": Minor second"),
        RatioItem(scaleNumber: "1.125", scaleItem: ": Major second"),
        RatioItem(scaleNumber: "1.200", scaleItem: ": Minor third"),
        RatioItem(scaleNumber: "1.250", scaleItem: ": Minor third"),
        RatioItem(scaleNumber: "1.333", scaleItem: ": Perfect fourth"),
        RatioItem(scaleNumber: "1.414", scaleItem: ": Augmented fourth"),
        RatioItem(scaleNumber: "1.500", scaleItem: ": Perfect fifth"),
        RatioItem(scaleNumber: "1.618", scaleItem: ": Golden ratio"),
    ]
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    @State private var fontSizeEmpty = "16"
    @State private var ratioTextEmpty = ""
    @State private var lineHeightEmpty = ""

    @State var show_toast: Bool = false
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var pxResults: PXResults
    @ObservedObject var emResults: EMResults
    @ObservedObject var lhResults: LHResults
    
    @State private var show_settings_modal: Bool = false
    @State private var show_saves_modal: Bool = false
    
    
    func idealLineHeight(fontSizeInt: Double, ratioInt: Double) -> Double {
        let lineheight = fontSizeInt * ratioInt
        return lineheight
    }
    
    func pxToEms(baseInt: Double, pixelInt: Double, scaleInt: Double) -> Double {
        let emValue = (pixelInt / baseInt) * scaleInt
        return emValue
    }
    
    func save(_ calcResult: String) {
        guard let calculation = try? JSONEncoder().encode(calcResult) else { return }
        self.resultData = calculation
        print("\(String(format: "%.0f", (Double(fontSizeEmpty) ?? 16)))px with \(String(format: "%.0f", idealLineHeight(fontSizeInt: Double(fontSizeEmpty) ?? 16, ratioInt: Double(ratioTextEmpty) ?? 1)))px/\(String(format: "%.3f", pxToEms(baseInt: Double(16), pixelInt: Double(fontSizeEmpty) ?? 16, scaleInt: Double(ratioTextEmpty) ?? 1)))rem line-height at a ratio of \(String(format: "%.3f", (Double(ratioTextEmpty) ?? 1)))")
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    let modal = UIImpactFeedbackGenerator(style: .medium)
    let menu = UIImpactFeedbackGenerator(style: .soft)
    let menuParent = UIImpactFeedbackGenerator(style: .light)
    let save = UINotificationFeedbackGenerator()
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        if device == .phone {
            content
            .navigationBarTitle("Line››height")
            .navigationBarItems(
                leading:
                        Button(action: {
                            self.show_saves_modal = true
                            self.modal.impactOccurred()
                        }) {
                            Image(systemName: "bookmark.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(Color("teal"))
                        }
                        .sheet(isPresented: self.$show_saves_modal) {
                            SavesModalView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults)
                        },
                trailing:
                        Button(action: {
                            self.show_settings_modal = true
                            self.modal.impactOccurred()
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: 24))
                                .foregroundColor(Color("teal"))
                        }
                        .sheet(isPresented: self.$show_settings_modal) {
                            SettingsModalView()
                        }
            )
            .popup(isPresented: $show_toast, type: .floater(verticalPadding: device == .phone ? 60 : 40), position: .top, autohideIn: 2) {
                HStack {
                    Image(systemName: "checkmark").padding(.trailing, 4)
                        .font(.system(size: 20, weight: .semibold))
                    Text("Saved").bold()
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 32)
                .background(Color("lightGrey"))
                .clipShape(Capsule())
            }
        }
        else {
        content
        .navigationBarTitle("Line››height")
        .navigationBarItems(
            trailing:
                HStack (spacing: 16) {
                    Button(action: {
                        self.show_saves_modal = true
                        self.modal.impactOccurred()
                    }) {
                        Image(systemName: "bookmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color("teal"))
                    }
                    .padding(8)
                    .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .hoverEffect(.highlight)
                    .sheet(isPresented: self.$show_saves_modal) {
                        SavesModalView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults)
                    }
                    Button(action: {
                        self.show_settings_modal = true
                        self.modal.impactOccurred()
                    }) {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color("teal"))
                    }
                    .padding(8)
                    .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .hoverEffect(.highlight)
                    .sheet(isPresented: self.$show_settings_modal) {
                        SettingsModalView()
                    }
                }
        )
        .popup(isPresented: $show_toast, type: .floater(verticalPadding: device == .phone ? 60 : 40), position: .top, autohideIn: 2) {
            HStack {
                Image(systemName: "checkmark").padding(.trailing, 4)
                    .font(.system(size: 20, weight: .semibold))
                Text("Saved").bold()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 32)
            .background(Color("lightGrey"))
            .clipShape(Capsule())
        }
    }
}
    
    var content: some View {
        VStack {
            VStack (alignment: .center, content: {
                Spacer()
                Text("\(String(format: "%.0f", (Double(fontSizeEmpty) ?? 16)))px with \(String(format: "%.0f", idealLineHeight(fontSizeInt: Double(fontSizeEmpty) ?? 16, ratioInt: Double(ratioTextEmpty) ?? 1)))px/\(String(format: "%.3f", pxToEms(baseInt: Double(16), pixelInt: Double(fontSizeEmpty) ?? 16, scaleInt: Double(ratioTextEmpty) ?? 1)))rem line-height")
                    .font(.system(.largeTitle, design: .monospaced))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 10)
                Spacer()
                let fontSizeDynamic: CGFloat = CGFloat((fontSizeEmpty as NSString).doubleValue)
                let lineHeightDynamic: CGFloat = CGFloat((ratioTextEmpty as NSString).doubleValue)
                Text(device == .phone ? "This is how your line-height actually looks in practice. See the spacing between the lines change as you update values." : "This is how your line-height actually looks in practice. See the spacing between the lines change as you update values. On iPad there's much more to play with so this whole paragraph needs to be a lot longer.")
                    .font(.system(size: fontSizeDynamic))
                    .lineSpacing(fontSizeDynamic * lineHeightDynamic - fontSizeDynamic)
                    .padding(.horizontal, 20)
                Spacer()
            })
            VStack (alignment: .leading) {
                Text("Baseline font size").font(.headline)
                TextField("16", text: $fontSizeEmpty).modifier(ClearButton(text: $fontSizeEmpty))
                    .font(.system(.title, design: .monospaced))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("orange"), lineWidth: 3))
                    .keyboardType(.decimalPad)
            }
            .padding(20)
            VStack (alignment: .leading) {
                HStack {
                    Text("Ratio").font(.headline)
                    Menu {
                        VStack {
                            HStack {
                                Text("Insert a ratio")
                            }
                            HStack {
                                ForEach(ratioItems) { ratioItem in
                                    Button(action: {
                                        self.ratioTextEmpty = ratioItem.scaleNumber
                                        print(ratioTextEmpty)
                                        if device == .phone {
                                            self.menu.impactOccurred()
                                        }
                                    }, label: {
                                        Text(ratioItem.scaleNumber + "" + ratioItem.scaleItem).font(.system(.body, design: .monospaced)).bold()
                                        Spacer()
                                        Image(systemName: "text.insert")
                                    })
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding(.leading, 16).padding(.trailing, 16)
                            .foregroundColor(Color("teal")) .font(.system(size: 20, weight: .semibold))
                    }
                    .onTapGesture {
                        if device == .phone {
                            self.menuParent.impactOccurred()
                        }
                    }
                }
                TextField("1.000", text: $ratioTextEmpty).modifier(ClearButton(text: $ratioTextEmpty))
                    .font(.system(.title, design: .monospaced))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color("teal"), lineWidth: 3))
                    .keyboardType(.decimalPad)
            }.padding(.horizontal, 20)
            VStack (alignment: .center) {
                VStack {
                    Button(action: {
                        save("\(String(format: "%.0f", (Double(fontSizeEmpty) ?? 16)))px with \(String(format: "%.0f", idealLineHeight(fontSizeInt: Double(fontSizeEmpty) ?? 16, ratioInt: Double(ratioTextEmpty) ?? 1)))px/\(String(format: "%.3f", pxToEms(baseInt: Double(16), pixelInt: Double(fontSizeEmpty) ?? 16, scaleInt: Double(ratioTextEmpty) ?? 1)))rem line-height at a ratio of \(String(format: "%.3f", (Double(ratioTextEmpty) ?? 1)))")
                        let item = ResultItem(pxResult: "", emResult: "", lhResult: "\(String(format: "%.0f", (Double(fontSizeEmpty) ?? 16)))px with \(String(format: "%.0f", idealLineHeight(fontSizeInt: Double(fontSizeEmpty) ?? 16, ratioInt: Double(ratioTextEmpty) ?? 1)))px/\(String(format: "%.3f", pxToEms(baseInt: Double(16), pixelInt: Double(fontSizeEmpty) ?? 16, scaleInt: Double(ratioTextEmpty) ?? 1)))rem line-height at a ratio of \(String(format: "%.3f", (Double(ratioTextEmpty) ?? 1)))")
                        self.lhResults.items.insert(item, at: 0)
                        self.hideKeyboard()
                        print(item)
                        if device == .phone {
                            save.notificationOccurred(.success)
                        }
                        self.show_toast = true
                        resetDefaults()
                    }, label: {
                        Text("Save result")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                    })
                    .padding(.vertical, 16)
                    .padding(.horizontal, 48)
                    .background(Color("teal"))
                    .clipShape(Capsule())
                    .contentShape(Capsule(style: .continuous))
                    .hoverEffect(.highlight)
                }
            }.padding().padding(.top, 24).padding(.bottom, 24)
        }
    }
}
