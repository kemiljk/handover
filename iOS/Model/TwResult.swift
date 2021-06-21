//
//  TwResults.swift
//  Handover (iOS)
//
//  Created by Karl Koch on 15/06/2021.
//

import SwiftUI

class TWResults: ObservableObject {
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
