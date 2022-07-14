import UIKit
import SDWebImage

final class FriendCell: UITableViewCell {
    
    static let identifier = "FriendCell"
    
    
    private lazy var nameLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.font = label.font.withSize(15)
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.font = label.font.withSize(10)
        label.textColor = .gray
        return label
    }()
    
    private lazy var photoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
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
    
    //MARK: - public methods
    func configure(_ friend:Friend){
        nameLabel.text = (friend.firstName ?? "") + " " + (friend.lastName ?? "")
        photoImageView.sd_setImage(with: URL(string: friend.photo100))
        cityLabel.text = (friend.city?.title ?? "Скрыт") + ", " + (friend.online != 0 ? "online" : "offline")
    }
    
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(photoImageView)
        contentView.addSubview(cityLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            photoImageView.heightAnchor.constraint(equalToConstant: 80),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        NSLayoutConstraint.activate([
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            nameLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            cityLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 16),
            cityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            cityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -45),
            cityLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 16)
        ])
    }
    
}
