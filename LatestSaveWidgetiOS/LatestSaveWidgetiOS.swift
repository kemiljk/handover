//
//  SavedStateWidget.swift
//  SavedStateWidget
//
//  Created by Karl Koch on 05/08/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry, Identifiable {
    var id = UUID()
    public let date: Date
    public let calculation: String
    public let baseline: String
    public let scale: String
}

struct Provider: TimelineProvider {
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.handover")) var resultData: Data = Data()
    @AppStorage("scaleResult", store: UserDefaults(suiteName: "group.com.kejk.handover")) var scaleData: String = ""
    @AppStorage("baselineResult", store: UserDefaults(suiteName: "group.com.kejk.handover")) var baselineData: String = ""
    var date: Date = Date()
    typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        let baseline: String = "16px"
        let scale: String = "1.000"
        let calculation: String = "16px is 1.00rem"
        return SimpleEntry(date: Date(), calculation: calculation, baseline: baseline, scale: scale)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let calculation: String = "16px is 1.00rem"
        let baseline: String = "16px"
        let scale: String = "1.000"
        let entry = SimpleEntry(date: Date(), calculation: calculation, baseline: baseline, scale: scale)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        guard let calculation = try? JSONDecoder().decode(String.self, from: resultData) else { return }
        let baseline = baselineData
        let scale = scaleData
        let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: date)!
        let entry = SimpleEntry(date: nextUpdateDate, calculation: calculation, baseline: baseline, scale: scale)
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
        completion(timeline)
    }
}

struct PlaceholderView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(family == .systemSmall  ? "LATEST SAVE" : "LATEST SAVED RESULT").font(.system(.caption, design: .default)).bold()
                    .foregroundColor(Color("teal"))
                Spacer()
                family == .systemMedium ?
                    Image(systemName: "bookmark.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(Color("teal")) : nil
            }
            Spacer()
            VStack (alignment: .leading) {
                HStack {
                    VStack (alignment: .leading) {
                        Text("BASELINE")
                            .font(.system(size: 10, design: .default))
                            .foregroundColor(.secondary)
                        Text("16px")
                            .font(.system(size: 12, design: .default))
                    }
                    Spacer()
                    VStack (alignment: .leading) {
                        Text("SCALE")
                            .font(.system(size: 10, design: .default))
                            .foregroundColor(.secondary)
                        Text("1.000")
                            .font(.system(size: 12, design: .default))
                    }
                    .padding(.leading, family == .systemMedium ? 24 : 0)
                    family == .systemMedium ? Spacer() : nil
                }
                .padding(.bottom, 16)
            }
            VStack {
                Text("16px is 1.00rem")
                    .font(.system(size: 14, design: .monospaced))
            }
            Spacer()
        }.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .leading)
        .background(Color("WidgetBackground"))
    }
}

struct SavedStateWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    var data: Provider.Entry
    var items = [Provider.Entry]()
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(family == .systemSmall  ? "LATEST SAVE" : "LATEST SAVED RESULT").font(.system(.caption, design: .default)).bold()
                    .foregroundColor(Color("teal"))
                Spacer()
                family == .systemMedium ?
                    Image(systemName: "bookmark.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(Color("teal")) : nil
            }
            Spacer()
            VStack (alignment: .leading) {
                HStack {
                    VStack (alignment: .leading) {
                        Text("BASELINE")
                            .font(.system(size: 10, design: .default))
                            .foregroundColor(.secondary)
                        Text("\(data.baseline)px")
                            .font(.system(size: 12, design: .default))
                    }
                    Spacer()
                    if data.scale != "" {
                        
                        VStack (alignment: .leading) {
                            Text("SCALE")
                                .font(.system(size: 10, design: .default))
                                .foregroundColor(.secondary)
                            Text("\(data.scale)")
                                .font(.system(size: 12, design: .default))
                        }
                        .padding(.leading, family == .systemMedium ? 24 : 0)
                        family == .systemMedium ? Spacer() : nil
                    }
                    }
                
            }
            .padding(.bottom, 16)
            VStack {
                Text("\(data.calculation)")
                    .font(.system(size: 14, design: .monospaced))
            }
            Spacer()
        }.padding(16)
        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .leading)
        .background(Color("WidgetBackground"))
    }
}

@main
struct SavedStateWidget: Widget {
    private let kind: String = "SavedStateWidget"
    
    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { data in
            SavedStateWidgetEntryView(data: data)
        }
        .configurationDisplayName("Saved calculation")
        .description("Your last saved calculation.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
