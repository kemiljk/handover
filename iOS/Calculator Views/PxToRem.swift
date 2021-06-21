//
//  PxToEm.swift
//  Px ›› Em
//
//  Created by Karl Koch on 21/07/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI
import WidgetKit

struct PxToEm: View {
    @ObservedObject var pxResults: PXResults
    @ObservedObject var emResults: EMResults
    @ObservedObject var lhResults: LHResults
    @ObservedObject var twResults: TWResults
    @ObservedObject var prResults: PRResults
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        if device == .phone {
            NavigationView {
                PxToEmView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
            }
        } else {
            PxToEmView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
        }
    }
}

struct PxToEmView: View {
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.handover")) var resultData: Data = Data()
    @AppStorage("scaleResult", store: UserDefaults(suiteName: "group.com.kejk.handover")) var scaleResultData: String = "1.000"
    @AppStorage("baselineResult", store: UserDefaults(suiteName: "group.com.kejk.handover")) var baselineResultData: String = "16px"
    
    let scaleItems: [ScaleItem] = [
        ScaleItem(scaleNumber: "1.000", scaleItem: ": Browser default"),
        ScaleItem(scaleNumber: "1.067", scaleItem: ": Minor second"),
        ScaleItem(scaleNumber: "1.125", scaleItem: ": Major second"),
        ScaleItem(scaleNumber: "1.200", scaleItem: ": Minor third"),
        ScaleItem(scaleNumber: "1.250", scaleItem: ": Minor third"),
        ScaleItem(scaleNumber: "1.333", scaleItem: ": Perfect fourth"),
        ScaleItem(scaleNumber: "1.414", scaleItem: ": Augmented fourth"),
        ScaleItem(scaleNumber: "1.500", scaleItem: ": Perfect fifth"),
        ScaleItem(scaleNumber: "1.618", scaleItem: ": Golden ratio"),
    ]
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    @State var show_toast: Bool = false
    
    @State private var baseTextEmpty = ""
    @State private var pixelTextEmpty = ""
    @State private var scaleTextEmpty = ""
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var pxResults: PXResults
    @ObservedObject var emResults: EMResults
    @ObservedObject var lhResults: LHResults
    @ObservedObject var twResults: TWResults
    @ObservedObject var prResults: PRResults
    
    @State private var show_settings_modal: Bool = false
    @State private var show_saves_modal: Bool = false
    
    func pxToEms(baseInt: Double, pixelInt: Double, scaleInt: Double) -> Double {
        let emValue = (pixelInt / baseInt) * scaleInt
        return emValue
    }
    
