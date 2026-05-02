import UIKit

class EncodeViewController: UIViewController {
    
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
        title = "ENCODE"
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
        let tools = ToolData.tools(for: .encode)
        createToolGrid(tools: tools, in: contentView)
    }
    
    private func createToolGrid(tools: [Tool], in container: UIView) {
        let titleLabel = UILabel()
        titleLabel.text = "Encryption & Decoding Tools"
        titleLabel.font = Theme.Fonts.bold(18)
        titleLabel.textColor = Theme.Colors.textPrimary
        container.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: Theme.Spacing.lg),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Theme.Spacing.md)
        ])
        
        let gridContainer = UIView()
        container.addSubview(gridContainer)
        gridContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gridContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Theme.Spacing.md),
            gridContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: Theme.Spacing.md),
            gridContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -Theme.Spacing.md),
            gridContainer.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -Theme.Spacing.lg)
        ])
        
        let columns = 2
        let cardWidth = (UIScreen.main.bounds.width - Theme.Spacing.md * 3) / CGFloat(columns)
        
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
            
            NSLayoutConstraint.activate([
                card.topAnchor.constraint(equalTo: gridContainer.topAnchor, constant: CGFloat(row) * (cardWidth * 0.6 + Theme.Spacing.md)),
                card.leadingAnchor.constraint(equalTo: gridContainer.leadingAnchor, constant: CGFloat(col) * (cardWidth + Theme.Spacing.md)),
                card.widthAnchor.constraint(equalToConstant: cardWidth),
                card.heightAnchor.constraint(equalToConstant: cardWidth * 0.6)
            ])
        }
    }
    
    private func openTool(_ tool: Tool) {
        let toolVC = ToolDetailViewController(tool: tool)
        navigationController?.pushViewController(toolVC, animated: true)
    }
}