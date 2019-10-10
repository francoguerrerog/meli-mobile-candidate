import UIKit

class HeaderView: UIView {
    
    var filterButton: UIButton!
    
    init(height: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        
        setupHeaderView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHeaderView() {
        filterButton = UIButton(type: .system)
        filterButton.setTitle("Filter >", for: .normal)
        filterButton.titleLabel!.font = .systemFont(ofSize: 14, weight: .light)
        filterButton.titleLabel!.textColor = .blue
        self.addSubview(filterButton)
        
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: filterButton!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -25).isActive = true
        NSLayoutConstraint(item: filterButton!, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: filterButton!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.2, constant: 0).isActive = true
        
    }
}
