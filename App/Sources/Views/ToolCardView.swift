import UIKit

class ToolCardView: UIView {
    
    var onTap: (() -> Void)?
    
    private let tool: Tool
    
    private let iconLabel = UILabel()
    private let nameLabel = UILabel()
    private let xpLabel = UILabel()
    private let lockOverlay = UIView()
    private let lockIcon = UIImageView()
    
    init(tool: Tool) {
        self.tool = tool
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = Theme.CornerRadius.md
        layer.borderWidth = 1
        
        updateAppearance()
        
        iconLabel.font = .systemFont(ofSize: 32)
        iconLabel.textAlignment = .center
        
        nameLabel.font = Theme.Fonts.semibold(14)
        nameLabel.textColor = Theme.Colors.textPrimary
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        
        xpLabel.font = Theme.Fonts.mono(11)
        xpLabel.textAlignment = .center
        
        lockOverlay.backgroundColor = Theme.Colors.locked.withAlphaComponent(0.7)
        lockOverlay.isHidden = true
        lockOverlay.layer.cornerRadius = Theme.CornerRadius.md
        
        lockIcon.image = UIImage(systemName: "lock.fill")
        lockIcon.tintColor = Theme.Colors.textSecondary
        lockIcon.contentMode = .scaleAspectFit
        
        addSubview(iconLabel)
        addSubview(nameLabel)
        addSubview(xpLabel)
        addSubview(lockOverlay)
        lockOverlay.addSubview(lockIcon)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        xpLabel.translatesAutoresizingMaskIntoConstraints = false
        lockOverlay.translatesAutoresizingMaskIntoConstraints = false
        lockIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconLabel.topAnchor.constraint(equalTo: topAnchor, constant: Theme.Spacing.md),
            iconLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconLabel.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: Theme.Spacing.sm),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Theme.Spacing.sm),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Theme.Spacing.sm),
            
            xpLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Theme.Spacing.sm),
            xpLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            lockOverlay.topAnchor.constraint(equalTo: topAnchor),
            lockOverlay.leadingAnchor.constraint(equalTo: leadingAnchor),
            lockOverlay.trailingAnchor.constraint(equalTo: trailingAnchor),
            lockOverlay.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            lockIcon.centerXAnchor.constraint(equalTo: lockOverlay.centerXAnchor),
            lockIcon.centerYAnchor.constraint(equalTo: lockOverlay.centerYAnchor),
            lockIcon.widthAnchor.constraint(equalToConstant: 24),
            lockIcon.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    private func updateAppearance() {
        let isUnlocked = GamificationManager.shared.isToolUnlocked(tool.id)
        
        if isUnlocked {
            backgroundColor = Theme.Colors.cardBackground
            layer.borderColor = Theme.Colors.primary.withAlphaComponent(0.3).cgColor
            iconLabel.text = tool.icon
            nameLabel.text = tool.name
            xpLabel.text = "+\(tool.xpReward) XP"
            xpLabel.textColor = Theme.Colors.gold
            lockOverlay.isHidden = true
        } else {
            backgroundColor = Theme.Colors.locked.withAlphaComponent(0.2)
            layer.borderColor = Theme.Colors.locked.cgColor
            iconLabel.text = "🔒"
            nameLabel.text = tool.name
            xpLabel.text = "+\(tool.xpReward) XP"
            xpLabel.textColor = Theme.Colors.locked
            lockOverlay.isHidden = false
        }
    }
    
    @objc private func handleTap() {
        let isUnlocked = GamificationManager.shared.isToolUnlocked(tool.id)
        
        if isUnlocked {
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    self.transform = .identity
                }
            }
            
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
            onTap?()
        } else {
            let alert = UIAlertController(
                title: "Tool Locked",
                message: "You need more XP to unlock \(tool.name). Keep using PARADOX to earn more XP!",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            if letvc = findViewController() {
                vc.present(alert, animated: true)
            }
        }
    }
    
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let vc = nextResponder as? UIViewController {
                return vc
            }
            responder = nextResponder
        }
        return nil
    }
}