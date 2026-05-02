import Foundation

struct Tool: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let icon: String
    let xpReward: Int
    let tab: TabType
    var isUnlocked: Bool

    enum CodingKeys: String, CodingKey {
        case id, name, description, icon, xpReward, tab
    }
    
    init(id: Int, name: String, description: String, icon: String, xpReward: Int, tab: TabType, isUnlocked: Bool = false) {
        self.id = id
        self.name = name
        self.description = description
        self.icon = icon
        self.xpReward = xpReward
        self.tab = tab
        self.isUnlocked = isUnlocked
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        icon = try container.decode(String.self, forKey: .icon)
        xpReward = try container.decode(Int.self, forKey: .xpReward)
        tab = try container.decode(TabType.self, forKey: .tab)
        isUnlocked = GamificationManager.shared.isToolUnlocked(id)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(icon, forKey: .icon)
        try container.encode(xpReward, forKey: .xpReward)
        try container.encode(tab, forKey: .tab)
    }
}

enum TabType: String, Codable, CaseIterable {
    case paradox = "PARADOX"
    case encode = "ENCODE"
    case decide = "DECIDE"
    case mirror = "MIRROR"
    case dreams = "DREAMS"

    var title: String { rawValue }
    
    var icon: String {
        switch self {
        case .paradox: return "infinity"
        case .encode: return "lock.shield"
        case .decide: return "dice"
        case .mirror: return "person.and.magnifyingglass"
        case .dreams: return "sparkles"
        }
    }
    
    var accentColor: String {
        switch self {
        case .paradox: return "#9B8FE8"
        case .encode: return "#00F5FF"
        case .decide: return "#FF2D95"
        case .mirror: return "#9B8FE8"
        case .dreams: return "#00F5FF"
        }
    }
}

