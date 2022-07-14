
import UIKit

enum PostCellType : Int,CaseIterable {
    
    case author = 0
    case text
    case photo
    case likeCount
   
}

final class NewsFeedVC: UIViewController {

      private lazy var newsAPI = NewsAPI()

      private lazy var posts = [PostCellModel]()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.register(PostAuthorCell.self, forCellReuseIdentifier: PostAuthorCell.identifire)
        tableView.register(PostTextCell.self, forCellReuseIdentifier: PostTextCell.identifire)
        tableView.register(PostPhotoCell.self, forCellReuseIdentifier: PostPhotoCell.identifire)
        tableView.register(PostLikeCell.self, forCellReuseIdentifier: PostLikeCell.identifire)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        newsAPI.fetchNews { posts in
            self.posts = posts
            self.tableView.reloadData()
        }
    }
    
    private func setupViews(){
        view.addSubview(tableView)
        tableView.pinEdgesToSuperView()
    }
    
}

extension NewsFeedVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}

extension NewsFeedVC: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostCellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let postCellType = PostCellType(rawValue: indexPath.row)
        let post = posts[indexPath.section]

        switch postCellType {
        case .author:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostAuthorCell.identifire, for: indexPath) as! PostAuthorCell
            cell.configure(post)
            return cell
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostTextCell.identifire, for: indexPath) as! PostTextCell
            cell.configure(post)
            return cell
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostPhotoCell.identifire, for: indexPath) as! PostPhotoCell
            cell.configure(post)
            return cell
        case .likeCount:
            let cell = tableView.dequeueReusableCell(withIdentifier: PostLikeCell.identifire, for: indexPath) as! PostLikeCell
            cell.configure(post)
            return cell
        default:
           return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let postCellType = PostCellType(rawValue: indexPath.row)
        let post = posts[indexPath.section]

        switch postCellType {
        case .author:
            return UITableView.automaticDimension
        case .text:
            return post.text.isEmpty ? 0 : UITableView.automaticDimension
        case .photo:
            return post.photoURL.isEmpty ? 0 : UITableView.automaticDimension
        case .likeCount:
            return UITableView.automaticDimension
        default:
            return 0
        }

    }

}
