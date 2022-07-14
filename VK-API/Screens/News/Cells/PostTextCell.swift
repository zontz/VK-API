
import UIKit
import SnapKit

final class PostTextCell: UITableViewCell {
    
    static let identifire = "PostTextCell"
    
    private lazy var postTextLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = label.font.withSize(12)
        return label
    }()
    
    override func prepareForReuse() {
        postTextLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(postTextLabel)
    }
    
    private func setupConstraints() {
        postTextLabel.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview().inset(16)
        }
    }
    
    func configure(_ cellModel: PostCellModel) {
        postTextLabel.text = cellModel.text
    }
    
}
