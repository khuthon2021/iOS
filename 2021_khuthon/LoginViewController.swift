//
//  LoginViewController.swift
//  2021_khuthon
//
//  Created by YOONJONG on 2021/11/12.
//

import UIKit
import GoogleSignIn
class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        GIDSignIn.sharedInstance().presentingViewController = self
    }
    
    @IBAction func googleLoginButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    private func updateUI(){
        emailLoginButton.layer.cornerRadius = 30
        googleLoginButton.layer.cornerRadius = 30
    }
}
