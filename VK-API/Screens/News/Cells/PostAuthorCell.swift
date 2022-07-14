
import UIKit

final class PostAuthorCell: UITableViewCell {

    static let identifire = "PostAuthorCell"

    private lazy var photoImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = label.font.withSize(12)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    override func prepareForReuse() {
        photoImageView.image = nil
        nameLabel.text = nil
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(photoImageView)
    }

    private func setupConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.top.bottom.equalToSuperview().inset(5)
            make.left.equalToSuperview().inset(16)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(photoImageView.snp.right).offset(16)
            make.right.equalToSuperview().inset(16)
        }
    }
    func configure(_ cellModel: PostCellModel) {
        let photoURL = cellModel.authorImageURL
        photoImageView.sd_setImage(with: URL(string: photoURL))
        nameLabel.text  = cellModel.authorName
    
    }
}
