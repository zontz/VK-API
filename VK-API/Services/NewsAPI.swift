
import Foundation


class NewsAPI {
    func fetchNews (_ completion: @escaping ([PostCellModel])->()) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.accessToken),
            URLQueryItem(name: "count", value: "20"),
            //URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "v", value: Session.shared.version)
        ]

        guard let url = urlComponents.url else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, _ in
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let postsJSON = try decoder.decode(PostJSON.self, from: data)
                let postsItems = postsJSON.response?.items ?? []
                let postProfiles = postsJSON.response?.profiles ?? []
                let postGroups = postsJSON.response?.groups ?? []
                var cellModels = [PostCellModel]()
                
                for item in postsItems {
                    if item.postType != "post" {
                        continue
                    }
                    var authorName = ""
                    var authorImageURL = ""
                    var text = ""
                    var photoURL = ""
                    var likesCount = 0
                    if let sourceID = item.sourceID {
                        if sourceID  < 0 {
                            let group = postGroups.first { $0.id == abs(sourceID)}
                            authorName = group?.name ?? ""
                            authorImageURL = group?.photo100 ?? ""
                        } else {
                            let profile = postProfiles.first {$0.id == sourceID}
                            authorName = (profile?.firstName ?? "") + " "  + (profile?.lastName ?? "")
                            authorImageURL = profile?.photo100 ?? ""
                        }
                        text = item.text ?? ""
                        photoURL = item.attachments?.first?.photo?.largePhotoURL ?? ""
                        likesCount = item.likes?.count ?? 0
                    }
                    
                    let cellModel = PostCellModel(authorName: authorName, authorImageURL: authorImageURL, text: text, photoURL: photoURL, likesCount: likesCount)
                    cellModels.append(cellModel)
                    
                }
                
                DispatchQueue.main.async {
                    completion(cellModels)
                }
                
            }catch let error {
                print("Error Serilization",error)
            }

        }.resume()
    }
}
