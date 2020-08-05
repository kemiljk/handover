//
//  Result.swift
//  Px to Em
//
//  Created by Karl Koch on 04/08/2020.
//  Copyright © 2020 KEJK. All rights reserved.
//

import SwiftUI
    
struct ResultText: Identifiable, Codable {
    let pixelTextEmpty: Double
    let baseTextEmpty: Double
    let scaleTextEmpty: Double
    
    var id: Double { pixelTextEmpty }
}
