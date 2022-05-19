//
//  NewPasswordViewController.swift
//  Siniar
//
//  Created by yoga arie on 10/05/22.
//

import UIKit

class NewPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    
}

// MARK: - UIViewController
extension UIViewController {
    func showNewPasswordController() {
        let viewController = UIStoryboard(name: "Forgot", bundle: nil).instantiateViewController(withIdentifier: "newPassword") as! NewPasswordViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
