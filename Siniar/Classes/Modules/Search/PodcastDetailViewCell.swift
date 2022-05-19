//
//  PodcastDetailViewCell.swift
//  Siniar
//
//  Created by yoga arie on 16/05/22.
//

import UIKit

class PodcastDetailViewCell: UITableViewCell {

    weak var artworkImageView: UIImageView!
    weak var titleLabel: UILabel!
    weak var subtitleLabel: UILabel!
    weak var descLabel: UILabel!
    weak var genreLabel: UILabel!
    
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
        selectionStyle = .none
        backgroundColor = UIColor.clear
        
        let imageView = UIImageView(frame: .zero)
        contentView.addSubview(imageView)
        self.artworkImageView = imageView
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 44)
        ])
        
        let titleLabel = UILabel(frame: .zero)
        contentView.addSubview(titleLabel)
        self.titleLabel = titleLabel
        titleLabel.textColor = UIColor.neutral1
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24)
        ])
        
        let subtitleLabel = UILabel(frame: .zero)
        contentView.addSubview(subtitleLabel)
        self.subtitleLabel = subtitleLabel
        subtitleLabel.textColor = UIColor.neutral2
        subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = 0
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -48),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        ])
        
        let descLabel = UILabel(frame: .zero)
        contentView.addSubview(descLabel)
        self.descLabel = descLabel
        descLabel.textColor = UIColor.neutral1
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descLabel.textAlignment = .left
        descLabel.numberOfLines = 0
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            descLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 24)
        ])
        
        let genreLabel = UILabel(frame: .zero)
        contentView.addSubview(genreLabel)
        self.genreLabel = genreLabel
        genreLabel.textColor = UIColor.neutral2
        genreLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        genreLabel.textAlignment = .left
        genreLabel.numberOfLines = 1
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            genreLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 16),
            genreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }

}
