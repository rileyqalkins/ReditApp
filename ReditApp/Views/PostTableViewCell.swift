import UIKit

class PostTableViewCell: UITableViewCell {
    let cellIdentifier = "PostTableViewCell"
    private let postTitleLabel = UILabel()
    private let lblUpScore = UILabel()
    private let lblDownScore = UILabel()
    private let commentNumberLabel = UILabel()
    
    private let subredditLabel = UILabel()
    private let usernameLabel = UILabel()
    
    private let thumbnailImageView = UIImageView()
    
    private let upArrowImage = UIImageView()
    private let downArrowImage = UIImageView()
    
    private let viewModel = PostViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundColor = .lightGray
        
        postTitleLabel.numberOfLines = 0
        postTitleLabel.font = .cardTitleFont
        commentNumberLabel.font = .commentFont
        lblUpScore.font = .scoreFont
        lblDownScore.font = .scoreFont
        subredditLabel.font = .commentFont
        usernameLabel.font = .commentFont
        
        thumbnailImageView.contentMode = .scaleAspectFit
        downArrowImage.image = UIImage(systemName: "arrow.down")
        downArrowImage.tintColor = .gray
        downArrowImage.contentMode = .scaleAspectFit
        
        upArrowImage.image = UIImage(systemName: "arrow.up")
        upArrowImage.tintColor = .gray
        upArrowImage.contentMode = .scaleAspectFit
        
        let headerInfoStackView = UIStackView(arrangedSubviews: [
            subredditLabel,
            usernameLabel
        ])
        
        let scoreStackView = UIStackView(arrangedSubviews: [
            upArrowImage,
            lblUpScore,
            downArrowImage,
            lblDownScore
        ])
        
        let horizontalStackView = UIStackView(arrangedSubviews: [
            scoreStackView,
            commentNumberLabel
        ])
        
        let stackView = UIStackView(arrangedSubviews: [
            headerInfoStackView,
            postTitleLabel,
            thumbnailImageView,
            horizontalStackView
        ])
        
        
        addSubview(backgroundView)
        backgroundView.addSubview(stackView)
        
        
        backgroundView.layer.cornerRadius = 5
        backgroundView.layer.masksToBounds = false
        
        // Constraints
        let padding = CGFloat(10)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: padding/2).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(padding/2)).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: padding).isActive = true
        stackView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: padding).isActive = true
        stackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -padding).isActive = true
        stackView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -padding).isActive = true

        headerInfoStackView.axis = .horizontal
        headerInfoStackView.distribution = .fillEqually
        headerInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        headerInfoStackView.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: padding).isActive = true
        headerInfoStackView.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -padding).isActive = true
        
        scoreStackView.axis = .horizontal
        scoreStackView.distribution = .fillProportionally
        scoreStackView.translatesAutoresizingMaskIntoConstraints = false
        scoreStackView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.3).isActive = true
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: padding).isActive = true
        horizontalStackView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -padding).isActive = true
        
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        thumbnailImageView.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        subredditLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        downArrowImage.translatesAutoresizingMaskIntoConstraints = false
        
        upArrowImage.translatesAutoresizingMaskIntoConstraints = false
        
        lblUpScore.translatesAutoresizingMaskIntoConstraints = false
        
        commentNumberLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(with post: RedditPost) {
        postTitleLabel.text = post.title
        
        subredditLabel.text = post.subreddit
        if let upScore = post.ups,
           let downScore = post.downs,
           let comments = post.commentCount,
           let author = post.author {
            
            let formattedUpScore = Double(upScore).truncatingRemainder(dividingBy: 100)
            let formattedDownScore = Double(downScore).truncatingRemainder(dividingBy: 100)
            lblUpScore.text = "\(formattedUpScore)k"
            lblDownScore.text = "\(formattedDownScore)k"
            commentNumberLabel.text = "\(comments) comments"
            usernameLabel.text = "u/" + author
        }
        
        viewModel.getImage(with: post.thumbnail) { [weak self] image in
            self?.thumbnailImageView.image = image
            self?.thumbnailImageView.widthAnchor.constraint(equalToConstant: post.thumbnailWidth ?? 0).isActive = true
            self?.thumbnailImageView.heightAnchor.constraint(equalToConstant: post.thumbnailHeight ?? 0).isActive = true
        }
    }
    
}
