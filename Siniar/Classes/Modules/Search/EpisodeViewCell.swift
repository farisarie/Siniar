//
//  EpisodeViewCell.swift
//  Siniar
//
//  Created by yoga arie on 16/05/22.
//

import UIKit

protocol EpisodeViewCellDelegate: NSObjectProtocol{
    func episodeViewCellPlayButtonTapped(_ cell: EpisodeViewCell)
}
class EpisodeViewCell: UITableViewCell {
    weak var episodeImageView: UIImageView!
    weak var dateLabel: UILabel!
    weak var titleLabel: UILabel!
    weak var subtitleLabel: UITextView!
    weak var playButton: UIButton!
    weak var durationLabel: UILabel!
    
    weak var delegate: EpisodeViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setupViews(){
        backgroundColor = .clear
        selectionStyle = .none
        
        let imageView = UIImageView(frame: .zero)
        contentView.addSubview(imageView)
        self.episodeImageView = imageView
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
        
        let bottomConstraint = imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        bottomConstraint.priority = .defaultLow
        bottomConstraint.isActive = true
        
        let dateLabel = UILabel(frame: .zero)
        contentView.addSubview(dateLabel)
        self.dateLabel = dateLabel
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        dateLabel.textColor = UIColor.neutral2
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
        
        let titleLabel = UILabel(frame: .zero)
        contentView.addSubview(titleLabel)
        self.titleLabel = titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        titleLabel.textColor = UIColor.neutral1
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8)
        ])
        
        let subtitleLabel = UITextView(frame: .zero)
        contentView.addSubview(subtitleLabel)
        self.subtitleLabel = subtitleLabel
        subtitleLabel.isScrollEnabled = false
        subtitleLabel.isEditable = false
        subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        subtitleLabel.textColor = UIColor.neutral2
        subtitleLabel.backgroundColor = .clear
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4)
        ])
        
        let stackView = UIStackView()
        contentView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
        ])
        
        let playButton = UIButton(type: .system)
        stackView.addArrangedSubview(playButton)
        self.playButton = playButton
        playButton.tintColor = UIColor.neutral1
        playButton.setImage(UIImage(named: "btn_play_small")?.withRenderingMode(.alwaysOriginal), for: .normal)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playButton.widthAnchor.constraint(equalToConstant: 18),
            playButton.heightAnchor.constraint(equalToConstant: 18)
        ])
        playButton.addTarget(self, action: #selector(self.playButtonTapped(_:)), for: .touchUpInside)
        
        let durationLabel = UILabel(frame: .zero)
        stackView.addArrangedSubview(durationLabel)
        self.durationLabel = durationLabel
        durationLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        durationLabel.textColor = UIColor.neutral1
    }
    
    @objc func playButtonTapped(_ sender: Any) {
        delegate?.episodeViewCellPlayButtonTapped(self)
    }

}
