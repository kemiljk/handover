//
//  ResultItem.swift
//  Hand››over
//
//  Created by Karl Koch on 14/10/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI

struct ResultItem: Identifiable, Codable {
    var id = UUID()
    let pxResult: String
    let emResult: String
    let lhResult: String
    let twResult: String
    let prResult: String
}
