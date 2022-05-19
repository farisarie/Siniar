//
//  AlbumsViewCell.swift
//  Siniar
//
//  Created by yoga arie on 11/05/22.
//

import UIKit

class AlbumsViewCell: UITableViewCell {

    weak var titleLabel: UILabel!
    weak var viewAllButton: SmallGhostButton!
    weak var collectionView: UICollectionView!
    
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
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
        ])
        
        let button = SmallGhostButton()
        contentView.addSubview(button)
        self.viewAllButton = button
        button.tintColor = UIColor.neutral1
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            button.centerYAnchor.constraint(equalTo: label.centerYAnchor)
        ])
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        contentView.addSubview(collectionView)
        self.collectionView = collectionView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        collectionView.backgroundColor = .clear
        collectionView.register(AlbumViewCell.self, forCellWithReuseIdentifier: "albumCellId")
    }

}
