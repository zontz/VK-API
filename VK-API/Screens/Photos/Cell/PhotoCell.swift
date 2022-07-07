import UIKit
import SDWebImage

final class PhotoCell: UICollectionViewCell {
    
    static let identifire = "PhotoCell"
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var photoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 8
        backView.clipsToBounds = true
        

        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = .zero
    }
    
    private func setupViews() {
        contentView.addSubview(backView)
        contentView.addSubview(photoImageView)
    }
    
    private func setupConstraints() {
        backView.pinEdgesToSuperView()
        
        NSLayoutConstraint.activate([
            photoImageView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 0),
            photoImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 0),
            photoImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: 0),
            photoImageView.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: 0)
            ])
    }
    
    func configure(_ photo:Photo) {
        photoImageView.sd_setImage(with: URL(string: photo.largePhotoURL))
    }
}
