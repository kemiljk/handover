//
//  PxToTw.swift
//  Handover (iOS)
//
//  Created by Karl Koch on 15/06/2021.
//

import SwiftUI
import WidgetKit

struct PxToTw: View {
    @ObservedObject var pxResults: PXResults
    @ObservedObject var emResults: EMResults
    @ObservedObject var lhResults: LHResults
    @ObservedObject var twResults: TWResults
    @ObservedObject var prResults: PRResults
    
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        if device == .phone {
            NavigationView {
                PxToTwView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
            }
        } else {
            PxToTwView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
        }
    }
}

struct PxToTwView: View {
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.handover")) var resultData: String = ""
    @AppStorage("scaleResult", store: UserDefaults(suiteName: "group.com.kejk.handover")) var scaleResultData: String = ""
    @AppStorage("baselineResult", store: UserDefaults(suiteName: "group.com.kejk.handover")) var baselineResultData: String = ""
    
    let classNameItems: [ClassNameItem] = [
        ClassNameItem(className: "p", classNameTitle: "Padding"),
        ClassNameItem(className: "pt", classNameTitle: "Padding top"),
        ClassNameItem(className: "pr", classNameTitle: "Padding right"),
        ClassNameItem(className: "pb", classNameTitle: "Padding bottom"),
        ClassNameItem(className: "pl", classNameTitle: "Padding left"),
        ClassNameItem(className: "m", classNameTitle: "Margin"),
        ClassNameItem(className: "mt", classNameTitle: "Margin top"),
        ClassNameItem(className: "mr", classNameTitle: "Margin right"),
        ClassNameItem(className: "mb", classNameTitle: "Margin bottom"),
        ClassNameItem(className: "ml", classNameTitle: "Margin left"),
        ClassNameItem(className: "w", classNameTitle: "Width"),
        ClassNameItem(className: "h", classNameTitle: "Height"),
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
    @State private var classNameEmpty = "{class}"
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var pxResults: PXResults
    @ObservedObject var emResults: EMResults
    @ObservedObject var lhResults: LHResults
    @ObservedObject var twResults: TWResults
    @ObservedObject var prResults: PRResults
    
    @State private var show_settings_modal: Bool = false
    @State private var show_saves_modal: Bool = false
    
    func pxToTws(baseInt: Double, pixelInt: Double) -> Double {
        let twValue = (pixelInt / baseInt) * 4
        return twValue
    }
    
    func save(scaleResult: String, baselineResult: String, calcResult: String) {
        self.resultData = calcResult
        self.scaleResultData = scaleResult
        self.baselineResultData = baselineResult
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    let modal = UIImpactFeedbackGenerator(style: .medium)
    let menu = UIImpactFeedbackGenerator(style: .soft)
    let menuParent = UIImpactFeedbackGenerator(style: .light)
    let save = UINotificationFeedbackGenerator()
    var device = UIDevice.current.userInterfaceIdiom
    @State private var hovering = false
    @State private var baseline = false
    @State private var pixels = false
    
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
        .navigationBarTitle("Px››Tailwind")
        .navigationBarItems(
            leading:
                    Button(action: {
                        self.show_saves_modal = true
                        self.modal.impactOccurred()
                    }) {
                        Image(systemName: "bookmark.circle")
                            .symbolRenderingMode(.hierarchical)
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
                            .symbolRenderingMode(.hierarchical)
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
    .navigationBarTitle("Px››Tailwind")
    .navigationBarItems(
        trailing:
            HStack (spacing: 16) {
                Button(action: {
                    self.show_saves_modal = true
                }) {
                    Image(systemName: "bookmark.circle")
                        .symbolRenderingMode(.hierarchical)
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
                        .symbolRenderingMode(.hierarchical)
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
                Text("\(Int(pixelTextEmpty) ?? 16)px is \(classNameEmpty)-\(String(format: "%.0f", pxToTws(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16)))")
                    .font(.system(.largeTitle, design: .monospaced))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 10)
                Spacer()
            })
            VStack (alignment: .center) {
                Menu {
                    VStack  {
                        HStack {
                            Text("Select class name")
                        }
                        HStack {
                            ForEach(classNameItems) { classNameItem in
                                Button(action: {
                                    self.classNameEmpty = classNameItem.className
                                    print(classNameEmpty)
                                    if device == .phone {
                                        self.menu.impactOccurred()
                                    }
                                }, label: {
                                    Text(classNameItem.classNameTitle).font(.body).bold()
                                    Spacer()
                                    Image(systemName: "text.insert")
                                })
                            }
                        }
                    }
                } label: {
                    if device == .phone || device == .pad {
                        HStack {
                            Label(classNameEmpty.isEmpty ? "Insert class name" : "Update class name", systemImage: "plus.circle")
                                .foregroundColor(Color("teal")).font(.headline)
                        }
                        .padding(.leading, 20)
                    } else if device == .mac {
                    Text("Insert class name")
                    }
                }
                .onTapGesture {
                    if device == .phone {
                        self.menuParent.impactOccurred()
                    }
                }
            }
            .frame(width: device == .pad ? UIScreen.main.bounds.width / 4 : nil)
            VStack (alignment: .leading) {
                Text("Baseline pixel value").font(.headline)
                TextField("16", text: $baseTextEmpty, onEditingChanged: { edit in
                    self.baseline = edit
                })
                    .modifier(ClearButton(text: $baseTextEmpty))
                    .font(.system(device == .mac ? .body : .title, design: .monospaced))
                    .textFieldStyle(HandoverTextField(focused: $baseline))
                    .keyboardType(.decimalPad)
            }.padding(20)
            VStack (alignment: .leading) {
                HStack {
                    VStack (alignment: .leading) {
                        Text("Pixels").font(.headline)
                        TextField("16", text: $pixelTextEmpty, onEditingChanged: { edit in
                            self.pixels = edit
                        })
                            .modifier(ClearButton(text: $pixelTextEmpty))
                            .font(.system(device == .mac ? .body : .title, design: .monospaced))
                            .textFieldStyle(HandoverTextField(focused: $pixels))
                            .keyboardType(.decimalPad)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
                }
            }
            VStack (alignment: .center) {
                VStack {
                    Button {
                        save(scaleResult: "", baselineResult: "\(Int(baseTextEmpty) ?? 16)", calcResult: "\(Int(pixelTextEmpty) ?? 16)px is \(classNameEmpty)-\(String(format: "%.0f", pxToTws(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16)))")
                        let item = ResultItem(pxResult: "", emResult: "", lhResult: "", twResult: "\(Int(pixelTextEmpty) ?? 16)px is \(classNameEmpty)-\(String(format: "%.0f", pxToTws(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16))) with a baseline of \(Int(baseTextEmpty) ?? 16)px", prResult: "")
                        self.twResults.items.insert(item, at: 0)
                        self.hideKeyboard()
                        print(item)
                        if device == .phone {
                            save.notificationOccurred(.success)
                        }
                        self.show_toast = true
                        resetDefaults()
                    } label: {
                        Text("Save result")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 32)
                    .frame(width: device == .phone ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width / 4)
                    .background(Color("orange"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .hoverEffect(.highlight)
                }
                if device == .mac {
                    VStack {
                        Button(action: {
                            save(scaleResult: "", baselineResult: "\(Int(baseTextEmpty) ?? 16)", calcResult: "\(Int(pixelTextEmpty) ?? 16)px is {class}-\(String(format: "%.0f", pxToTws(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16)))")
                            let item = ResultItem(pxResult: "", emResult: "", lhResult: "", twResult: "\(Int(pixelTextEmpty) ?? 16)px is {class}-\(String(format: "%.0f", pxToTws(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16))) with a baseline of \(Int(baseTextEmpty) ?? 16)px", prResult: "")
                            self.twResults.items.insert(item, at: 0)
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
