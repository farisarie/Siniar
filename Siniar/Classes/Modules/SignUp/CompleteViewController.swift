//
//  CompleteViewController.swift
//  Siniar
//
//  Created by yoga arie on 10/05/22.
//

import UIKit

class CompleteViewController: UIViewController {
    weak var titleLabel: UILabel!
    weak var subtitleLabel: UILabel!
    weak var signInButton: PrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews() {
        view.backgroundColor = UIColor.brand2
        
        let signInButton = PrimaryButton()
        view.addSubview(signInButton)
        self.signInButton = signInButton
        signInButton.setTitle("SIGN IN", for: .normal)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        signInButton.addTarget(self, action: #selector(self.signInButtonTapped(_:)), for: .touchUpInside)
        
        let subtitleLabel = UILabel(frame: .zero)
        view.addSubview(subtitleLabel)
        self.subtitleLabel = subtitleLabel
        subtitleLabel.text = "Congratulation!"
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = UIColor.white
        subtitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -80).isActive = true
        
        let titleLabel = UILabel(frame: .zero)
        view.addSubview(titleLabel)
        self.titleLabel = titleLabel
        titleLabel.text = "Registration Complete"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -12).isActive = true
        
    }
    
    // MARK: - Actions
    
    @objc func signInButtonTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension UIViewController {
    func showCompleteViewController() {
        let viewController = CompleteViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
