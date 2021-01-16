//
//  SavedResults.swift
//  Px ›› Em
//
//  Created by Karl Koch on 08/10/2020.
//  Copyright © 2020 KEJK. All rights reserved.


import SwiftUI

class PXResults: ObservableObject {
    @Published var items = [ResultItem]() {
        
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "result")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "result")
        {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ResultItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}
