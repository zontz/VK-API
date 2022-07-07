
import Foundation

final class PhotoAPI {
    func fetchPhotos(_ completion: @escaping ([Photo])->()){
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(Session.shared.userid)"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "access_token", value: Session.shared.accessToken),
            URLQueryItem(name: "v", value: Session.shared.version)
        ]
        
        guard let url = urlComponents.url else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let photoJSON = try decoder.decode(PhotoJSON.self, from: data)
                let photos = photoJSON.response.items
                DispatchQueue.main.async {
                    completion(photos)
                }
            }catch let error{
                print("Error Serilization",error)
            }
            
        }.resume()
        
    }
}


