//
//  SavedStateWidget.swift
//  SavedStateWidget
//
//  Created by Karl Koch on 05/08/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let calculation: String
}

struct Provider: TimelineProvider {
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.px-to-em"))
    var resultData: Data = Data()
    var date: Date = Date()
    typealias Entry = SimpleEntry
    
    func placeholder(in context: Context) -> SimpleEntry {
        let calculation: String = "16px is 1.00em at a scale of 1.000 with a baseline of 16px"
        return SimpleEntry(date: Date(), calculation: calculation)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let calculation: String = "16px is 1.00em at a scale of 1.000 with a baseline of 16px"
        let entry = SimpleEntry(date: Date(), calculation: calculation)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        guard let calculation = try? JSONDecoder().decode(String.self, from: resultData) else { return }
        let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: date)!
        let entry = SimpleEntry(date: nextUpdateDate, calculation: calculation)
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
        completion(timeline)
    }
}

struct PlaceholderView : View {
    var body: some View {
        VStack (alignment: .leading) {
            Text("Saved result").font(.system(.title3, design: .rounded)).bold()
                .foregroundColor(Color("AccentColor"))
            Spacer()
            HStack {
            Text("16px is 1.00em at a scale of 1.000 with a baseline of 16px ")
                .font(.system(size: 14, design: .monospaced))
            }
            Spacer()
        }.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        .frame(minWidth: 0, idealWidth: 100, maxWidth: .infinity, minHeight: 0, idealHeight: 100, maxHeight: .infinity, alignment: .leading)
        .background(Color("WidgetBackground"))
    }
}

struct SavedStateWidgetEntryView : View {
    var data: Provider.Entry

    var body: some View {
        VStack (alignment: .leading) {
            Text("Saved result").font(.system(.title3, design: .rounded)).bold()
                .foregroundColor(Color("AccentColor"))
            Spacer()
            HStack {
                Text("\(data.calculation)")
                    .font(.system(size: 14, design: .monospaced))
                }
                Spacer()
            }.padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
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

struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlaceholderView()
                .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
    }
}
