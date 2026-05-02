import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupGamificationBanner()
    }

    private func setupTabs() {
        let paradoxVC = UINavigationController(rootViewController: ParadoxHomeViewController())
        paradoxVC.tabBarItem = UITabBarItem(title: "PARADOX", image: UIImage(systemName: "infinity"), tag: 0)

        let encodeVC = UINavigationController(rootViewController: EncodeViewController())
        encodeVC.tabBarItem = UITabBarItem(title: "ENCODE", image: UIImage(systemName: "lock.shield"), tag: 1)

        let decideVC = UINavigationController(rootViewController: DecideViewController())
        decideVC.tabBarItem = UITabBarItem(title: "DECIDE", image: UIImage(systemName: "dice"), tag: 2)

        let mirrorVC = UINavigationController(rootViewController: MirrorViewController())
        mirrorVC.tabBarItem = UITabBarItem(title: "MIRROR", image: UIImage(systemName: "person.and.magnifyingglass"), tag: 3)

        let dreamsVC = UINavigationController(rootViewController: DreamsViewController())
        dreamsVC.tabBarItem = UITabBarItem(title: "DREAMS", image: UIImage(systemName: "sparkles"), tag: 4)

        viewControllers = [paradoxVC, encodeVC, decideVC, mirrorVC, dreamsVC]
        
        delegate = self
    }

    private func setupGamificationBanner() {
        let banner = GamificationBannerView()
        banner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(banner)
        
        NSLayoutConstraint.activate([
            banner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            banner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            banner.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        banner.onTap = { [weak self] in
            self?.showGamificationDetail()
        }
    }

    private func showGamificationDetail() {
        let detailVC = GamificationDetailViewController()
        present(detailVC, animated: true)
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}