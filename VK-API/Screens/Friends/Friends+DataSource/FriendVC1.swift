import UIKit

final class FriendDataSource: NSObject,UITableViewDataSource,UITableViewDelegate {
    
    private lazy var dataSource = [Friend]()
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.identifire) as? FriendCell else {return UITableViewCell()}
        let friend = dataSource[indexPath.row]
        cell.configure(friend)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func update(_ friends:[Friend]) {
        dataSource = friends
    
    }
    
}


final class FriendVC1: UIViewController {
    
    private lazy var dataSource = FriendDataSource()
    
    private lazy var tableView : UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.identifire)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            //self.dataSource.update([Friend(name: "123", image: "me")])
            self.tableView.reloadData()
        })

    }
    
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.pinEdgesToSuperView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

}


