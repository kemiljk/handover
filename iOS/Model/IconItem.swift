//
//  IconItem.swift
//  Handover (iOS)
//
//  Created by Karl Koch on 29/06/2021.
//

import SwiftUI

struct IconItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var image: String
    var hasBorder: Bool = false
}
