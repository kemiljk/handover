//
//  Px_to_Em_Widget.swift
//  Px to Em Widget
//
//  Created by Karl Koch on 02/07/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import WidgetKit
import SwiftUI

let pxOrange = Color(red: 1.00, green: 0.60, blue: 0.00, opacity: 1.0)
let pxTeal = Color(red: 0.00, green: 0.60, blue: 0.53, opacity: 1.0)

struct Provider: TimelineProvider {
    public typealias Entry = SimpleEntry

    public func snapshot(with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    public func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
}

struct PlaceholderView : View {
    var body: some View {
        Text("...")
    }
}

struct Px_to_Em_WidgetEntryView : View {
    var entry: Provider.Entry

     // TODO: This should show the previous conversion value
    var body: some View {
        //Text(entry.date, style: .time)
        VStack (alignment: .leading) {
            Text("Recent result").font(.system(.headline, design: .rounded)).bold()
                .foregroundColor(pxTeal)
            Spacer()
            Text("16px is 1.000em")
                .font(.system(.title2, design: .monospaced))
            Spacer()
        }.padding(.top, 20).padding(.bottom, 10).padding(.leading, -30)
    }
}

@main
struct Px_to_Em_Widget: Widget {
    private let kind: String = "Px_to_Em_Widget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider(),
            placeholder: PlaceholderView()
        )
        {
            entry in
            Px_to_Em_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Px ›› Em Widget")
        .description("Displaying the latest conversion value.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct Px_to_Em_Widget_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
