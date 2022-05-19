//
//  SearchHistoryViewCell.swift
//  Siniar
//
//  Created by yoga arie on 12/05/22.
//

import UIKit

class SearchHistoryViewCell: UITableViewCell {
    weak var scrollView: UIScrollView!
    weak var stackView: UIStackView!
    
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
        let scrollView = UIScrollView(frame: .zero)
        contentView.addSubview(scrollView)
        self.scrollView = scrollView
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        self.stackView = stackView
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalToConstant: 28)
        ])
        
    }
    
    func setHistory(_ history: [String]){
        stackView.arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
            
        }
        history.forEach { text in
            let button = SmallSecondaryButton()
            button.setTitle(text, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 28)
            ])
            stackView.addArrangedSubview(button)
        }
    }

}
