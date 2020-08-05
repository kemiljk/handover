//
//  SaveStateWidget.swift
//  SaveStateWidget
//
//  Created by Karl Koch on 05/08/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

let pxOrange = Color(red: 1.00, green: 0.60, blue: 0.00, opacity: 1.0)
let pxTeal = Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0)

struct Provider: IntentTimelineProvider {
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.px-to-em"))
    var resultData: Data = Data()
    
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, result: "\(resultData)")
        completion(entry)
    }

    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, result: "\(resultData)")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let configuration: ConfigurationIntent
    public let result: String
    
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.px-to-em"))
    var resultData: Data = Data()


struct PlaceholderView : View {
    var body: some View {
        Text("16px is 1.000em")
    }
}

struct SaveStateWidgetEntryView : View {
    var entry: Provider.Entry
    
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.px-to-em"))
    var resultData: Data = Data()

    var body: some View {
        Text(entry.date, style: .time)
        VStack (alignment: .leading) {
            Text("Recent result").font(.system(.headline, design: .rounded)).bold()
                .foregroundColor(pxTeal)
            Spacer()
            Text("\(resultData)")
                .font(.system(.title2, design: .monospaced))
            Spacer()
        }.padding(.top, 20).padding(.bottom, 10).padding(.leading, -30)
    }
}

@main
struct SaveStateWidget: Widget {
    private let kind: String = "SaveStateWidget"

    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            SaveStateWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Saved result")
        .description("Your last saved result.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct SaveStateWidget_Previews: PreviewProvider {
    static var previews: some View {
        SaveStateWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), result: "\(entry.self)"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
}
