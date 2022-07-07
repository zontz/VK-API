
import Foundation

final class GroupAPI {
    
    func fetchGroups(completion: @escaping ([Group])->()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userid)"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "status,photo_100,members_count"),
            URLQueryItem(name: "access_token", value: Session.shared.accessToken),
            URLQueryItem(name: "v", value: Session.shared.version)
        ]
        
        guard let url = urlComponents.url else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let groupsJSON = try decoder.decode(GroupsJSON.self, from: data)
                let groups = groupsJSON.response.items
                DispatchQueue.main.async {
                    completion(groups)
                }
            }catch let  error {
                print(error,"Error Serilization")
            }
        
        }.resume()
        
    }
}
