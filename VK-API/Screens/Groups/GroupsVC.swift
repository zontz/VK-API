

import UIKit

final class GroupsVC: UIViewController {

    private lazy var groupAPI = GroupAPI()
    
    private lazy var groups = [Group]()
    
    private lazy var tableView : UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.identifire)
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        groupAPI.fetchGroups {groups in
            self.groups = groups
            self.tableView.reloadData()
        }
    }
    
    private func setupViews(){
        view.addSubview(tableView)
        tableView.pinEdgesToSuperView()
    }

}

extension GroupsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
}

extension GroupsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.identifire) as? GroupCell else {return UITableViewCell()}
        let group = groups[indexPath.row]
        cell.configure(group)
        return cell
    }
}
