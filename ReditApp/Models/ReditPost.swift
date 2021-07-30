import UIKit


struct ReditJSON: Codable {
    var data: ReditData?
}

struct ReditData: Codable {
    var children: [Child]?
    var after: String?
}

struct Child: Codable {
    var post: RedditPost?

    enum CodingKeys: String, CodingKey {
        case post = "data"
    }
}

struct RedditPost: Codable {
    var title: String?
    var subreddit: String?
    var author: String?
    
    var commentCount: Int?
    var ups: Int?
    var downs: Int?
    
    var thumbnail:String?
    var thumbnailWidth: CGFloat?
    var thumbnailHeight: CGFloat?
    
    
    enum CodingKeys: String, CodingKey {
        case title
        case subreddit = "subreddit_name_prefixed"
        case author = "author_fullname"
        
        case commentCount = "num_comments"
        case ups
        case downs
        
        case thumbnail
        case thumbnailWidth = "thumbnail_width"
        case thumbnailHeight = "thumbnail_height"
    }
}
