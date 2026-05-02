import Foundation

class GamificationManager {
    static let shared = GamificationManager()
    
    private let userDefaults = UserDefaults(suiteName: "group.com.ggsheng.PARADOX") ?? UserDefaults.standard
    
    private let xpKey = "user_xp"
    private let levelKey = "user_level"
    private let unlockedToolsKey = "unlocked_tools"
    
    struct XPLevelInfo {
        let level: Int
        let currentXP: Int
        let xpForNextLevel: Int
        let progress: Float
    }
    
    private init() {
        if userDefaults.object(forKey: xpKey) == nil {
            userDefaults.set(0, forKey: xpKey)
        }
        if userDefaults.object(forKey: levelKey) == nil {
            userDefaults.set(1, forKey: levelKey)
        }
        if userDefaults.object(forKey: unlockedToolsKey) == nil {
            userDefaults.set([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], forKey: unlockedToolsKey)
        }
    }
    
    var currentXP: Int {
        get { userDefaults.integer(forKey: xpKey) }
        set { userDefaults.set(newValue, forKey: xpKey) }
    }
    
    var currentLevel: Int {
        get { userDefaults.integer(forKey: levelKey) }
        set { userDefaults.set(newValue, forKey: levelKey) }
    }
    
    var unlockedToolIds: [Int] {
        get { userDefaults.array(forKey: unlockedToolsKey) as? [Int] ?? [] }
        set { userDefaults.set(newValue, forKey: unlockedToolsKey) }
    }
    
    var totalTools: Int { 75 }
    
    func getXPLevelInfo() -> XPLevelInfo {
        let level = currentLevel
        let xpForLevel = xpRequiredForLevel(level)
        let previousXP = xpForLevel - xpRequiredForLevel(level - 1)
        let currentLevelXP = currentXP - xpForPreviousLevels(level - 1)
        let progress = Float(currentLevelXP) / Float(previousXP)
        
        return XPLevelInfo(
            level: level,
            currentXP: currentXP,
            xpForNextLevel: xpForLevel,
            progress: min(progress, 1.0)
        )
    }
    
    private func xpRequiredForLevel(_ level: Int) -> Int {
        return level * level * 100
    }
    
    private func xpForPreviousLevels(_ level: Int) -> Int {
        var total = 0
        for i in 1...level {
            total += xpRequiredForLevel(i) - xpRequiredForLevel(i - 1)
        }
        return total
    }
    
    func addXP(_ amount: Int) {
        currentXP += amount
        checkLevelUp()
    }
    
    private func checkLevelUp() {
        let requiredXP = xpRequiredForLevel(currentLevel)
        while currentXP >= requiredXP {
            currentLevel += 1
        }
    }
    
    func unlockTool(_ toolId: Int) -> Bool {
        var tools = unlockedToolIds
        if !tools.contains(toolId) {
            tools.append(toolId)
            unlockedToolIds = tools
            return true
        }
        return false
    }
    
    func isToolUnlocked(_ toolId: Int) -> Bool {
        return unlockedToolIds.contains(toolId)
    }
    
    func resetProgress() {
        currentXP = 0
        currentLevel = 1
        unlockedToolIds = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    }
}