struct ToolData {
    static let allTools: [Tool] = [
        // PARADOX Tab (0-9)
        Tool(id: 0, name: "Parallel Self Chat", description: "Chat with your alternate universe self", icon: "person.2.fill", xpReward: 50, tab: .paradox),
        Tool(id: 1, name: "What If Scenario", description: "Simulate alternative life choices", icon: "arrow.triangle.branch", xpReward: 40, tab: .paradox),
        Tool(id: 2, name: "Timeline Navigator", description: "Visualize branching timelines", icon: "timeline.selection", xpReward: 60, tab: .paradox),
        Tool(id: 3, name: "Future Self Writer", description: "Messages from your future self", icon: "arrow.up.to.line", xpReward: 45, tab: .paradox),
        Tool(id: 4, name: "Past Self Messages", description: "Send messages to your past", icon: "arrow.down.to.line", xpReward: 45, tab: .paradox),
        Tool(id: 5, name: "Quantum Decision", description: "Analyze outcomes with probability", icon: "atom", xpReward: 55, tab: .paradox),
        Tool(id: 6, name: "Multiverse Calculator", description: "Calculate universe probabilities", icon: "globe", xpReward: 50, tab: .paradox),
        Tool(id: 7, name: "Paradox of the Day", description: "Daily mind-bending paradox", icon: "brain", xpReward: 30, tab: .paradox),
        Tool(id: 8, name: "Random Universe", description: "Generate random universe scenarios", icon: "shuffle", xpReward: 35, tab: .paradox),
        Tool(id: 9, name: "Reality Glitch", description: "Activate reality glitches", icon: "bolt.fill", xpReward: 40, tab: .paradox),

        // ENCODE Tab (10-29)
        Tool(id: 10, name: "Ghost Coder", description: "Encrypt and decrypt hidden messages", icon: "lock.shield.fill", xpReward: 50, tab: .encode),
        Tool(id: 11, name: "Reverse Encoder", description: "Encode text in reverse", icon: "arrow.left.and.right", xpReward: 25, tab: .encode),
        Tool(id: 12, name: "Base64 Tool", description: "Encode/decode Base64 strings", icon: "textformat.abc", xpReward: 40, tab: .encode),
        Tool(id: 13, name: "Caesar Cipher", description: "Classic letter shift cipher", icon: "textformat", xpReward: 35, tab: .encode),
        Tool(id: 14, name: "Morse Code", description: "Translate text to/from Morse", icon: "wave.3.right", xpReward: 45, tab: .encode),
        Tool(id: 15, name: "Binary Converter", description: "Text to binary and back", icon: "01.square", xpReward: 30, tab: .encode),
        Tool(id: 16, name: "Hex Converter", description: "Text to hexadecimal", icon: "hexagon", xpReward: 30, tab: .encode),
        Tool(id: 17, name: "Atbash Cipher", description: "Ancient Hebrew substitution", icon: "scroll", xpReward: 35, tab: .encode),
        Tool(id: 18, name: "ROT13", description: "Rotate letters by 13", icon: "arrow.2.circlepath", xpReward: 25, tab: .encode),
        Tool(id: 19, name: "AES Encrypt", description: "Password-protected encryption", icon: "key.fill", xpReward: 60, tab: .encode),
        Tool(id: 20, name: "Hash Generator", description: "MD5, SHA-1, SHA-256 hashes", icon: "number", xpReward: 40, tab: .encode),
        Tool(id: 21, name: "QR Generator", description: "Create QR codes", icon: "qrcode", xpReward: 30, tab: .encode),
        Tool(id: 22, name: "QR Scanner", description: "Scan and decode QR codes", icon: "qrcode.viewfinder", xpReward: 35, tab: .encode),
        Tool(id: 23, name: "Barcode Generator", description: "Create various barcodes", icon: "barcode", xpReward: 30, tab: .encode),
        Tool(id: 24, name: "Invisible Ink", description: "Create hidden messages", icon: "eye.slash", xpReward: 40, tab: .encode),
        Tool(id: 25, name: "Pigpen Cipher", description: "Masonic-style encoder", icon: "square.grid.3x3", xpReward: 45, tab: .encode),
        Tool(id: 26, name: "Unicode Decoder", description: "Decode Unicode characters", icon: "character.textbox", xpReward: 25, tab: .encode),
        Tool(id: 27, name: "URL Encoder", description: "Encode/decode URLs", icon: "link", xpReward: 25, tab: .encode),
        Tool(id: 28, name: "Timestamp Converter", description: "Convert timestamps", icon: "clock", xpReward: 20, tab: .encode),
        Tool(id: 29, name: "JWT Decoder", description: "Decode JWT tokens", icon: "key.horizontal", xpReward: 45, tab: .encode),

        // DECIDE Tab (30-44)
        Tool(id: 30, name: "Chaos Spinner", description: "Random decision maker", icon: "arrow.triangle.2.circlepath", xpReward: 25, tab: .decide),
        Tool(id: 31, name: "Scales of Fate", description: "Visual balance weighing", icon: "scale.3d", xpReward: 35, tab: .decide),
        Tool(id: 32, name: "Dice Roller", description: "Virtual dice with animations", icon: "die.face.5", xpReward: 20, tab: .decide),
        Tool(id: 33, name: "Coin Flip", description: "Heads or tails universe", icon: "circle.fill", xpReward: 15, tab: .decide),
        Tool(id: 34, name: "Name Picker", description: "Random name selection", icon: "person.crop.circle.badge.plus", xpReward: 25, tab: .decide),
        Tool(id: 35, name: "Scenario Randomizer", description: "Random what-if scenarios", icon: "questionmark.diamond", xpReward: 30, tab: .decide),
        Tool(id: 36, name: "Superpower Chooser", description: "What superpower in another universe", icon: "bolt.circle", xpReward: 35, tab: .decide),
        Tool(id: 37, name: "Career Simulator", description: "Alternate career timelines", icon: "briefcase", xpReward: 40, tab: .decide),
        Tool(id: 38, name: "Would You Rather", description: "Dilemma challenges", icon: "exclamationmark.triangle", xpReward: 25, tab: .decide),
        Tool(id: 39, name: "Truth or Dare", description: "Generate truth or dare", icon: "hand.raised.fill", xpReward: 20, tab: .decide),
        Tool(id: 40, name: "Movie Picker", description: "Random movie selection", icon: "film", xpReward: 20, tab: .decide),
        Tool(id: 41, name: "Restaurant Picker", description: "Random restaurant suggestion", icon: "fork.knife", xpReward: 20, tab: .decide),
        Tool(id: 42, name: "Travel Picker", description: "Random destination generator", icon: "airplane", xpReward: 35, tab: .decide),
        Tool(id: 43, name: "Playlist Shuffler", description: "Shuffle music selection", icon: "music.note.list", xpReward: 20, tab: .decide),
        Tool(id: 44, name: "Activity Generator", description: "Random activity ideas", icon: "figure.walk", xpReward: 25, tab: .decide),

        // MIRROR Tab (45-54)
        Tool(id: 45, name: "Mirror Mode", description: "Before/After comparison", icon: "person.and.magnifyingglass", xpReward: 40, tab: .mirror),
        Tool(id: 46, name: "Age Progression", description: "See future you", icon: "hourglass", xpReward: 50, tab: .mirror),
        Tool(id: 47, name: "Age Regression", description: "See younger you", icon: "clock.arrow.circlepath", xpReward: 50, tab: .mirror),
        Tool(id: 48, name: "Gender Swap", description: "Preview opposite gender", icon: "person.fill.viewfinder", xpReward: 55, tab: .mirror),
        Tool(id: 49, name: "Celebrity Look-alike", description: "Find your celebrity twin", icon: "star.fill", xpReward: 45, tab: .mirror),
        Tool(id: 50, name: "Universe Comparator", description: "Compare cosmic sizes", icon: "globe.americas.fill", xpReward: 35, tab: .mirror),
        Tool(id: 51, name: "Timeline Explorer", description: "Life choice timelines", icon: "point.topleft.down.curvedto.point.bottomright.up", xpReward: 45, tab: .mirror),
        Tool(id: 52, name: "What If Compare", description: "Compare two realities", icon: "arrow.left.arrow.right", xpReward: 40, tab: .mirror),
        Tool(id: 53, name: "Before/After Slider", description: "Slider comparison tool", icon: "slider.horizontal.3", xpReward: 35, tab: .mirror),
        Tool(id: 54, name: "Dimension Compare", description: "Compare dimensions", icon: "cube", xpReward: 35, tab: .mirror),

        // DREAMS Tab (55-74)
        Tool(id: 55, name: "Dream Generator", description: "AI surreal dream images", icon: "moon.stars.fill", xpReward: 80, tab: .dreams),
        Tool(id: 56, name: "Nightmare Maker", description: "Dark surreal scenes", icon: "moon.fill", xpReward: 75, tab: .dreams),
        Tool(id: 57, name: "Glitch Effect", description: "Reality glitch on photos", icon: "waveform.path.ecg", xpReward: 50, tab: .dreams),
        Tool(id: 58, name: "Dimensional Rifts", description: "Animated portal effects", icon: "circle.hexagongrid.fill", xpReward: 60, tab: .dreams),
        Tool(id: 59, name: "Impossible Shapes", description: "Generate impossible geometry", icon: "seal.fill", xpReward: 45, tab: .dreams),
        Tool(id: 60, name: "Optical Illusions", description: "Interactive optical illusions", icon: "eye", xpReward: 40, tab: .dreams),
        Tool(id: 61, name: "Parallax Backgrounds", description: "3D parallax animations", icon: "rectangle.3.group.fill", xpReward: 45, tab: .dreams),
        Tool(id: 62, name: "Hologram Effect", description: "Holographic phone display", icon: "cpu", xpReward: 55, tab: .dreams),
        Tool(id: 63, name: "Glitch Animations", description: "Animated glitch effects", icon: "zap.fill", xpReward: 40, tab: .dreams),
        Tool(id: 64, name: "Static Noise", description: "TV static visual", icon: "tv.fill", xpReward: 25, tab: .dreams),
        Tool(id: 65, name: "CRT Effect", description: "Retro TV monitor look", icon: "tv", xpReward: 30, tab: .dreams),
        Tool(id: 66, name: "Matrix Rain", description: "Digital rain effect", icon: "text.alignleft", xpReward: 35, tab: .dreams),
        Tool(id: 67, name: "Neon Glow", description: "Neon text effects", icon: "textformat.underline", xpReward: 30, tab: .dreams),
        Tool(id: 68, name: "Cyberpunk Filter", description: "Cyberpunk photo filter", icon: "camera.filters", xpReward: 45, tab: .dreams),
        Tool(id: 69, name: "Hologram Fan", description: "LED fan hologram", icon: "fanblades.fill", xpReward: 50, tab: .dreams),
        Tool(id: 70, name: "Portal Effect", description: "Portal/gateway effect", icon: "door.left.hand.open", xpReward: 55, tab: .dreams),
        Tool(id: 71, name: "Time Warp", description: "Time distortion effect", icon: "clock.badge.checkmark", xpReward: 50, tab: .dreams),
        Tool(id: 72, name: "Reality Shift", description: "Shift reality effect", icon: "arrow.up.arrow.down", xpReward: 45, tab: .dreams),
        Tool(id: 73, name: "Multiverse Collage", description: "Collage across universes", icon: "square.grid.2x2.fill", xpReward: 55, tab: .dreams),
        Tool(id: 74, name: "Paradox Signature", description: "Create paradox signatures", icon: "signature", xpReward: 40, tab: .dreams)
    ]
    
    static func tools(for tab: TabType) -> [Tool] {
        return allTools.filter { $0.tab == tab }
    }
    
    static func tool(withId id: Int) -> Tool? {
        return allTools.first { $0.id == id }
    }
}