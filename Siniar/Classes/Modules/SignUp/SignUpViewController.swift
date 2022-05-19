//
//  SignUpViewController.swift
//  Siniar
//
//  Created by yoga arie on 10/05/22.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    weak var bgImageView: UIImageView!
    weak var titleLabel: UILabel!
    weak var nameTextField: UITextField!
    weak var emailTextField: UITextField!
    weak var passwordTextField: UITextField!
    weak var signUpButton: PrimaryButton!
    weak var signInButton: GhostButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupViews() {
        let imageView = UIImageView(image: UIImage(named: "bg_sign_up"))
        view.addSubview(imageView)
        self.bgImageView = imageView
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let titleLabel = UILabel(frame: .zero)
        view.addSubview(titleLabel)
        self.titleLabel = titleLabel
        titleLabel.text = "SIGN UP"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        if #available(iOS 11.0, *) {
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        }
        else {
            // Fallback on earlier versions
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        }
        
        let nameTextField = SiniarTextField(inputType: .name)
        view.addSubview(nameTextField)
        self.nameTextField = nameTextField
        nameTextField.placeholder = "Name"
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60).isActive = true
        
        let emailTextField = SiniarTextField(inputType: .email)
        view.addSubview(emailTextField)
        self.emailTextField = emailTextField
        emailTextField.placeholder = "E-Mail"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24).isActive = true
        
        let passTextField = SiniarTextField(inputType: .password)
        view.addSubview(passTextField)
        self.passwordTextField = passTextField
        passTextField.placeholder = "Password"
        passTextField.translatesAutoresizingMaskIntoConstraints = false
        passTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        passTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        passTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24).isActive = true
        
        let signUpButton = PrimaryButton()
        view.addSubview(signUpButton)
        self.signUpButton = signUpButton
        signUpButton.setTitle("SIGN UP", for: .normal)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        signUpButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 64).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        signUpButton.addTarget(self, action: #selector(self.signUpButtonTapped(_:)), for: .touchUpInside)
        
        let signInButton = GhostButton()
        view.addSubview(signInButton)
        self.signInButton = signInButton
        signInButton.setTitle("SIGN IN", for: .normal)
        signInButton.tintColor = UIColor.neutral1
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        signInButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 12).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        signInButton.addTarget(self, action: #selector(self.backButtonTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: - Helpers
    
    func isValid() -> Bool {
        guard let name = nameTextField.text, name.count >= 3 else {
            print("name is not valid")
            return false
        }

        guard let email = emailTextField.text, email.isValidEmail else {
            print("email is not valid")
            return false
        }

        guard let password = passwordTextField.text, password.isValidPassword else {
            print("password is not valid")
            return false
        }

        return true
    }
    
    func signUp() {
        Auth.auth().createUser(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (authResult, error) in
            if let error = error {
                // Error. If error.code == .MissingOrInvalidNonce, make sure
                // you're sending the SHA256-hashed nonce as a hex string with
                // your request to Apple.
                print(error.localizedDescription)
                return
            }
            // User is signed in to Firebase with Apple.
            // ...
            let request = authResult?.user.createProfileChangeRequest()
            request?.displayName = self.nameTextField.text ?? ""
            request?.commitChanges(completion: { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
    }
    
    // MARK: - Actions
    
    @objc func signUpButtonTapped(_ sender: Any) {
        if isValid() {
            signUp()
        }
        else {
            
        }
    }
    

}

extension UIViewController {
    func showSignUpViewController() {
        let viewController = SignUpViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
