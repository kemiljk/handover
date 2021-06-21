//
//  PxToTw.swift
//  Handover (iOS)
//
//  Created by Karl Koch on 15/06/2021.
//

import SwiftUI
import WidgetKit

struct PerfectRadius: View {
    @ObservedObject var pxResults: PXResults
    @ObservedObject var emResults: EMResults
    @ObservedObject var lhResults: LHResults
    @ObservedObject var twResults: TWResults
    @ObservedObject var prResults: PRResults
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        if device == .phone {
            NavigationView {
                PerfectRadiusView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
            }
        } else {
            PerfectRadiusView(pxResults: self.pxResults, emResults: self.emResults, lhResults: self.lhResults, twResults: self.twResults, prResults: self.prResults)
        }
    }
}

struct PerfectRadiusView: View {
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.handover")) var resultData: Data = Data()
    @AppStorage("innerRadiusResult", store: UserDefaults(suiteName: "group.com.kejk.handover")) var innerRadiusResultData: String = ""
    @AppStorage("outerRadiusResult", store: UserDefaults(suiteName: "group.com.kejk.handover")) var outerRadiusResultData: String = ""
    @AppStorage("paddingResult", store: UserDefaults(suiteName: "group.com.kejk.handover")) var paddingResultData: String = "16px"
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    @State var show_toast: Bool = false
    
    @State private var outerRadiusEmpty = ""
    @State private var innerRadiusEmpty = ""
    @State private var paddingValueEmpty = ""
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var pxResults: PXResults
    @ObservedObject var emResults: EMResults
    @ObservedObject var lhResults: LHResults
    @ObservedObject var twResults: TWResults
    @ObservedObject var prResults: PRResults
    
    @State private var show_settings_modal: Bool = false
    @State private var show_saves_modal: Bool = false
    @State private var set_outer_radius: Bool = false
    
    func perfectOuterRadius(innerRadius: CGFloat, padding: CGFloat) -> CGFloat {
        let prOuterValue = innerRadius + padding
        return prOuterValue
    }
    
    func perfectInnerRadius(outerRadius: CGFloat, padding: CGFloat) -> CGFloat {
        let prInnerValue = outerRadius - padding
        return prInnerValue
    }
    
