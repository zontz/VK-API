
import UIKit

final class FriendsVC: UIViewController {
    
    private lazy var friendsAPI = FriendsAPI()
    
    private lazy var friends = [Friend]()
    
    private lazy var tableView : UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.identifire)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        friendsAPI.fetchFriends { friends in
            self.friends = friends
            self.tableView.reloadData()
        }
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.pinEdgesToSuperView()

    }

}

extension FriendsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
}

extension FriendsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.identifire) as? FriendCell else {return UITableViewCell()}
        let friend = friends[indexPath.row]
       
        cell.configure(friend)
        return cell
    }
}
