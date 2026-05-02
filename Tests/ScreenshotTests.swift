import XCTest

final class ScreenshotTests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--uitesting"]
        app.launch()
        Thread.sleep(forTimeInterval: 2.0)
    }

    func testTab1_PARADOX() throws {
        let tabBar = app.tabBars.firstMatch
        tabBar.buttons["PARADOX"].tap()
        Thread.sleep(forTimeInterval: 1.5)
        
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot, quality: .medium)
        attachment.name = "1_PARADOX_Home.png"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testTab2_ENCODE() throws {
        let tabBar = app.tabBars.firstMatch
        tabBar.buttons["ENCODE"].tap()
        Thread.sleep(forTimeInterval: 1.5)
        
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot, quality: .medium)
        attachment.name = "2_ENCODE_Tools.png"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testTab3_DECIDE() throws {
        let tabBar = app.tabBars.firstMatch
        tabBar.buttons["DECIDE"].tap()
        Thread.sleep(forTimeInterval: 1.5)
        
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot, quality: .medium)
        attachment.name = "3_DECIDE_Chaos.png"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testTab4_MIRROR() throws {
        let tabBar = app.tabBars.firstMatch
        tabBar.buttons["MIRROR"].tap()
        Thread.sleep(forTimeInterval: 1.5)
        
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot, quality: .medium)
        attachment.name = "4_MIRROR_Compare.png"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testTab5_DREAMS() throws {
        let tabBar = app.tabBars.firstMatch
        tabBar.buttons["DREAMS"].tap()
        Thread.sleep(forTimeInterval: 1.5)
        
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot, quality: .medium)
        attachment.name = "5_DREAMS_Visual.png"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}