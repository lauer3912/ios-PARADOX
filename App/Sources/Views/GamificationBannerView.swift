import UIKit

class GamificationBannerView: UIView {
    
    var onTap: (() -> Void)?
    
    private let levelLabel = UILabel()
    private let xpLabel = UILabel()
    private let progressBar = UIProgressView()
    private let toolsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = Theme.Colors.backgroundLight.withAlphaComponent(0.95)
        
        levelLabel.font = Theme.Fonts.bold(14)
        levelLabel.textColor = Theme.Colors.primary
        levelLabel.text = "Level 1"
        
        xpLabel.font = Theme.Fonts.mono(12)
        xpLabel.textColor = Theme.Colors.gold
        xpLabel.text = "XP: 0"
        
        progressBar.progressTintColor = Theme.Colors.primary
        progressBar.trackTintColor = Theme.Colors.locked
        progressBar.layer.cornerRadius = 4
        progressBar.clipsToBounds = true
        
        toolsLabel.font = Theme.Fonts.regular(11)
        toolsLabel.textColor = Theme.Colors.textSecondary
        toolsLabel.text = "0/75 Tools"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
        
        addSubview(levelLabel)
        addSubview(xpLabel)
        addSubview(progressBar)
        addSubview(toolsLabel)
        
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        xpLabel.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        toolsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            levelLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.Spacing.md),
            levelLabel.topAnchor.constraint(equalTo: topAnchor, constant: Theme.Spacing.sm),
            
            xpLabel.leadingAnchor.constraint(equalTo: levelLabel.trailingAnchor, constant: Theme.Spacing.md),
            xpLabel.centerYAnchor.constraint(equalTo: levelLabel.centerYAnchor),
            
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.Spacing.md),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.Spacing.md),
            progressBar.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: Theme.Spacing.xs),
            progressBar.heightAnchor.constraint(equalToConstant: 8),
            
            toolsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.Spacing.md),
            toolsLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: Theme.Spacing.xs),
            toolsLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -Theme.Spacing.xs)
        ])
        
        updateDisplay()
    }
    
    @objc private func handleTap() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = .identity
            }
        }
        onTap?()
    }
    
    func updateDisplay() {
        let gamification = GamificationManager.shared
        let info = gamification.getXPLevelInfo()
        
        levelLabel.text = "Level \(info.level)"
        xpLabel.text = "XP: \(info.currentXP)"
        progressBar.progress = info.progress
        toolsLabel.text = "\(gamification.unlockedToolIds.count)/\(gamification.totalTools) Tools"
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        updateDisplay()
    }
}