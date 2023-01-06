//
//  WidgetContent.swift
//  WidgetTest
//
//  Created by Quentin Deschamps on 06/01/2023.
//

import Foundation
import WidgetKit

struct WidgetContent: TimelineEntry, Codable {
    var date = Date()
    let name: String
    let cardViewSubtitle: String
    let descriptionPlainText: String
    let releasedAtDateTimeString: String
}