    func save(scaleResult: String, baselineResult: String, calcResult: String) {
        guard let calculation = try? JSONEncoder().encode(calcResult) else { return }
        self.resultData = calculation
        self.scaleResultData = scaleResult
        self.baselineResultData = baselineResult
        print(resultData, scaleResultData, baselineResultData)
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    let modal = UIImpactFeedbackGenerator(style: .medium)
    let menu = UIImpactFeedbackGenerator(style: .soft)
    let menuParent = UIImpactFeedbackGenerator(style: .light)
    let save = UINotificationFeedbackGenerator()
    var device = UIDevice.current.userInterfaceIdiom
    @State private var hovering = false
    
    var body: some View {
        if device == .phone {
        content
        .popup(isPresented: $show_toast, type: .floater(verticalPadding: 40), position: .top, autohideIn: 2) {
            HStack {
                Image(systemName: "checkmark").padding(.trailing, 4)
                    .font(.system(size: 20, weight: .semibold))
                Text("Saved").bold()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 32)
            .background(Color("lightGrey"))
            .clipShape(Capsule())
        .navigationBarTitle("Px››Rem")
        .navigationBarItems(
            leading:
                    Button(action: {
                        self.show_saves_modal = true
                        self.modal.impactOccurred()
                    }) {
                        Image(systemName: "bookmark.circle")
                            .font(.system(size: 24))
                            .foregroundColor(Color("teal"))
                    }
                    .sheet(isPresented: self.$show_saves_modal) {
                        SavesModalView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
                    },
            trailing:
                    Button(action: {
                        self.show_settings_modal = true
                        self.modal.impactOccurred()
                    }) {
                        Image(systemName: "gearshape.circle")
                            .font(.system(size: 24))
                            .foregroundColor(Color("teal"))
                    }
                    .sheet(isPresented: self.$show_settings_modal) {
                        SettingsModalView()
                    }
            )
        }
    } else  {
    content
    .popup(isPresented: $show_toast, type: .floater(verticalPadding: 40), position: .top, autohideIn: 2) {
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
    .navigationBarTitle("Px››Rem")
    .navigationBarItems(
        trailing:
            HStack (spacing: 16) {
                Button(action: {
                    self.show_saves_modal = true
                }) {
                    Image(systemName: "bookmark.circle")
                        .font(.system(size: 24))
                        .foregroundColor(Color("teal"))
                }
                .padding(8)
                .contentShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .hoverEffect(.highlight)
                .sheet(isPresented: self.$show_saves_modal) {
                    SavesModalView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
                }
                Button(action: {
                    self.show_settings_modal = true
                }) {
                    Image(systemName: "gearshape.circle")
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
    }
}
    
    var content: some View {
        VStack {
            VStack (alignment: .center, content: {
                Spacer()
                Text("\(Int(pixelTextEmpty) ?? 16)px is \(String(format: "%.2f", pxToEms(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16, scaleInt: Double(scaleTextEmpty) ?? 1)))rem")
                    .font(.system(.largeTitle, design: .monospaced))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 10)
                Spacer()
            })
            VStack (alignment: .leading) {
                Text("Baseline pixel value").font(.headline)
                TextField("16", text: $baseTextEmpty).modifier(ClearButton(text: $baseTextEmpty))
                    .font(.system(device == .mac ? .body : .title, design: .monospaced))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(RoundedRectangle(cornerRadius: device == .mac ? 6 : 8).stroke(Color("orange"), lineWidth: device == .mac ? 2.5 : 3))
                    .keyboardType(.decimalPad)
            }.padding(20)
            VStack (alignment: .leading) {
                HStack {
                    VStack (alignment: .leading) {
                        Text("Pixels").font(.headline)
                        TextField("16", text: $pixelTextEmpty).modifier(ClearButton(text: $pixelTextEmpty))
                            .font(.system(device == .mac ? .body : .title, design: .monospaced))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: device == .mac ? 6 : 8).stroke(Color("teal"), lineWidth: device == .mac ? 2.5 : 3))
                            .keyboardType(.decimalPad)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
                    VStack (alignment: .leading) {
                        HStack {
                            Text("Scale").font(.headline)
                            Spacer()
                            Menu {
                                VStack {
                                    HStack {
                                        Text("Insert a scale")
                                    }
                                    HStack {
                                        ForEach(scaleItems) { scaleItem in
                                            Button(action: {
                                                self.scaleTextEmpty = scaleItem.scaleNumber
                                                print(scaleTextEmpty)
                                                if device == .phone {
                                                    self.menu.impactOccurred()
                                                }
                                            }, label: {
                                                Text(scaleItem.scaleNumber + "" + scaleItem.scaleItem).font(.system(.body, design: .monospaced)).bold()
                                                Spacer()
                                                Image(systemName: "text.insert")
                                            })
                                        }
                                    }
                                }
                            } label: {
                                if device == .phone || device == .pad {
                                Image(systemName: "plus.circle")
                                    .foregroundColor(Color("teal")) .font(.system(size: 20, weight: .semibold))
                                } else if device == .mac {
                                Text("Insert a scale")
                                }
                            }
                            .onTapGesture {
                                if device == .phone {
                                    self.menuParent.impactOccurred()
                                }
                            }
                            
                        }
                        TextField("1.000", text: $scaleTextEmpty).modifier(ClearButton(text: $scaleTextEmpty))
                            .font(.system(device == .mac ? .body : .title, design: .monospaced))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: device == .mac ? 6 : 8).stroke(Color("teal"), lineWidth: device == .mac ? 2.5 : 3))
                            .keyboardType(.decimalPad)
                    }
                    .padding(.horizontal, 20)
                }
            }
            VStack (alignment: .center) {
                VStack {
                    Button(action: {
                        save(scaleResult: "\(String(format: "%.3f", (Double(scaleTextEmpty) ?? 1)))", baselineResult: "\(Int(baseTextEmpty) ?? 16)", calcResult: "\(Int(pixelTextEmpty) ?? 16)px is \(String(format: "%.2f", pxToEms(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16, scaleInt: Double(scaleTextEmpty) ?? 1)))rem")
                        let item = ResultItem(pxResult: "\(Int(pixelTextEmpty) ?? 16)px is \(String(format: "%.2f", pxToEms(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16, scaleInt: Double(scaleTextEmpty) ?? 1)))rem at a scale of \(String(format: "%.3f", (Double(scaleTextEmpty) ?? 1))) with a baseline of \(Int(baseTextEmpty) ?? 16)px", emResult: "", lhResult: "", twResult: "", prResult: "")
                        self.pxResults.items.insert(item, at: 0)
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
                            .font(.system(size: 16, weight: .bold))
                    })
                    .padding(.vertical, 12)
                    .padding(.horizontal, 32)
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .background(Color("teal"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .hoverEffect(.highlight)
                }
                if device == .mac {
                    VStack {
                        Button(action: {
                            save(scaleResult: "\(String(format: "%.3f", (Double(scaleTextEmpty) ?? 1)))", baselineResult: "\(Int(baseTextEmpty) ?? 16)", calcResult: "\(Int(pixelTextEmpty) ?? 16)px is \(String(format: "%.2f", pxToEms(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16, scaleInt: Double(scaleTextEmpty) ?? 1)))rem")
                            let item = ResultItem(pxResult: "\(Int(pixelTextEmpty) ?? 16)px is \(String(format: "%.2f", pxToEms(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16, scaleInt: Double(scaleTextEmpty) ?? 1)))rem at a scale of \(String(format: "%.3f", (Double(scaleTextEmpty) ?? 1))) with a baseline of \(Int(baseTextEmpty) ?? 16)px", emResult: "", lhResult: "", twResult: "", prResult: "")
                            self.pxResults.items.insert(item, at: 0)
                            print(item)
                            self.show_toast = true
                            resetDefaults()
                        }) {
                            Text("Save result")
                                .frame(maxWidth: 100, maxHeight: 24)
                        }
                        .buttonStyle(MacButtonStyle())
                    }
                }
            }
            .padding().padding(.vertical, 24)
        }
    }
}
