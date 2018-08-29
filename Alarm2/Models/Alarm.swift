//
//  Alarm.swift
//  Alarm2
//
//  Created by Quinten Smith on 8/28/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation

class Alarm: Equatable, Codable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
            return lhs.uuid == rhs.uuid
        }

    
    
    var fireDate: Date = Date()
    var name: String
    var enabled: Bool
    let uuid: String
    
    var fireTimeAsString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        return formatter.string(from: fireDate)  }
    
    init(fireDate: Date, name: String, enabled: Bool = true, uuid: String = UUID().uuidString ) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid 
    }
    
    
}
