//
//  SavedStateWidget.swift
//  SavedStateWidget
//
//  Created by Karl Koch on 05/08/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry, Identifiable, Hashable {
    var id = UUID()
    public let date: Date
    public let calculation: String
    public let baseline: String
    public let scale: String
    public let radiusResult: String
    public let innerRadius: String
    public let outerRadius: String
    public let padding: String
}

struct Provider: TimelineProvider {
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.handover")) var resultData: String = ""
    @AppStorage("scaleResult", store: UserDefaults(suiteName: "group.com.kejk.handover")) var scaleData: String = ""
    @AppStorage("baselineResult", store: UserDefaults(suiteName: "group.com.kejk.handover")) var baselineData: String = ""
    @AppStorage("radiusResult", store: UserDefaults(suiteName: "group.com.kejk.handover")) var radiusResultData: String = ""
    @AppStorage("innerRadiusResult", store: UserDefaults(suiteName: "group.com.kejk.handover")) var innerRadiusResultData: String = ""
    @AppStorage("outerRadiusResult", store: UserDefaults(suiteName: "group.com.kejk.handover")) var outerRadiusResultData: String = ""
    @AppStorage("paddingResult", store: UserDefaults(suiteName: "group.com.kejk.handover")) var paddingResultData: String = ""
    
    var date: Date = Date()
    typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        let baseline: String = "16"
        let scale: String = "1.000"
        let calculation: String = "1.000rem"
        let radiusResult: String = ""
        let innerRadius = ""
        let outerRadius = ""
        let padding = ""
        return SimpleEntry(date: Date(), calculation: calculation, baseline: baseline, scale: scale, radiusResult: radiusResult, innerRadius: innerRadius, outerRadius: outerRadius, padding: padding)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let baseline: String = "16"
        let scale: String = "1.000"
        let calculation: String = "1.000rem"
        let radiusResult: String = ""
        let innerRadius: String  = ""
        let outerRadius: String = ""
        let padding: String = ""
        let entry = SimpleEntry(date: Date(), calculation: calculation, baseline: baseline, scale: scale, radiusResult: radiusResult, innerRadius: innerRadius, outerRadius: outerRadius, padding: padding)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        let calculation = resultData
        let baseline = baselineData
        let scale = scaleData
        let radiusResult = radiusResultData
        let innerRadius = innerRadiusResultData
        let outerRadius = outerRadiusResultData
        let padding = paddingResultData
        let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: date)!
        let entry = SimpleEntry(date: nextUpdateDate, calculation: calculation, baseline: baseline, scale: scale, radiusResult: radiusResult, innerRadius: innerRadius, outerRadius: outerRadius, padding: padding)
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
                        Text("16")
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
        if data.calculation != "" {
            CalculatorView(data: data)
        }
        if data.calculation == "" {
            PerfectRadiusView(data: data)
        }
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
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct CalculatorView: View {
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
                    if !data.baseline.isEmpty {
                        VStack (alignment: .leading) {
                            Text("BASELINE")
                                .font(.system(size: 10, design: .default))
                                .foregroundColor(.secondary)
                            Text("\(data.baseline)px")
                                .font(.system(size: 12, design: .default))
                        }
                    }
                    Spacer()
                    if !data.scale.isEmpty {
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

struct PerfectRadiusView: View {
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
                            Text(data.outerRadius != "" ? "OUTER RADIUS" : "INNER RADIUS")
                                .font(.system(size: 10, design: .default))
                                .foregroundColor(.secondary)
                            Text("\(data.innerRadius != "" ? data.innerRadius : data.outerRadius)px")
                                .font(.system(size: 12, design: .default))
                        }
                    Spacer()
                    if data.padding != "" {
                        VStack (alignment: .leading) {
                            Text("PADDING")
                                .font(.system(size: 10, design: .default))
                                .foregroundColor(.secondary)
                            Text("\(data.padding)")
                                .font(.system(size: 12, design: .default))
                        }
                        .padding(.leading, family == .systemMedium ? 24 : 0)
                        family == .systemMedium ? Spacer() : nil
                    }
                }
            }
            .padding(.bottom, 16)
            VStack {
                Text("\(data.radiusResult)")
                    .font(.system(size: 14, design: .monospaced))
            }
            Spacer()
        }.padding(16)
        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .leading)
        .background(Color("WidgetBackground"))
    }
}
