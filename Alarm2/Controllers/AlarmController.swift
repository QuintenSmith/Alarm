//
//  AlarmController.swift
//  Alarm2
//
//  Created by Quinten Smith on 8/28/18.
//  Copyright © 2018 Quinten Smith. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotification(for alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm){
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Wake Up"
        notificationContent.body = "Time to wake up!"
        notificationContent.sound = UNNotificationSound.default()
        let dateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: alarm.fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error{
                print("Error scheduling local user notifications \(error.localizedDescription)  :  \(error)")
            }
        }
        
    }

    func cancelUserNotification(for alarm: Alarm) {
 UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}

class AlarmController: AlarmScheduler {
    
    // Singleton
    
    static let shared = AlarmController()
    
    // Source Of Truth
     var alarms: [Alarm] = []
    
    
    // Create
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let alarm = Alarm(fireDate: fireDate, name: name)
        AlarmController.shared.alarms.append(alarm)
        save()
    }
    
    // Update
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        scheduleUserNotifications(for: alarm)
        save()
    }
    
    // Delete
    func delete(alarm: Alarm) {
        guard let index = AlarmController.shared.alarms.index(of: alarm) else {return}
        self.cancelUserNotification(for: alarm)
        alarms.remove(at: index)
        save()
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        if alarm.enabled{
            scheduleUserNotifications(for: alarm)
        } else{
            cancelUserNotification(for: alarm)
        } 
    }
    
    // Persistence
    
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "alarms.json"
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }
    
    func save(){
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(alarms)
            try data.write(to: fileURL())
        } catch {
            print("Error saving to persistence: \(error.localizedDescription)")
        }
    }
    
    func load() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let decodedAlarms = try decoder.decode([Alarm].self, from: data)
            self.alarms = decodedAlarms
        } catch {
            print("Error loadking from persistence \(error.localizedDescription)")
        }
    }
    
    
    
    
    
    
    
}





