//
//  SaveStateWidget.swift
//  SaveStateWidget
//
//  Created by Karl Koch on 05/08/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import WidgetKit
import SwiftUI

let pxOrange = Color(red: 1.00, green: 0.60, blue: 0.00, opacity: 1.0)
let pxTeal = Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0)

struct SimpleEntry: TimelineEntry {
    let date = Date()

    public let calculation: String
}

struct Provider: TimelineProvider {
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.px-to-em"))
    var resultData: Data = Data()
    
    public func snapshot(with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        guard let calculation = try? JSONDecoder().decode(String.self, from: resultData) else { return }
        let entry = SimpleEntry(calculation: calculation)
        completion(entry)
    }

    public func timeline(with context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        guard let calculation = try? JSONDecoder().decode(String.self, from: resultData) else { return }
        let entry = SimpleEntry(calculation: calculation)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}


struct PlaceholderView : View {
    var body: some View {
        Text("16px is 1.000em")
    }
}

struct SavedStateWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack (alignment: .leading) {
            Text("Recent result").font(.system(.title2, design: .rounded)).bold()
                .foregroundColor(pxTeal)
            Spacer()
            Text("\(entry.calculation)")
                .font(.system(.body, design: .monospaced))
            Spacer()
        }.padding()
    }
}

@main
struct SavedStateWidget: Widget {
    private let kind: String = "SavedStateWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SavedStateWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Saved calculation")
        .description("Your last saved calculation.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