    func saveInnerRadius(innerRadiusResult: String, paddingResult: String, calcResult: String) {
        guard let calculation = try? JSONEncoder().encode(calcResult) else { return }
        self.resultData = calculation
        self.innerRadiusResultData = innerRadiusResult
        self.paddingResultData = paddingResult
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func saveOuterRadius(outerRadiusResult: String, paddingResult: String, calcResult: String) {
        guard let calculation = try? JSONEncoder().encode(calcResult) else { return }
        self.resultData = calculation
        self.outerRadiusResultData = outerRadiusResult
        self.paddingResultData = paddingResult
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
                    .navigationBarTitle("Perfect››radius")
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
                .navigationBarTitle("Perfect››radius")
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
                ZStack {
                    RoundedRectangle(cornerRadius: set_outer_radius == false ? perfectOuterRadius(innerRadius: CGFloat((innerRadiusEmpty as NSString).doubleValue), padding: CGFloat((paddingValueEmpty as NSString).doubleValue)) : CGFloat((outerRadiusEmpty as NSString).doubleValue))
                        .foregroundColor(set_outer_radius == true ? Color("orange-darker") : Color("orange"))
                        .padding(.horizontal, 20)
                    RoundedRectangle(cornerRadius: set_outer_radius == false ? CGFloat((innerRadiusEmpty as NSString).doubleValue) : perfectInnerRadius(outerRadius: CGFloat((outerRadiusEmpty as NSString).doubleValue), padding: CGFloat((paddingValueEmpty as NSString).doubleValue)))
                        .foregroundColor(set_outer_radius == false ? Color("orange-darker") : Color("orange"))
                        .padding(.horizontal, 20 + CGFloat((paddingValueEmpty as NSString).doubleValue))
                        .padding(.vertical,  CGFloat((paddingValueEmpty as NSString).doubleValue))
                    VStack {
                        Text(set_outer_radius == false ? "OUTER RADIUS" : "INNER RADIUS")
                            .foregroundColor(.white)
                            .font(.caption)
                        Text("\(String(format: "%.0f", (set_outer_radius == false ? perfectOuterRadius(innerRadius: CGFloat((innerRadiusEmpty as NSString).doubleValue), padding: CGFloat((paddingValueEmpty as NSString).doubleValue)) : perfectInnerRadius(outerRadius: CGFloat((outerRadiusEmpty as NSString).doubleValue), padding: CGFloat((paddingValueEmpty as NSString).doubleValue)))))")
                            .foregroundColor(.white)
                            .font(.title).bold()
                    }
                }
                .padding(.bottom, 8)
                HStack {
                    Button {
                        set_outer_radius.toggle()
                    } label: {
                        Label(set_outer_radius == false ? "Set outer radius" : "Set inner radius", systemImage: set_outer_radius == false ? "rectangle" : "rectangle.fill")
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
            })
            VStack (alignment: .leading) {
                Text(set_outer_radius == false ? "Inner radius" : "Outer radius").font(.headline)
                if set_outer_radius == false {
                TextField("16", text: $innerRadiusEmpty).modifier(ClearButton(text: $innerRadiusEmpty))
                    .font(.system(device == .mac ? .body : .title, design: .monospaced))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay(RoundedRectangle(cornerRadius: device == .mac ? 6 : 8).stroke(Color("orange"), lineWidth: device == .mac ? 2.5 : 3))
                    .keyboardType(.decimalPad)
                } else if set_outer_radius == true {
                    TextField("16", text: $outerRadiusEmpty).modifier(ClearButton(text: $outerRadiusEmpty))
                        .font(.system(device == .mac ? .body : .title, design: .monospaced))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(RoundedRectangle(cornerRadius: device == .mac ? 6 : 8).stroke(Color("orange"), lineWidth: device == .mac ? 2.5 : 3))
                        .keyboardType(.decimalPad)
                }
            }.padding(20)
            VStack (alignment: .leading) {
                HStack {
                    VStack (alignment: .leading) {
                        Text("Padding").font(.headline)
                        TextField("16", text: $paddingValueEmpty).modifier(ClearButton(text: $paddingValueEmpty))
                            .font(.system(device == .mac ? .body : .title, design: .monospaced))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(RoundedRectangle(cornerRadius: device == .mac ? 6 : 8).stroke(Color("teal"), lineWidth: device == .mac ? 2.5 : 3))
                            .keyboardType(.decimalPad)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 6)
                }
            }
            VStack (alignment: .center) {
                VStack {
                    Button {
                        if set_outer_radius == false {
                            saveInnerRadius(innerRadiusResult: innerRadiusEmpty, paddingResult: paddingValueEmpty, calcResult: "\(perfectOuterRadius(innerRadius: CGFloat((innerRadiusEmpty as NSString).doubleValue), padding: CGFloat((paddingValueEmpty as NSString).doubleValue)))")
                             let item = ResultItem(pxResult: "", emResult: "", lhResult: "", twResult: "", prResult: "An inner radius of \(innerRadiusEmpty) with a padding value of \(paddingValueEmpty) makes an outer radius of \(String(format: "%.0f", (perfectOuterRadius(innerRadius: CGFloat((innerRadiusEmpty as NSString).doubleValue), padding: CGFloat((paddingValueEmpty as NSString).doubleValue)))))")
                            self.prResults.items.insert(item, at: 0)
                            self.hideKeyboard()
                            print(item)
                            if device == .phone {
                                save.notificationOccurred(.success)
                            }
                            self.show_toast = true
                        } else if set_outer_radius == true {
                            saveOuterRadius(outerRadiusResult: outerRadiusEmpty, paddingResult: paddingValueEmpty, calcResult: "\(perfectInnerRadius(outerRadius: CGFloat((outerRadiusEmpty as NSString).doubleValue), padding: CGFloat((paddingValueEmpty as NSString).doubleValue)))")
                             let item = ResultItem(pxResult: "", emResult: "", lhResult: "", twResult: "", prResult: "An outer radius of \(outerRadiusEmpty) with a padding value of \(paddingValueEmpty) makes an inner radius of \(String(format: "%.0f", (perfectInnerRadius(outerRadius: CGFloat((outerRadiusEmpty as NSString).doubleValue), padding: CGFloat((paddingValueEmpty as NSString).doubleValue)))))")
                            self.prResults.items.insert(item, at: 0)
                            self.hideKeyboard()
                            print(item)
                            if device == .phone {
                                save.notificationOccurred(.success)
                            }
                            self.show_toast = true
                        }
                        resetDefaults()
                    } label: {
                        Text("Save result")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                    }
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
                            //                            save(scaleResult: "", baselineResult: "\(Int(baseTextEmpty) ?? 16)", calcResult: "\(Int(pixelTextEmpty) ?? 16)px is {class}-\(String(format: "%.0f", pxToTws(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16)))")
                            //                            let item = ResultItem(pxResult: "", emResult: "", lhResult: "", twResult: "\(Int(pixelTextEmpty) ?? 16)px is {class}-\(String(format: "%.0f", pxToTws(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16))) with a baseline of \(Int(baseTextEmpty) ?? 16)px")
                            //                            self.prResults.items.insert(item, at: 0)
                            //                            print(item)
                            //                            self.show_toast = true
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
