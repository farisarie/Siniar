//
//  PhoneViewController.swift
//  Siniar
//
//  Created by yoga arie on 10/05/22.
//

import UIKit

class PhoneViewController: UIViewController {
    weak var backButton: UIButton!
    weak var titleLabel: UILabel!
    weak var phoneTextField: UITextField!
    weak var continueButton: PrimaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    func setupViews() {
        view.backgroundColor = UIColor.brand2
        
        let backButton = UIButton(type: .system)
        view.addSubview(backButton)
        self.backButton = backButton
        backButton.setImage(UIImage(named: "btn_back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.setTitle(nil, for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        if #available(iOS 11.0, *) {
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        }
        else {
            // Fallback on earlier versions
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16 + topLayoutGuide.length).isActive = true
        }
        backButton.addTarget(self, action: #selector(self.backButtonTapped(_:)), for: .touchUpInside)
        
        let titleLabel = UILabel(frame: .zero)
        view.addSubview(titleLabel)
        self.titleLabel = titleLabel
        titleLabel.text = "To continue enter your phone number"
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.neutral1
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 32).isActive = true
        
        let phoneTextField = SiniarTextField(inputType: .phone)
        view.addSubview(phoneTextField)
        self.phoneTextField = phoneTextField
        phoneTextField.placeholder = "Phone"
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        phoneTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 80).isActive = true
        
        let continueButton = PrimaryButton()
        view.addSubview(continueButton)
        self.continueButton = continueButton
        continueButton.setTitle("CONTINUE", for: .normal)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        continueButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 64).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        continueButton.addTarget(self, action: #selector(self.continueButtonTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: - Helpers
    
    func isValid() -> Bool {
        guard let phone = phoneTextField.text, phone.isValidPhone else {
            print("phone is not valid")
            return false
        }
        return true
    }
    
    // MARK: - Actions
    
    @objc func continueButtonTapped(_ sender: Any) {
        if isValid() {
            showOtpViewController()
        }
    }

 

}

extension UIViewController {
    func showPhoneViewController() {
        let viewController = PhoneViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
