//
//  EditProfileViewController.swift
//  Siniar
//
//  Created by yoga arie on 13/05/22.
//

import UIKit
import FirebaseAuth

class EditProfileViewController: UIViewController {
    weak var scrollView: UIScrollView!
    weak var profileImageView: UIImageView!
    weak var cameraButton: UIButton!
    weak var nameTitleLabel: UILabel!
    weak var nameTextField: UITextField!
    weak var emailTitleLabel: UILabel!
    weak var emailTextField: UITextField!
    weak var phoneTitleLabel: UILabel!
    weak var phoneTextField: UITextField!
    weak var genderTitleLabel: UILabel!
    weak var genderTextField: UITextField!
    weak var dobTitleLabel: UILabel!
    weak var dobTextField: UITextField!
    weak var saveButton: GhostButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupData()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }
    }
    
    // MARK: - Helpers
    
    func setup(){
    title = "Edit"
        view.backgroundColor = .brand2
        
        let backButton = UIBarButtonItem(image: UIImage(named: "btn_back"), style: .plain, target: self, action: #selector(self.backButtonTapped(_:)))
        navigationItem.leftBarButtonItem = backButton
        
        let scrollView = UIScrollView(frame: .zero)
        view.addSubview(scrollView)
        self.scrollView = scrollView
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
        let contentView = UIView(frame: .zero)
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) //content sama dengan lebar scroll berarti scroll vertical
        ])
        
        let imageView = UIImageView(frame: .zero)
        contentView.addSubview(imageView)
        self.profileImageView = imageView
        imageView.backgroundColor = UIColor.brand2
        imageView.layer.cornerRadius = 71
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor(rgb: 0xADB0C0).cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 142),
            imageView.heightAnchor.constraint(equalToConstant: 142),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
        ])
        
        let cameraButton = UIButton(type: .system)
        contentView.addSubview(cameraButton)
        self.cameraButton = cameraButton
        cameraButton.setTitle(nil, for: .normal)
        cameraButton.setImage(UIImage(named: "btn_camera")?.withRenderingMode(.alwaysTemplate), for: .normal)
        cameraButton.backgroundColor = UIColor.brand1
        cameraButton.tintColor = UIColor.brand2
        cameraButton.layer.cornerRadius = 20
        cameraButton.layer.masksToBounds = true
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cameraButton.widthAnchor.constraint(equalToConstant: 40),
            cameraButton.heightAnchor.constraint(equalToConstant: 40),
            cameraButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            cameraButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
        
        let profileView = UIView(frame: .zero)
        contentView.addSubview(profileView)
        contentView.sendSubviewToBack(profileView)
        profileView.backgroundColor = UIColor(rgb: 0x363942)
        profileView.layer.cornerRadius = 12
        profileView.layer.masksToBounds = true
        profileView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: imageView.centerYAnchor),
            profileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            profileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
           
        ])
        
        let nameStackView = UIStackView()
        nameStackView.axis = .horizontal
        nameStackView.spacing = 16
        nameStackView.alignment = .fill
        nameStackView.distribution = .fill
        profileView.addSubview(nameStackView)
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameStackView.topAnchor.constraint(equalTo: profileView.topAnchor, constant: 160),
            nameStackView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 16),
            nameStackView.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -16)
        ])
        
        let nameTitleLabel = UILabel(frame: .zero)
        nameStackView.addArrangedSubview(nameTitleLabel)
        self.nameTitleLabel = nameTitleLabel
        nameTitleLabel.text = "Name"
        nameTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        nameTitleLabel.textColor = UIColor(rgb: 0x717378)
        nameTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        let nameTextField = UITextField(frame: .zero)
        nameStackView.addArrangedSubview(nameTextField)
        self.nameTextField = nameTextField
        nameTextField.borderStyle = .none
        nameTextField.textAlignment = .right
        nameTextField.textColor = UIColor.neutral1
        nameTextField.tintColor = UIColor.neutral1
        nameTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let emailStackView = UIStackView()
        emailStackView.axis = .horizontal
        emailStackView.spacing = 16
        emailStackView.alignment = .fill
        emailStackView.distribution = .fill
        profileView.addSubview(emailStackView)
        emailStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 30),
            emailStackView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 16),
            emailStackView.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -16)
        ])
        
        let emailTitleLabel = UILabel(frame: .zero)
        emailStackView.addArrangedSubview(emailTitleLabel)
        self.emailTitleLabel = emailTitleLabel
        emailTitleLabel.text = "Email"
        emailTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        emailTitleLabel.textColor = UIColor(rgb: 0x717378)
        emailTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        let emailTextField = UITextField(frame: .zero)
        emailStackView.addArrangedSubview(emailTextField)
        self.emailTextField = emailTextField
        emailTextField.borderStyle = .none
        emailTextField.textAlignment = .right
        emailTextField.textColor = UIColor.neutral1
        emailTextField.tintColor = UIColor.neutral1
        emailTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let phoneStackView = UIStackView()
        phoneStackView.axis = .horizontal
        phoneStackView.spacing = 16
        phoneStackView.alignment = .fill
        phoneStackView.distribution = .fill
        profileView.addSubview(phoneStackView)
        phoneStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneStackView.topAnchor.constraint(equalTo: emailStackView.bottomAnchor, constant: 30),
            phoneStackView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 16),
            phoneStackView.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -16)
        ])
        
        let phoneTitleLabel = UILabel(frame: .zero)
        phoneStackView.addArrangedSubview(phoneTitleLabel)
        self.phoneTitleLabel = phoneTitleLabel
        phoneTitleLabel.text = "Phone"
        phoneTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        phoneTitleLabel.textColor = UIColor(rgb: 0x717378)
        phoneTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        let phoneTextField = UITextField(frame: .zero)
        phoneStackView.addArrangedSubview(phoneTextField)
        self.phoneTextField = phoneTextField
        phoneTextField.borderStyle = .none
        phoneTextField.textAlignment = .right
        phoneTextField.textColor = UIColor.neutral1
        phoneTextField.tintColor = UIColor.neutral1
        phoneTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let genderStackView = UIStackView()
        genderStackView.axis = .horizontal
        genderStackView.spacing = 16
        genderStackView.alignment = .fill
        genderStackView.distribution = .fill
        profileView.addSubview(genderStackView)
        genderStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            genderStackView.topAnchor.constraint(equalTo: phoneStackView.bottomAnchor, constant: 30),
            genderStackView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 16),
            genderStackView.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -16)
        ])
        
        let genderTitleLabel = UILabel(frame: .zero)
        genderStackView.addArrangedSubview(genderTitleLabel)
        self.genderTitleLabel = genderTitleLabel
        genderTitleLabel.text = "Gender"
        genderTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        genderTitleLabel.textColor = UIColor(rgb: 0x717378)
        genderTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        let genderTextField = UITextField(frame: .zero)
        genderStackView.addArrangedSubview(genderTextField)
        self.genderTextField = genderTextField
        genderTextField.borderStyle = .none
        genderTextField.textAlignment = .right
        genderTextField.textColor = UIColor.neutral1
        genderTextField.tintColor = UIColor.neutral1
        genderTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        genderTextField.translatesAutoresizingMaskIntoConstraints = false
        genderTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let dobStackView = UIStackView()
        dobStackView.axis = .horizontal
        dobStackView.spacing = 16
        dobStackView.alignment = .fill
        dobStackView.distribution = .fill
        profileView.addSubview(dobStackView)
        dobStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dobStackView.topAnchor.constraint(equalTo: genderStackView.bottomAnchor, constant: 30),
            dobStackView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 16),
            dobStackView.trailingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: -16),
            dobStackView.bottomAnchor.constraint(equalTo: profileView.bottomAnchor, constant: -32)
        ])
        
        let dobTitleLabel = UILabel(frame: .zero)
        dobStackView.addArrangedSubview(dobTitleLabel)
        self.dobTitleLabel = dobTitleLabel
        dobTitleLabel.text = "Date Of Birth"
        dobTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        dobTitleLabel.textColor = UIColor(rgb: 0x717378)
        dobTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        let dobTextField = UITextField(frame: .zero)
        dobStackView.addArrangedSubview(dobTextField)
        self.dobTextField = dobTextField
        dobTextField.placeholder = "dd//MM/yyyy"
        dobTextField.borderStyle = .none
        dobTextField.textAlignment = .right
        dobTextField.textColor = UIColor.neutral1
        dobTextField.tintColor = UIColor.neutral1
        dobTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        dobTextField.translatesAutoresizingMaskIntoConstraints = false
        dobTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let saveButton = GhostButton()
        contentView.addSubview(saveButton)
        self.saveButton = saveButton
        saveButton.setTitle("Save", for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 30),
            saveButton.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 32),
            saveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
        saveButton.addTarget(self, action: #selector(self.saveButtonTapped(_:)), for: .touchUpInside)
        
    }
    func setupData(){
        let user = Auth.auth().currentUser
        nameTextField.text = user?.displayName
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.viewContext
        
        let profile = ProfileData.fetch(userId: user?.uid ?? "", in: context)
        emailTextField.text = profile?.email
        phoneTextField.text = profile?.phone
        genderTextField.text = profile?.gender
        dobTextField.text = profile?.dob?.string(format: "dd/MM/yyyy")
    }
    
    func saveData(){
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        let gender = genderTextField.text ?? ""
        let dobString = dobTextField.text ?? ""
        let dob: Date? = dobString.date(format: "dd/MM/yyyy")
        
        let user = Auth.auth().currentUser
        let userId = user?.uid ?? ""
        let profile = Profile(userId: userId) // user id adalah kode acak yang dibawa dari firebase
        
        profile.email = email
        profile.phone = phone
        profile.gender = gender
        profile.dob = dob
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.viewContext
        
        ProfileData.save(profile, in: context)
        appDelegate.saveContext()
        
        let request = user?.createProfileChangeRequest()
        request?.displayName = name
        request?.commitChanges { error in }
       
    }
    
    // MARK: - Action
    @objc func saveButtonTapped(_ sender: Any){
        saveData()
    }
}

extension UIViewController{
    func showEditProfileViewController(){
        let viewController = EditProfileViewController()
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
