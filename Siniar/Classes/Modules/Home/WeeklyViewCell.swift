//
//  WeeklyViewCell.swift
//  Siniar
//
//  Created by yoga arie on 11/05/22.
//

import UIKit

class WeeklyViewCell: UITableViewCell {

    weak var titleLabel: UILabel!
    weak var thumbImageView: UIImageView!
    weak var nameLabel: UILabel!
    weak var descLabel: UILabel!
    
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
        
        let label = UILabel(frame: .zero)
        contentView.addSubview(label)
        self.titleLabel = label
        label.textColor = .neutral1
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
        ])
        
        let imageView = UIImageView(frame: .zero)
        contentView.addSubview(imageView)
        self.thumbImageView = imageView
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 188)
        ])
        
        let nameLabel = UILabel(frame: .zero)
        contentView.addSubview(nameLabel)
        self.nameLabel = nameLabel
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 16)
        ])
        
        let descLabel = UILabel(frame: .zero)
        contentView.addSubview(descLabel)
        self.descLabel = descLabel
        descLabel.textColor = .white
        descLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
            descLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -20),
            descLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4)
        ])
    }
    

}
