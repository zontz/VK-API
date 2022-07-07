
import Foundation

final class FriendsAPI {
    
    func fetchFriends(completion: @escaping ([Friend])->()) {
        //safe
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userid)"),
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "count", value: "15"),
            URLQueryItem(name: "fields", value: "bdate,city,online,photo_100"),
            URLQueryItem(name: "access_token", value: Session.shared.accessToken),
            URLQueryItem(name: "v", value: Session.shared.version)
        ]
        
        guard let url = urlComponents.url else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let friendsJSON = try decoder.decode(FriendsJSON.self, from: data)
                let friends = friendsJSON.response.items
                DispatchQueue.main.async {
                    completion(friends)
                }
            } catch let error{
                print("Error serialization json",error)
            }
        }.resume()

    }
}
