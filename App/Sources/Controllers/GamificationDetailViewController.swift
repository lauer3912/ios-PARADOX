import UIKit

class GamificationDetailViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        view.backgroundColor = Theme.Colors.background.withAlphaComponent(0.95)
        
        let titleLabel = UILabel()
        titleLabel.text = "Your Progress"
        titleLabel.font = Theme.Fonts.bold(28)
        titleLabel.textColor = Theme.Colors.textPrimary
        titleLabel.textAlignment = .center
        
        let closeButton = UIButton(type: .system)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        closeButton.tintColor = Theme.Colors.textSecondary
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Spacing.md),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Theme.Spacing.md),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Spacing.md),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Theme.Spacing.lg),
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
    
    private func loadData() {
        let gamification = GamificationManager.shared
        let info = gamification.getXPLevelInfo()
        
        var previousAnchor = contentView.topAnchor
        
        let statsContainer = UIView()
        contentView.addSubview(statsContainer)
        statsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statsContainer.topAnchor.constraint(equalTo: previousAnchor, constant: Theme.Spacing.lg),
            statsContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.Spacing.md),
            statsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.Spacing.md)
        ])
        
        let levelCard = createStatCard(title: "Level", value: "\(info.level)", icon: "star.fill", color: Theme.Colors.gold)
        let xpCard = createStatCard(title: "Total XP", value: "\(info.currentXP)", icon: "bolt.fill", color: Theme.Colors.primary)
        let toolsCard = createStatCard(title: "Tools", value: "\(gamification.unlockedToolIds.count)/\(gamification.totalTools)", icon: "wrench.fill", color: Theme.Colors.secondary)
        
        statsContainer.addSubview(levelCard)
        statsContainer.addSubview(xpCard)
        statsContainer.addSubview(toolsCard)
        
        levelCard.translatesAutoresizingMaskIntoConstraints = false
        xpCard.translatesAutoresizingMaskIntoConstraints = false
        toolsCard.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            levelCard.topAnchor.constraint(equalTo: statsContainer.topAnchor),
            levelCard.leadingAnchor.constraint(equalTo: statsContainer.leadingAnchor),
            levelCard.widthAnchor.constraint(equalTo: statsContainer.widthAnchor, multiplier: 0.31),
            levelCard.heightAnchor.constraint(equalToConstant: 100),
            
            xpCard.topAnchor.constraint(equalTo: statsContainer.topAnchor),
            xpCard.leadingAnchor.constraint(equalTo: levelCard.trailingAnchor, constant: Theme.Spacing.sm),
            xpCard.widthAnchor.constraint(equalTo: statsContainer.widthAnchor, multiplier: 0.31),
            xpCard.heightAnchor.constraint(equalToConstant: 100),
            
            toolsCard.topAnchor.constraint(equalTo: statsContainer.topAnchor),
            toolsCard.leadingAnchor.constraint(equalTo: xpCard.trailingAnchor, constant: Theme.Spacing.sm),
            toolsCard.widthAnchor.constraint(equalTo: statsContainer.widthAnchor, multiplier: 0.31),
            toolsCard.heightAnchor.constraint(equalToConstant: 100),
            
            statsContainer.bottomAnchor.constraint(equalTo: levelCard.bottomAnchor)
        ])
        
        previousAnchor = statsContainer.bottomAnchor
        
        let progressSection = createProgressSection(info: info)
        contentView.addSubview(progressSection)
        progressSection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressSection.topAnchor.constraint(equalTo: previousAnchor, constant: Theme.Spacing.lg),
            progressSection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.Spacing.md),
            progressSection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.Spacing.md)
        ])
        
        previousAnchor = progressSection.bottomAnchor
        
        let tabBreakdown = createTabBreakdown()
        contentView.addSubview(tabBreakdown)
        tabBreakdown.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tabBreakdown.topAnchor.constraint(equalTo: previousAnchor, constant: Theme.Spacing.lg),
            tabBreakdown.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.Spacing.md),
            tabBreakdown.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.Spacing.md),
            tabBreakdown.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Theme.Spacing.lg)
        ])
    }
    
    private func createStatCard(title: String, value: String, icon: String, color: UIColor) -> UIView {
        let card = UIView()
        card.backgroundColor = Theme.Colors.cardBackground
        card.layer.cornerRadius = Theme.CornerRadius.md
        card.layer.borderWidth = 1
        card.layer.borderColor = color.withAlphaComponent(0.3).cgColor
        
        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = color
        iconView.contentMode = .scaleAspectFit
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = Theme.Fonts.bold(24)
        valueLabel.textColor = Theme.Colors.textPrimary
        valueLabel.textAlignment = .center
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = Theme.Fonts.regular(12)
        titleLabel.textColor = Theme.Colors.textSecondary
        titleLabel.textAlignment = .center
        
        card.addSubview(iconView)
        card.addSubview(valueLabel)
        card.addSubview(titleLabel)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: card.topAnchor, constant: Theme.Spacing.md),
            iconView.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            valueLabel.centerYAnchor.constraint(equalTo: card.centerYAnchor, constant: 8),
            valueLabel.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -Theme.Spacing.sm),
            titleLabel.centerXAnchor.constraint(equalTo: card.centerXAnchor)
        ])
        
        return card
    }
    
    private func createProgressSection(info: GamificationManager.XPLevelInfo) -> UIView {
        let section = UIView()
        section.backgroundColor = Theme.Colors.cardBackground
        section.layer.cornerRadius = Theme.CornerRadius.lg
        
        let titleLabel = UILabel()
        titleLabel.text = "Level Progress"
        titleLabel.font = Theme.Fonts.bold(16)
        titleLabel.textColor = Theme.Colors.textPrimary
        
        let progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.progress = info.progress
        progressBar.progressTintColor = Theme.Colors.primary
        progressBar.trackTintColor = Theme.Colors.locked
        progressBar.layer.cornerRadius = 6
        progressBar.clipsToBounds = true
        
        let levelLabel = UILabel()
        levelLabel.text = "Level \(info.level) → \(info.level + 1)"
        levelLabel.font = Theme.Fonts.mono(12)
        levelLabel.textColor = Theme.Colors.textSecondary
        
        section.addSubview(titleLabel)
        section.addSubview(progressBar)
        section.addSubview(levelLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: section.topAnchor, constant: Theme.Spacing.lg),
            titleLabel.leadingAnchor.constraint(equalTo: section.leadingAnchor, constant: Theme.Spacing.lg),
            
            progressBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Theme.Spacing.md),
            progressBar.leadingAnchor.constraint(equalTo: section.leadingAnchor, constant: Theme.Spacing.lg),
            progressBar.trailingAnchor.constraint(equalTo: section.trailingAnchor, constant: -Theme.Spacing.lg),
            progressBar.heightAnchor.constraint(equalToConstant: 12),
            
            levelLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: Theme.Spacing.sm),
            levelLabel.leadingAnchor.constraint(equalTo: section.leadingAnchor, constant: Theme.Spacing.lg),
            levelLabel.bottomAnchor.constraint(equalTo: section.bottomAnchor, constant: -Theme.Spacing.lg)
        ])
        
        return section
    }
    
    private func createTabBreakdown() -> UIView {
        let section = UIView()
        section.backgroundColor = Theme.Colors.cardBackground
        section.layer.cornerRadius = Theme.CornerRadius.lg
        
        let titleLabel = UILabel()
        titleLabel.text = "Tools by Category"
        titleLabel.font = Theme.Fonts.bold(16)
        titleLabel.textColor = Theme.Colors.textPrimary
        
        section.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: section.topAnchor, constant: Theme.Spacing.lg),
            titleLabel.leadingAnchor.constraint(equalTo: section.leadingAnchor, constant: Theme.Spacing.lg)
        ])
        
        var previousAnchor = titleLabel.bottomAnchor
        
        for tabType in TabType.allCases {
            let tools = ToolData.tools(for: tabType)
            let unlockedCount = tools.filter { GamificationManager.shared.isToolUnlocked($0.id) }.count
            
            let row = createBreakdownRow(title: tabType.title, unlocked: unlockedCount, total: tools.count, color: UIColor(hex: tabType.accentColor))
            section.addSubview(row)
            row.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                row.topAnchor.constraint(equalTo: previousAnchor, constant: Theme.Spacing.md),
                row.leadingAnchor.constraint(equalTo: section.leadingAnchor, constant: Theme.Spacing.lg),
                row.trailingAnchor.constraint(equalTo: section.trailingAnchor, constant: -Theme.Spacing.lg)
            ])
            
            previousAnchor = row.bottomAnchor
        }
        
        let bottomAnchor = section.subviews.last!.bottomAnchor
        NSLayoutConstraint.activate([
            section.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Theme.Spacing.lg)
        ])
        
        return section
    }
    
    private func createBreakdownRow(title: String, unlocked: Int, total: Int, color: UIColor) -> UIView {
        let row = UIView()
        
        let colorDot = UIView()
        colorDot.backgroundColor = color
        colorDot.layer.cornerRadius = 4
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = Theme.Fonts.medium(14)
        titleLabel.textColor = Theme.Colors.textPrimary
        
        let countLabel = UILabel()
        countLabel.text = "\(unlocked)/\(total)"
        countLabel.font = Theme.Fonts.mono(14)
        countLabel.textColor = Theme.Colors.textSecondary
        
        row.addSubview(colorDot)
        row.addSubview(titleLabel)
        row.addSubview(countLabel)
        
        colorDot.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorDot.leadingAnchor.constraint(equalTo: row.leadingAnchor),
            colorDot.centerYAnchor.constraint(equalTo: row.centerYAnchor),
            colorDot.widthAnchor.constraint(equalToConstant: 8),
            colorDot.heightAnchor.constraint(equalToConstant: 8),
            
            titleLabel.leadingAnchor.constraint(equalTo: colorDot.trailingAnchor, constant: Theme.Spacing.sm),
            titleLabel.centerYAnchor.constraint(equalTo: row.centerYAnchor),
            
            countLabel.trailingAnchor.constraint(equalTo: row.trailingAnchor),
            countLabel.centerYAnchor.constraint(equalTo: row.centerYAnchor),
            
            row.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        return row
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
}