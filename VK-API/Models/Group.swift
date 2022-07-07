import Foundation

// MARK: - GroupsJSOn
struct GroupsJSON: Codable {
    let response: GroupsResponse
}

// MARK: - Response
struct GroupsResponse: Codable {
    let count: Int
    let items: [Group]
}

// MARK: - Item
struct Group: Codable {
    let status: String
    let isMember, membersCount, id: Int
    let photo100: String
    let isAdvertiser, isAdmin: Int
    let type, screenName, name: String
    let isClosed: Int

    enum CodingKeys: String, CodingKey {
        case status
        case isMember = "is_member"
        case membersCount = "members_count"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}
