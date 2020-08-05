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

struct Provider: IntentTimelineProvider {
    public func snapshot(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    public func timeline(for configuration: ConfigurationIntent, with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let configuration: ConfigurationIntent
//    public let result: String
    
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.px-to-em"))
    var resultData: Data = Data()
    
//    result = "\(Int(entry.pixelTextEmpty) ?? 16)px is \(String(format: "%.3f", entry.pxToEms(baseInt: Double(entry.baseTextEmpty) ?? 16, pixelInt: Double(entry.pixelTextEmpty) ?? 16, scaleInt: Double(entry.scaleTextEmpty) ?? 1)))em"
}

struct PlaceholderView : View {
    var body: some View {
        Text("16px is 1.000em")
    }
}

struct SaveStateWidgetEntryView : View {
    var entry: Provider.Entry
    
//    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.px-to-em"))
//    var resultData: Data = Data()
//
//    @State private var baseText = "16"
//    @State private var pixelText = "16"
//    @State private var scaleText = "1.000"
//    @State private var baseTextEmpty = ""
//    @State private var pixelTextEmpty = ""
//    @State private var scaleTextEmpty = ""
//
//    lazy var pixelInt = Double(pixelText) ?? 16
//    lazy var baseInt = Double(baseText) ?? 16
//    lazy var scaleInt = Double(scaleText) ?? 1.000
//
//    func pxToEms(baseInt: Double, pixelInt: Double, scaleInt: Double) -> Double {
//        let emValue = (pixelInt / baseInt) * scaleInt
//        return emValue
//    }

    var body: some View {
        Text(entry.date, style: .time)
//        Text("\(Int(pixelTextEmpty) ?? 16)px is \(String(format: "%.3f", pxToEms(baseInt: Double(baseTextEmpty) ?? 16, pixelInt: Double(pixelTextEmpty) ?? 16, scaleInt: Double(scaleTextEmpty) ?? 1)))em")
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
    }
}

struct SaveStateWidget_Previews: PreviewProvider {
    static var previews: some View {
        SaveStateWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
