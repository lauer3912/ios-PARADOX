import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
        configureAppearance()
        return true
    }

    private func configureAppearance() {
        // Tab Bar Appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = Theme.Colors.background

        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = Theme.Colors.secondary
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: Theme.Colors.secondary]
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = Theme.Colors.primary
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: Theme.Colors.primary]

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance

        // Navigation Bar Appearance
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = Theme.Colors.background
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().tintColor = Theme.Colors.primary
    }
}