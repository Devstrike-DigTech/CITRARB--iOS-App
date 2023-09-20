//
//  Extensions.swift
//  CITRARB
//
//  Created by Richard Uzor on 02/08/2023.
//

import Foundation
//
//func extractVideoID(from link: String) -> String? {
//        let pattern = "v=([^&]+)"
//        guard let regex = try? NSRegularExpression(pattern: pattern),
//              let match = regex.firstMatch(in: link, range: NSRange(link.startIndex..., in: link)),
//              let range = Range(match.range(at: 1), in: link) else {
//            return nil
//        }
//        return String(link[range])
//    }

import MapKit

public func openMapsAppWithLocation(locationName: String) {
    // Create a search request for the location name
    let request = MKLocalSearch.Request()
    request.naturalLanguageQuery = locationName
    
    // Perform the search
    let search = MKLocalSearch(request: request)
    search.start { response, error in
        if let placemark = response?.mapItems.first?.placemark {
            // Create a map item with the placemark
            let mapItem = MKMapItem(placemark: placemark)
            
            // Open Apple Maps with the location
            mapItem.openInMaps()
        } else {
            // Handle the case where the location name couldn't be found
            print("Location not found: \(locationName)")
        }
    }
}
public func formatDateString(_ dateString: String) -> String? {
    // Create a DateFormatter to parse the input date string
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    // Parse the input date string into a Date object
    if let date = inputFormatter.date(from: dateString) {
        // Create a DateFormatter for the desired output format
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "eee dd-MMM-yyyy | h:mm a"
        outputFormatter.amSymbol = "AM"
        outputFormatter.pmSymbol = "PM"
        
        // Format the date into the desired output format
        let formattedDateString = outputFormatter.string(from: date)
        return formattedDateString
    }
    
    // Return nil for invalid input
    return nil
}


public func formatDateToMonthAndYear(_ dateString: String) -> String? {
    // Create a DateFormatter to parse the input date string
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    // Parse the input date string into a Date object
    if let date = inputFormatter.date(from: dateString) {
        // Create a DateFormatter for the desired output format
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM, yyyy"
//        outputFormatter.amSymbol = "AM"
//        outputFormatter.pmSymbol = "PM"
        
        // Format the date into the desired output format
        let formattedDateString = outputFormatter.string(from: date)
        return formattedDateString
    }
    
    // Return nil for invalid input
    return nil
}

import EventKit
import EventKitUI

public func addReminder(title: String, notes: String?, dueDate: Date?) {
    let eventStore = EKEventStore()
    
    // Find a suitable source for the calendar (e.g., iCloud, local, etc.)
    if let mySource = eventStore.sources.first(where: { $0.sourceType == .calDAV && $0.title == "iCloud" }) {
        
        let newCalendar = EKCalendar(for: .reminder, eventStore: eventStore)
        newCalendar.title = "Coal City Connect Events" // Set the calendar title to something meaningful
        // Set the calendar source
        newCalendar.source = mySource
        
        do {
            try eventStore.saveCalendar(newCalendar, commit: true)
        } catch {
            // Handle the error
            print("Error creating calendar: \(error.localizedDescription)")
        }
        
        switch EKEventStore.authorizationStatus(for: .reminder) {
        case .authorized:
            // If the app is authorized to access reminders, create a new reminder
            let reminder = EKReminder(eventStore: eventStore)
            
            // Set the title and notes for the reminder
            reminder.title = title
            if let notes = notes {
                reminder.notes = notes
            }
            
            // Set the due date for the reminder (optional)
            if let dueDate = dueDate {
                reminder.dueDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
            }
            // Set the calendar for the reminder
            if let myCalendar = eventStore.calendars(for: .reminder).first(where: { $0.title == "Coal City Connect Events" }) {
                reminder.calendar = myCalendar
            } else {
                print("Calendar not found")
                // Handle the case where the calendar is not found
            }
            
            
            // Save the reminder
            do {
                try eventStore.save(reminder, commit: true)
                print("Reminder saved successfully.")
            } catch {
                print("Error saving reminder: \(error.localizedDescription)")
            }
            
            
        case .notDetermined:
            // If the app hasn't requested access to reminders yet, request access
            eventStore.requestAccess(to: .reminder) { granted, error in
                if granted {
                    // If access is granted, call the addReminder function again
                    addReminder(title: title, notes: notes, dueDate: dueDate)
                } else {
                    print("Access to reminders denied.")
                }
            }
            
        case .denied, .restricted:
            print("Access to reminders is denied or restricted.")
        @unknown default:
            fatalError("Unhandled case")
        }
    }else {
        // Handle the case where a suitable source is not found
        print("Source not found.")
    }
}

public func dateFromISOString(_ dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    dateFormatter.timeZone = TimeZone(identifier: "UTC") // Set the time zone to UTC
    return dateFormatter.date(from: dateString)
}
