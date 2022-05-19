//
//  ProfileViewCell.swift
//  Siniar
//
//  Created by yoga arie on 13/05/22.
//

import UIKit

protocol ProfileViewCellDelegate: NSObjectProtocol{
    func profileViewCellEditButtonTapped(_ cell: ProfileViewCell)
}

class ProfileViewCell: UITableViewCell {

    weak var profileImageView: UIImageView!
    weak var playlistTitleLabel: UILabel!
    weak var playlistLabel: UILabel!
    weak var followerTitleLabel: UILabel!
    weak var followerLabel: UILabel!
    weak var followingTitleLabel: UILabel!
    weak var followingLabel: UILabel!
    weak var editButton: SmallPrimaryButton!
    weak var delegate: ProfileViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(){
        backgroundColor = .clear
        selectionStyle = .none
        
        let screenWidth = UIScreen.main.bounds.width
        let lowestScreenWidth: CGFloat = 320.0
        
        let imageView = UIImageView(frame: .zero)
        contentView.addSubview(imageView)
        self.profileImageView = imageView
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: screenWidth > lowestScreenWidth ? 80 : 60),
            imageView.heightAnchor.constraint(equalToConstant: screenWidth > lowestScreenWidth ? 80 : 60),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
        
        if screenWidth > lowestScreenWidth {
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        }
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = screenWidth > lowestScreenWidth ? 16 : 12
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        ])
        
        let playlistStackView = UIStackView()
        playlistStackView.axis = .vertical
        playlistStackView.spacing = 4
        playlistStackView.alignment = .fill
        playlistStackView.distribution = .fill
        stackView.addArrangedSubview(playlistStackView)
        
        let playlistLabel = UILabel(frame: .zero)
        playlistStackView.addArrangedSubview(playlistLabel)
        self.playlistLabel = playlistLabel
        playlistLabel.textColor = UIColor.neutral1
        playlistLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        playlistLabel.textAlignment = .center
        playlistLabel.text = "22"
        
        let playlistTitleLabel = UILabel(frame: .zero)
        playlistStackView.addArrangedSubview(playlistTitleLabel)
        self.playlistTitleLabel = playlistTitleLabel
        playlistTitleLabel.textColor = UIColor.neutral1
        playlistTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        playlistTitleLabel.textAlignment = .center
        playlistTitleLabel.text = "Playlist"
        playlistTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        playlistTitleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 751), for: .horizontal)
        
        let followerStackView = UIStackView()
        followerStackView.axis = .vertical
        followerStackView.spacing = 4
        followerStackView.alignment = .fill
        followerStackView.distribution = .fill
        stackView.addArrangedSubview(followerStackView)
        
        let followerLabel = UILabel(frame: .zero)
        followerStackView.addArrangedSubview(followerLabel)
        self.followerLabel = followerLabel
        followerLabel.textColor = UIColor.neutral1
        followerLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        followerLabel.textAlignment = .center
        followerLabel.text = "360K"
        
        let followerTitleLabel = UILabel(frame: .zero)
        followerStackView.addArrangedSubview(followerTitleLabel)
        self.followerTitleLabel = followerTitleLabel
        followerTitleLabel.textColor = UIColor.neutral1
        followerTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        followerTitleLabel.textAlignment = .center
        followerTitleLabel.text = "Follower"
        followerTitleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        followerTitleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 750), for: .horizontal)
        
        let followingStackView = UIStackView()
        followingStackView.axis = .vertical
        followingStackView.spacing = 4
        followingStackView.alignment = .fill
        followingStackView.distribution = .fill
        stackView.addArrangedSubview(followingStackView)
        
        let followingLabel = UILabel(frame: .zero)
        followingStackView.addArrangedSubview(followingLabel)
        self.followingLabel = followingLabel
        followingLabel.textColor = UIColor.neutral1
        followingLabel.textAlignment = .center
        followingLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        followingLabel.text = "56"
        
        let followingTitleLabel = UILabel(frame: .zero)
        followingStackView.addArrangedSubview(followingTitleLabel)
        self.followingTitleLabel = followingTitleLabel
        followingTitleLabel.textColor = UIColor.neutral1
        followingTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        followingTitleLabel.textAlignment = .center
        followingTitleLabel.text = "Following"
        followingTitleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        followingTitleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 750), for: .horizontal)
        
        let editButton = SmallPrimaryButton()
        contentView.addSubview(editButton)
        self.editButton = editButton
        editButton.setTitle("Edit", for: .normal)
        editButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        editButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 24),
            editButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 12),
            editButton.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        if screenWidth <= lowestScreenWidth{
            editButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        }
        editButton.addTarget(self, action: #selector(self.editButtonTapped(_:)), for: .touchUpInside)
        
        
        
        
    }
    @objc func editButtonTapped(_ sender: Any){
        delegate?.profileViewCellEditButtonTapped(self)
    }

}
