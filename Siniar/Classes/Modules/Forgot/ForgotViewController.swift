//
//  ForgotViewController.swift
//  Siniar
//
//  Created by yoga arie on 10/05/22.
//

import UIKit

class ForgotViewController: UIViewController {

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


    @IBAction func nextButtonTapped(_ sender: Any) {
        showNewPasswordController()
    }
    

}

extension UIViewController {
    func showForgotViewController() {
        let viewController = UIStoryboard(name: "Forgot", bundle: nil).instantiateViewController(withIdentifier: "forgot") as! ForgotViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
