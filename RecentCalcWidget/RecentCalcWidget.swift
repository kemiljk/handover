//
//  RecentCalcWidget.swift
//  RecentCalcWidget
//
//  Created by Karl Koch on 06/08/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

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
    
    @AppStorage("result", store: UserDefaults(suiteName: "group.com.kejk.px-to-em"))
    var resultData: Data = Data()
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
        let date = Date()
        let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 15, to: date)!

        guard let calculation = try? JSONDecoder().decode(String.self, from: resultData) else { return }
        let entry = SimpleEntry(calculation: calculation)
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdateDate))
        completion(timeline)
    }
}


struct PlaceholderView : View {
    var body: some View {
        Text("16px is 1.000em")
    }
}

struct RecentCalcWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack (alignment: .leading) {
            Text("Recent result").font(.system(.headline, design: .rounded)).bold()
                .foregroundColor(pxTeal)
            Spacer()
            Text("\(entry.calculation)")
                .font(.system(.title2, design: .monospaced))
            Spacer()
        }.padding()
    }
}

@main
struct RecentCalcWidget: Widget {
    let kind: String = "RecentCalcWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RecentCalcWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Saved calculation")
        .description("Your last saved calculation.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct RecentCalcWidget_Previews: PreviewProvider {
    static var previews: some View {
        RecentCalcWidgetEntryView(entry: SimpleEntry(calculation: "\(entry.self)"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}



//import WidgetKit
//import SwiftUI
//
//struct Provider: TimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date())
//    }
//
//    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date())
//        completion(entry)
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//}
//
//struct RecentCalcWidgetEntryView : View {
//    var entry: Provider.Entry
//
//    var body: some View {
//        Text(entry.date, style: .time)
//    }
//}
