import UIKit

struct Event: Codable {
    let name: String
    let date: Date
    let description: String
    let photos: [Data] // Save images as Data
    let color: Data // Save color as Data
    var backgroundColor: Data?
    
    // Helper methods to convert UIImage to Data and vice versa
    static func imageToData(_ image: UIImage) -> Data? {
        return image.pngData()
    }
    
    static func dataToImage(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    // Helper methods to convert UIColor to Data and vice versa
    static func colorToData(_ color: UIColor) -> Data? {
        return try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
    }
    
    static func dataToColor(_ data: Data) -> UIColor? {
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
    }
}

class EventManager {
    static let shared = EventManager()
    private var events: [Event] = []
    private let eventsFileName = "events.json"
    
    private init() {
        loadEvents()
    }
    
    func addEvent(_ event: Event) {
        events.append(event)
        saveEvents()
    }
    
    func getEvents() -> [Event] {
        return events
    }
    
    func deleteEvent(at index: Int) {
        guard index >= 0 && index < events.count else {
            return
        }
        events.remove(at: index)
        saveEvents()
    }
    
    func sortEventsByDate() {
        events.sort { $0.date < $1.date }
        saveEvents()
    }
    
    private func saveEvents() {
        do {
            let fileURL = getDocumentsDirectory().appendingPathComponent(eventsFileName)
            let data = try JSONEncoder().encode(events)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save events: \(error)")
        }
    }
    
    private func loadEvents() {
        do {
            let fileURL = getDocumentsDirectory().appendingPathComponent(eventsFileName)
            let data = try Data(contentsOf: fileURL)
            events = try JSONDecoder().decode([Event].self, from: data)
        } catch {
            print("Failed to load events: \(error)")
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}

// Usage example
//let sampleEvent = Event(name: "Birthday Party",
//                        date: Date(),
//                        description: "A fun birthday party.",
//                        photos: [Event.imageToData(UIImage(named: "sampleImage")!)!],
//                        color: Event.colorToData(UIColor.red)!,
//                        backgroundColor: Event.colorToData(UIColor.white))
//EventManager.shared.addEvent(sampleEvent)
