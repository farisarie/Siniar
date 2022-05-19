//
//  SignInViewController.swift
//  Siniar
//
//  Created by yoga arie on 10/05/22.
//

import UIKit
import AuthenticationServices
import FirebaseAuth

class SignInViewController: UIViewController {

    weak var scrollView: UIScrollView!
    weak var contentView: UIView!
    
    weak var bgImageView: UIImageView!
    weak var titleLabel: UILabel!
    weak var emailTextField: UITextField!
    weak var passwordTextField: UITextField!
    weak var forgotButton: GhostButton!
    weak var signInButton: PrimaryButton!
    weak var signUpTitleLabel: UILabel!
    weak var signUpButton: GhostButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    
    //MARK: - Helpers
    func setupViews() {
        let scrollView = UIScrollView(frame: .zero)
        view.addSubview(scrollView)
        self.scrollView = scrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let contentView = UIView(frame: .zero)
        scrollView.addSubview(contentView)
        self.contentView = contentView
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            
        ])
        
        let view = contentView
        
        
        let imageView = UIImageView(image: UIImage(named: "bg_sign_in"))
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
        titleLabel.text = "SIGN IN"
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
        
        let emailTextField = SiniarTextField(inputType: .email)
        view.addSubview(emailTextField)
        self.emailTextField = emailTextField
        emailTextField.placeholder = "E-Mail"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60).isActive = true
        
        let passTextField = SiniarTextField(inputType: .password)
        view.addSubview(passTextField)
        self.passwordTextField = passTextField
        passTextField.placeholder = "Password"
        passTextField.translatesAutoresizingMaskIntoConstraints = false
        passTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        passTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        passTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24).isActive = true
        
        let forgotButton = SmallGhostButton()
        view.addSubview(forgotButton)
        self.forgotButton = forgotButton
        forgotButton.setTitle("Forgot Password?", for: .normal)
        forgotButton.setTitleColor(UIColor.neutral1, for: .normal)
        forgotButton.translatesAutoresizingMaskIntoConstraints = false
        forgotButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        forgotButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 36).isActive = true
        forgotButton.addTarget(self, action: #selector(self.forgotButtonTapped(_:)), for: .touchUpInside)
        
        let signInButton = PrimaryButton()
        view.addSubview(signInButton)
        self.signInButton = signInButton
        signInButton.setTitle("SIGN IN", for: .normal)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        signInButton.topAnchor.constraint(equalTo: forgotButton.bottomAnchor, constant: 64).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
        signInButton.addTarget(self, action: #selector(self.signInButtonTapped(_:)), for: .touchUpInside)
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4
        
        let signUpTitleLabel = UILabel(frame: .zero)
        stackView.addArrangedSubview(signUpTitleLabel)
        self.signUpTitleLabel = signUpTitleLabel
        signUpTitleLabel.text = "Don't have an account? "
        signUpTitleLabel.textColor = .white
        signUpTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        let signUpButton = SmallGhostButton()
        stackView.addArrangedSubview(signUpButton)
        self.signUpButton = signUpButton
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        signUpButton.addTarget(self, action: #selector(self.signUpButtonTapped(_:)), for: .touchUpInside)
        
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if #available(iOS 11.0, *) {
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        }
        else {
            // Fallback on earlier versions
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        }
        
        let signInStackView = UIStackView()
        signInStackView.axis = .horizontal
        signInStackView.distribution = .fill
        signInStackView.alignment = .fill
        signInStackView.spacing = 12
        
        let fbButton = UIButton(type: .system)
        signInStackView.addArrangedSubview(fbButton)
        fbButton.setTitle(nil, for: .normal)
        fbButton.setImage(UIImage(named: "icn_fb")?.withRenderingMode(.alwaysOriginal), for: .normal)
        fbButton.translatesAutoresizingMaskIntoConstraints = false
        fbButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        fbButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let googleButton = UIButton(type: .system)
        signInStackView.addArrangedSubview(googleButton)
        googleButton.setTitle(nil, for: .normal)
        googleButton.setImage(UIImage(named: "icn_google")?.withRenderingMode(.alwaysOriginal), for: .normal)
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        googleButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let twitterButton = UIButton(type: .system)
        signInStackView.addArrangedSubview(twitterButton)
        twitterButton.setTitle(nil, for: .normal)
        twitterButton.setImage(UIImage(named: "icn_twitter")?.withRenderingMode(.alwaysOriginal), for: .normal)
        twitterButton.translatesAutoresizingMaskIntoConstraints = false
        twitterButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        twitterButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        if #available(iOS 13.0, *) {
            let appleButton = ASAuthorizationAppleIDButton(type: .default, style: .white)
            signInStackView.addArrangedSubview(appleButton)
            appleButton.translatesAutoresizingMaskIntoConstraints = false
            appleButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
            appleButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            appleButton.cornerRadius = 20
        }
    
        
        view.addSubview(signInStackView)
        signInStackView.translatesAutoresizingMaskIntoConstraints = false
        signInStackView.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -60).isActive = true
        signInStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        let labelStackView = UIStackView()
        labelStackView.axis = .horizontal
        labelStackView.distribution = .fill
        labelStackView.alignment = .fill
        labelStackView.spacing = 16
        
        let line1Container = UIView(frame: .zero)
        labelStackView.addArrangedSubview(line1Container)
        line1Container.backgroundColor = .clear

        let line1 = UIView(frame: .zero)
        line1Container.addSubview(line1)
        line1.backgroundColor = UIColor(rgb: 0x8D92A3)
        line1.translatesAutoresizingMaskIntoConstraints = false
        line1.heightAnchor.constraint(equalToConstant: 1).isActive = true
        line1.leadingAnchor.constraint(equalTo: line1Container.leadingAnchor).isActive = true
        line1.trailingAnchor.constraint(equalTo: line1Container.trailingAnchor).isActive = true
        line1.centerYAnchor.constraint(equalTo: line1Container.centerYAnchor).isActive = true
        
        let label = UILabel(frame: .zero)
        labelStackView.addArrangedSubview(label)
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.textColor = UIColor(rgb: 0x8D92A3)
        label.text = "Or connect with"
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        let line2Container = UIView(frame: .zero)
        labelStackView.addArrangedSubview(line2Container)
        line2Container.backgroundColor = .clear

        let line2 = UIView(frame: .zero)
        line2Container.addSubview(line2)
        line2.backgroundColor = UIColor(rgb: 0x8D92A3)
        line2.translatesAutoresizingMaskIntoConstraints = false
        line2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        line2.leadingAnchor.constraint(equalTo: line2Container.leadingAnchor).isActive = true
        line2.trailingAnchor.constraint(equalTo: line2Container.trailingAnchor).isActive = true
        line2.centerYAnchor.constraint(equalTo: line2Container.centerYAnchor).isActive = true
        
        line2Container.widthAnchor.constraint(equalTo: line1Container.widthAnchor).isActive = true
        
        view.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.bottomAnchor.constraint(equalTo: signInStackView.topAnchor, constant: -20).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        labelStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
    }
    func signIn() {
        Auth.auth().signIn(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { (authResult, error) in
            if let error = error {
                // Error. If error.code == .MissingOrInvalidNonce, make sure
                // you're sending the SHA256-hashed nonce as a hex string with
                // your request to Apple.
                print(error.localizedDescription)
                return
            }
            // User is signed in to Firebase with Apple.
            // ...
            print("User is signed in to Firebase with Apple.")
            self.showMainViewController()
        }
    }
    
    // MARK: - Actions
    @objc func forgotButtonTapped(_ sender: Any) {
        showForgotViewController()
    }
    
    @objc func signUpButtonTapped(_ sender: Any) {
        showSignUpViewController()
    }
    
    @objc func signInButtonTapped(_ sender: Any) {
        signIn()
    }
 
}
// MARK: - Sign-in
extension SignInViewController{
    
}

extension UIViewController {
    func showSignInViewController() {
        let viewController = SignInViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        window?.rootViewController = navigationController
    }
}
