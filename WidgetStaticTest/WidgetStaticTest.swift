//
//  WidgetStaticTest.swift
//  WidgetStaticTest
//
//  Created by Quentin Deschamps on 06/01/2023.
//

import WidgetKit
import SwiftUI

extension FileManager {
    // Shared URL between the App and the Widget.
    static func sharedContainerURL() -> URL {
        return FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: "group.com.quentindeschamps.WidgetTest.contents"
        )!
    }
}

// Test Entry for a static Widget.
let snapshotEntry = WidgetContent(
    name: "iOS Concurrency with GCD and Operations",
    cardViewSubtitle: "iOS & Swift",
    descriptionPlainText: """
    Learn how to add concurrency to your apps! \
    Keep your app's UI responsive to give your \
    users a great user experience.
    """,
    releasedAtDateTimeString: "Jun 23 2020 • Video Course (3 hrs, 21 mins)")


struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> WidgetContent {
        snapshotEntry
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WidgetContent) -> ()) {
        let entry = snapshotEntry
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries = readContents()
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        // Generate a timeline by setting entry dates interval seconds apart,
        // starting from the current date.
        let currentDate = Date()
        let interval = 5
        for index in 0 ..< entries.count {
          entries[index].date = Calendar.current.date(byAdding: .second,
            value: index * interval, to: currentDate)!
        }
        
        // Timeline hold as many WidgetContent as you pass to it. And change the content every interval you give.
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    // Decode contents from archived URL
    func readContents() -> [WidgetContent] {
        var contents: [WidgetContent] = []
        let archiveURL =
        FileManager.sharedContainerURL()
            .appendingPathComponent("contents.json")
        
        let decoder = JSONDecoder()
        if let codeData = try? Data(contentsOf: archiveURL) {
            do {
                contents = try decoder.decode([WidgetContent].self, from: codeData)
            } catch {
                print("Error: Can't decode contents")
            }
        }
        return contents
    }
}

@main
struct WidgetStaticTest: Widget {
    private let kind: String = "WidgetTest"
    
    public var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: Provider()
        ) { entry in
            EntryView(model: entry)
        }
        // Title and Description in the widget's menu.
        .configurationDisplayName("RW Tutorials")
        .description("See the latest video tutorials.")
        // Allow size type for the widget (small, medium, large, extra large)
        .supportedFamilies([.systemMedium])
    }
}
