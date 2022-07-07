
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
        
        let photoVC = PhotoVC()
        photoVC.tabBarItem.title = "Photos"
        photoVC.tabBarItem.image = UIImage(systemName: "photo")
        
        viewControllers = [friendsVC,groupsVC,photoVC]
        
    }

}
