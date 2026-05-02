import UIKit

class ParadoxHomeViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var toolCards: [ToolCardView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        loadTools()
    }
    
    private func setupNavigation() {
        title = "PARADOX"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupUI() {
        view.backgroundColor = Theme.Colors.background
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func loadTools() {
        let tools = ToolData.tools(for: .paradox)
        
        let heroCard = createHeroCard()
        contentView.addSubview(heroCard)
        heroCard.translatesAutoresizingMaskIntoConstraints = false
        
        let heroConstraints = [
            heroCard.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Theme.Spacing.lg),
            heroCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.Spacing.md),
            heroCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.Spacing.md),
            heroCard.heightAnchor.constraint(equalToConstant: 180)
        ]
        
        var previousAnchor = heroCard.bottomAnchor
        
        let titleLabel = UILabel()
        titleLabel.text = "Reality Bending Tools"
        titleLabel.font = Theme.Fonts.bold(18)
        titleLabel.textColor = Theme.Colors.textPrimary
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: previousAnchor, constant: Theme.Spacing.lg),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.Spacing.md)
        ])
        
        previousAnchor = titleLabel.bottomAnchor
        
        let gridContainer = UIView()
        contentView.addSubview(gridContainer)
        gridContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gridContainer.topAnchor.constraint(equalTo: previousAnchor, constant: Theme.Spacing.md),
            gridContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.Spacing.md),
            gridContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.Spacing.md),
            gridContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Theme.Spacing.lg)
        ])
        
        let columns = 2
        var currentRow = 0
        var currentCol = 0
        var cellViews: [UIView] = []
        
        for (index, tool) in tools.enumerated() {
            let card = ToolCardView(tool: tool)
            card.onTap = { [weak self] in
                self?.openTool(tool)
            }
            gridContainer.addSubview(card)
            card.translatesAutoresizingMaskIntoConstraints = false
            toolCards.append(card)
            
            let row = index / columns
            let col = index % columns
            
            let cardWidth = (UIScreen.main.bounds.width - Theme.Spacing.md * 3) / CGFloat(columns)
            
            NSLayoutConstraint.activate([
                card.topAnchor.constraint(equalTo: gridContainer.topAnchor, constant: CGFloat(row) * (cardWidth * 0.6 + Theme.Spacing.md)),
                card.leadingAnchor.constraint(equalTo: gridContainer.leadingAnchor, constant: CGFloat(col) * (cardWidth + Theme.Spacing.md)),
                card.widthAnchor.constraint(equalToConstant: cardWidth),
                card.heightAnchor.constraint(equalToConstant: cardWidth * 0.6)
            ])
        }
        
        NSLayoutConstraint.activate(heroConstraints)
    }
    
    private func createHeroCard() -> UIView {
        let card = UIView()
        card.backgroundColor = Theme.Colors.cardBackground
        card.layer.cornerRadius = Theme.CornerRadius.lg
        card.layer.borderWidth = 1
        card.layer.borderColor = Theme.Colors.primary.withAlphaComponent(0.3).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            Theme.Colors.primary.withAlphaComponent(0.3).cgColor,
            Theme.Colors.secondary.withAlphaComponent(0.1).cgColor
        ]
        gradientLayer.cornerRadius = Theme.CornerRadius.lg
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        card.layer.insertSublayer(gradientLayer, at: 0)
        
        let titleLabel = UILabel()
        titleLabel.text = "Reality Bender"
        titleLabel.font = Theme.Fonts.bold(28)
        titleLabel.textColor = Theme.Colors.textPrimary
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Unlock all 75 tools to become a Paradox Master"
        subtitleLabel.font = Theme.Fonts.regular(14)
        subtitleLabel.textColor = Theme.Colors.textSecondary
        
        let progressLabel = UILabel()
        let gamification = GamificationManager.shared
        progressLabel.text = "\(gamification.unlockedToolIds.count)/\(gamification.totalTools) Tools Unlocked"
        progressLabel.font = Theme.Fonts.mono(12)
        progressLabel.textColor = Theme.Colors.gold
        
        card.addSubview(titleLabel)
        card.addSubview(subtitleLabel)
        card.addSubview(progressLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: Theme.Spacing.lg),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: Theme.Spacing.lg),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Theme.Spacing.sm),
            subtitleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: Theme.Spacing.lg),
            subtitleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -Theme.Spacing.lg),
            
            progressLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -Theme.Spacing.lg),
            progressLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: Theme.Spacing.lg)
        ])
        
        DispatchQueue.main.async {
            gradientLayer.frame = card.bounds
        }
        
        return card
    }
    
    private func openTool(_ tool: Tool) {
        let toolVC = ToolDetailViewController(tool: tool)
        navigationController?.pushViewController(toolVC, animated: true)
    }
}