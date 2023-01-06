//
//  ContentManager.swift
//  WidgetTest
//
//  Created by Quentin Deschamps on 06/01/2023.
//

import Foundation

struct ContentList {
    var name: String?
    var cardViewSubtitle: String?
    var descriptionPlainText: String?
    var releasedAtDateTimeString: String?
}

extension FileManager {
    // Shared URL between the App and the Widget
    static func sharedContainerURL() -> URL {
        return FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: "group.com.quentindeschamps.WidgetTest.contents"
        )!
    }
}

class ContentManager: ObservableObject {
    @Published var contents: [ContentList] = [] {
        didSet {
          writeContents()
        }
    }
    
    // Here you build as many WidgetContent as you need from your contents. For the example I just built [ContentList] manually in the ContentView.
    func writeContents() {
        let widgetContents = contents.map {
            WidgetContent(name: $0.name ?? "", cardViewSubtitle: $0.cardViewSubtitle ?? "",
                          descriptionPlainText: $0.descriptionPlainText ?? "",
                          releasedAtDateTimeString: $0.releasedAtDateTimeString ?? "")
        }
        let archiveURL = FileManager.sharedContainerURL()
            .appendingPathComponent("contents.json")
        let encoder = JSONEncoder()
        if let dataToSave = try? encoder.encode(widgetContents) {
            do {
                try dataToSave.write(to: archiveURL)
            } catch {
                print("Error: Can't write contents")
                return
            }
        }
    }
}


