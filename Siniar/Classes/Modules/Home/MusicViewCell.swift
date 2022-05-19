//
//  MusicViewCell.swift
//  Siniar
//
//  Created by yoga arie on 11/05/22.
//

import UIKit

class MusicViewCell: UITableViewCell {

    weak var noLabel: UILabel!
    weak var thumbImageView: UIImageView!
    weak var titleLabel: UILabel!
    weak var subtitleLabel: UILabel!
    weak var moreButton: UIButton!
    
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
        
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupViews(){
        backgroundColor = .clear
        
        let contentStackView = UIStackView()
        contentStackView.axis = .horizontal
        contentStackView.alignment = .fill
        contentStackView.distribution = .fill
        contentStackView.spacing = 20
        contentView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            contentStackView.heightAnchor.constraint(equalToConstant: 32)
            
        ])
        
        let noLabel = UILabel(frame: .zero)
        
        contentStackView.addArrangedSubview(noLabel)
        self.noLabel = noLabel
        noLabel.textColor = .white
        noLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        noLabel.setContentHuggingPriority(.required, for: .horizontal)
       
        
        let imageView = UIImageView(frame: .zero)
        contentStackView.addArrangedSubview(imageView)
        self.thumbImageView = imageView
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 3
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 32),
            imageView.heightAnchor.constraint(equalToConstant: 32)
          
        ])
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4
        
        let titleLabel = UILabel(frame: .zero)
        stackView.addArrangedSubview(titleLabel)
        self.titleLabel = titleLabel
        titleLabel.textColor = UIColor.neutral1
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        let subtitleLabel = UILabel(frame: .zero)
        stackView.addArrangedSubview(subtitleLabel)
        self.subtitleLabel = subtitleLabel
        subtitleLabel.textColor = UIColor.neutral2
        subtitleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        contentStackView.addArrangedSubview(stackView)
       
        
        let moreButton = UIButton(type: .system)
        contentStackView.addArrangedSubview(moreButton)
        self.moreButton = moreButton
        moreButton.tintColor = .white
        moreButton.setImage(UIImage(named: "btn_more"), for: .normal)
        moreButton.setTitle(nil, for: .normal)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreButton.widthAnchor.constraint(equalToConstant: 24),
            moreButton.heightAnchor.constraint(equalToConstant: 24),
        ])
        
    }

}
