
import UIKit

final class MainTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let friendsVC = FriendsVC()
        friendsVC.tabBarItem.title = "Friends"
        friendsVC.tabBarItem.image = UIImage(systemName: "person")
        
        let groupsVC = GroupsVC()
        groupsVC.tabBarItem.title = "Groups"
        groupsVC.tabBarItem.image = UIImage(systemName: "person.3")
        
        let photosVC = PhotoVC()
        photosVC.tabBarItem.title = "Photos"
        photosVC.tabBarItem.image = UIImage(systemName: "photo")
        
        let newsVC = NewsFeedVC()
        newsVC.tabBarItem.title = "News"
        newsVC.tabBarItem.image = UIImage(systemName: "newspaper")
        
        viewControllers = [friendsVC,groupsVC,photosVC,newsVC]
        
    }
}
