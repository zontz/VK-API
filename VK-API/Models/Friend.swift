import Foundation

// MARK: - FriendsJSON
struct FriendsJSON: Codable {
    let response: FriendsResponse
}

// MARK: - Response
struct FriendsResponse: Codable {
    let count: Int
    let items: [Friend]
}

// MARK: - Item
struct Friend: Codable {
    let id: Int
    let isClosed: Bool?
    let trackCode: String
    let canAccessClosed: Bool?
    let onlineApp: Int?
    let bdate: String?
    let city: City?
    let firstName: String?
    let photo100: String
    let online: Int
    let onlineMobile: Int?
    let lastName: String?

    enum CodingKeys: String, CodingKey {
        case id
        case isClosed = "is_closed"
        case trackCode = "track_code"
        case canAccessClosed = "can_access_closed"
        case onlineApp = "online_app"
        case bdate, city
        case firstName = "first_name"
        case photo100 = "photo_100"
        case online
        case onlineMobile = "online_mobile"
        case lastName = "last_name"
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}
