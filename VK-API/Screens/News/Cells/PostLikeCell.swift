

import UIKit

final class PostLikeCell: UITableViewCell {
    
    static let identifire = "PostLikeCell"
    
    private lazy var separatorView : UIView = {
       var view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.5)
        return view
    }()
    private lazy var likeCountLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.font = label.font.withSize(10)
        label.textColor = .gray
        return label
    }()
    
    override func prepareForReuse() {
        likeCountLabel.text = nil
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
        contentView.addSubview(likeCountLabel)
        contentView.addSubview(separatorView)
    }
    
    private func setupConstraints() {
        likeCountLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(16)
        }
        separatorView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(likeCountLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(15)
            make.height.equalTo(8)
        }
    }
    
    
    func configure(_ cellModel: PostCellModel) {
        likeCountLabel.text = "❤️ \(cellModel.likesCount)"
    }
}
