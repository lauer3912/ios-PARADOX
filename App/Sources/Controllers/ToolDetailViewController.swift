import UIKit

class ToolDetailViewController: UIViewController {
    
    private let tool: Tool
    
    init(tool: Tool) {
        self.tool = tool
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let iconLabel = UILabel()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let xpLabel = UILabel()
    private let actionButton = UIButton(type: .system)
    private let contentTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureWithTool()
    }
    
    private func setupUI() {
        view.backgroundColor = Theme.Colors.background
        title = tool.name
        
        navigationController?.navigationBar.tintColor = Theme.Colors.primary
        
        iconLabel.font = .systemFont(ofSize: 64)
        iconLabel.textAlignment = .center
        
        nameLabel.font = Theme.Fonts.bold(24)
        nameLabel.textColor = Theme.Colors.textPrimary
        nameLabel.textAlignment = .center
        
        descriptionLabel.font = Theme.Fonts.regular(16)
        descriptionLabel.textColor = Theme.Colors.textSecondary
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        xpLabel.font = Theme.Fonts.mono(16)
        xpLabel.textColor = Theme.Colors.gold
        xpLabel.textAlignment = .center
        
        contentTextView.backgroundColor = Theme.Colors.cardBackground
        contentTextView.textColor = Theme.Colors.textPrimary
        contentTextView.font = Theme.Fonts.mono(14)
        contentTextView.layer.cornerRadius = Theme.CornerRadius.md
        contentTextView.textContainerInset = UIEdgeInsets(top: 16, left: 12, bottom: 16, right: 12)
        contentTextView.isEditable = false
        
        actionButton.setTitle("Use Tool", for: .normal)
        actionButton.titleLabel?.font = Theme.Fonts.bold(18)
        actionButton.backgroundColor = Theme.Colors.primary
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.layer.cornerRadius = Theme.CornerRadius.md
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        view.addSubview(iconLabel)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(xpLabel)
        view.addSubview(contentTextView)
        view.addSubview(actionButton)
        
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        xpLabel.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Theme.Spacing.xl),
            iconLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: iconLabel.bottomAnchor, constant: Theme.Spacing.md),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Theme.Spacing.lg),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Theme.Spacing.lg),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Theme.Spacing.sm),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Theme.Spacing.lg),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Theme.Spacing.lg),
            
            xpLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Theme.Spacing.md),
            xpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            contentTextView.topAnchor.constraint(equalTo: xpLabel.bottomAnchor, constant: Theme.Spacing.lg),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Theme.Spacing.md),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Theme.Spacing.md),
            contentTextView.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -Theme.Spacing.md),
            
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Theme.Spacing.lg),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Theme.Spacing.lg),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Theme.Spacing.lg),
            actionButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func configureWithTool() {
        iconLabel.text = tool.icon
        nameLabel.text = tool.name
        descriptionLabel.text = tool.description
        xpLabel.text = "+\(tool.xpReward) XP"
        contentTextView.text = getPlaceholderContent(for: tool)
    }
    
    private func getPlaceholderContent(for tool: Tool) -> String {
        switch tool.id {
        case 10: return "Enter your secret message...\n\nResult will appear here"
        case 30: return "Option 1: ___________\nOption 2: ___________\n\nTap the button to decide!"
        case 45: return "Select a photo to compare before/after..."
        case 55: return "Describe your dream scenario...\n\nThe AI will generate a surreal image"
        default: return "This tool demonstrates the \((tool.name)) feature.\n\nMore features coming soon!"
        }
    }
    
    @objc private func actionButtonTapped() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.actionButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.actionButton.transform = .identity
            }
        }
        
        showToast("+\(tool.xpReward) XP earned!")
    }
    
    private func showToast(_ message: String) {
        let toast = UILabel()
        toast.text = message
        toast.font = Theme.Fonts.bold(16)
        toast.textColor = .white
        toast.backgroundColor = Theme.Colors.success
        toast.textAlignment = .center
        toast.layer.cornerRadius = 20
        toast.clipsToBounds = true
        toast.alpha = 0
        
        view.addSubview(toast)
        toast.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toast.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toast.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            toast.widthAnchor.constraint(equalToConstant: 150),
            toast.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        UIView.animate(withDuration: 0.3, animations: {
            toast.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 1.5, options: [], animations: {
                toast.alpha = 0
            }) { _ in
                toast.removeFromSuperview()
            }
        }
    }
}