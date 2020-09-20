//
//  SavesModalView.swift
//  Px ›› Em
//
//  Created by Karl Koch on 05/08/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct Calculation: Codable, Identifiable {
    var id = UUID()
    var resultData: Data = Data()
}


//struct SavesModalView: View {
//    @Environment(\.presentationMode) private var presentationMode
//    var device = UIDevice.current.userInterfaceIdiom
//
////    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.px-to-em"))
//    var resultData: Data = Data()
//
//    func calculationResult() -> String {
//        guard let result = (try? JSONDecoder().decode(String.self, from: resultData)) else { return "Nothing saved" }
//        return result
//    }
//
//    var body: some View {
//            VStack {
//                List {
//                    Text("\(calculationResult())").font(.system(.body, design: .monospaced))
//                    }
//                }.listStyle(InsetGroupedListStyle()).padding(.top, 8)
//            .navigationBarTitle("Recent conversion").padding(.top, 8)
//        Spacer()
//    }
//}

//struct SavesModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavesModalView()
//    }
//}
