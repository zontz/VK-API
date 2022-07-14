
import UIKit
import SDWebImage

final class PostPhotoCell: UITableViewCell {
    
    static let identifire = "PostPhotoCell"
    
    private lazy var photosImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        photosImageView.image = nil
    }
    
    private func setupViews() {
        contentView.addSubview(photosImageView)
    }
    
    private func setupConstraints() {
        photosImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.width.height.equalTo(contentView.snp.width)
        }
    }
    
    
    func configure(_ cellModel: PostCellModel) {
        let photoURL = cellModel.photoURL
        photosImageView.sd_setImage(with: URL(string : photoURL))
    }
}
