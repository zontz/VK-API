import UIKit
import SDWebImage
import Foundation

final class GroupCell: UITableViewCell {
    
    static let identifire = "GroupCell"
    
    private lazy var statusLabel:UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.font = label.font.withSize(10)
        label.textColor = .gray
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var membersCountLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.font = label.font.withSize(10)
        label.textColor = .gray
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        label.font = label.font.withSize(13)
        return label
    }()
    
    private lazy var photoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
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
    
    private func setupViews() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(membersCountLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            photoImageView.heightAnchor.constraint(equalToConstant: 80),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -50),
            nameLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            statusLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 40),
            statusLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            membersCountLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            membersCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            membersCountLabel.topAnchor.constraint(equalTo: statusLabel.topAnchor, constant: 40),
            membersCountLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 16)
        ])
    }
    
    func configure(_ group:Group) {
        photoImageView.sd_setImage(with: URL(string: group.photo100))
        nameLabel.text = group.name
        statusLabel.text = group.status
        membersCountLabel.text = membersCountDisplay(group.membersCount) + " " + "подписчика"
    }
    
    private func membersCountDisplay(_ value:Int)->String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.groupingSize = 3
        return String((formatter.string(for: value) ?? ""))
    }
}
