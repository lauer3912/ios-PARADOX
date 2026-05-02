import WidgetKit
import SwiftUI

struct PARADOXWidgetEntry: TimelineEntry {
    let date: Date
    let xpInfo: String
    let levelInfo: String
    let toolsUnlocked: Int
    let totalTools: Int
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> PARADOXWidgetEntry {
        PARADOXWidgetEntry(date: Date(), xpInfo: "0 XP", levelInfo: "Level 1", toolsUnlocked: 10, totalTools: 75)
    }

    func getSnapshot(in context: Context, completion: @escaping (PARADOXWidgetEntry) -> Void) {
        let entry = PARADOXWidgetEntry(
            date: Date(),
            xpInfo: "\(getCurrentXP()) XP",
            levelInfo: "Level \(getCurrentLevel())",
            toolsUnlocked: getUnlockedCount(),
            totalTools: 75
        )
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<PARADOXWidgetEntry>) -> Void) {
        let entry = PARADOXWidgetEntry(
            date: Date(),
            xpInfo: "\(getCurrentXP()) XP",
            levelInfo: "Level \(getCurrentLevel())",
            toolsUnlocked: getUnlockedCount(),
            totalTools: 75
        )
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }

    private func getCurrentXP() -> Int {
        let defaults = UserDefaults(suiteName: "group.com.ggsheng.PARADOX")
        return defaults?.integer(forKey: "user_xp") ?? 0
    }

    private func getCurrentLevel() -> Int {
        let defaults = UserDefaults(suiteName: "group.com.ggsheng.PARADOX")
        return defaults?.integer(forKey: "user_level") ?? 1
    }

    private func getUnlockedCount() -> Int {
        let defaults = UserDefaults(suiteName: "group.com.ggsheng.PARADOX")
        return defaults?.array(forKey: "unlocked_tools")?.count ?? 10
    }
}

struct PARADOXWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#0F0F14"), Color(hex: "#1A1A2E")]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "infinity")
                        .font(.system(size: 20))
                        .foregroundColor(Color(hex: "#9B8FE8"))
                    Text("PARADOX")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }

                Spacer()

                Text(entry.levelInfo)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color(hex: "#9B8FE8"))

                Text(entry.xpInfo)
                    .font(.system(size: 12, weight: .medium).monospaced())
                    .foregroundColor(Color(hex: "#FCD34D"))

                Text("\(entry.toolsUnlocked)/\(entry.totalTools) Tools")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}

@main
struct PARADOXWidget: Widget {
    let kind: String = "PARADOXWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider) { entry in
            PARADOXWidgetEntryView(entry: entry)
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6:
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255
        )
    }
}