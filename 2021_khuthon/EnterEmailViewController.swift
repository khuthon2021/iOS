//
//  EnterEmailViewController.swift
//  2021_khuthon
//
//  Created by YOONJONG on 2021/11/12.
//

import UIKit
import FirebaseAuth
class EnterEmailViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.becomeFirstResponder()
    }
    
    private func updateUI(){
        nextButton.layer.cornerRadius = 30
        nextButton.isEnabled = false
        let emailTextBottomLine = CALayer()
        emailTextBottomLine.frame = CGRect(x: 0.0, y: emailTextField.frame.height - 1, width: emailTextField.frame.width, height: 2.0)
        emailTextBottomLine.backgroundColor = UIColor.lightGray.cgColor
        let passwordTextBottomLine = CALayer()
        passwordTextBottomLine.frame = CGRect(x: 0.0, y: passwordTextField.frame.height - 1, width: passwordTextField.frame.width, height: 2.0)
        passwordTextBottomLine.backgroundColor = UIColor.lightGray.cgColor
        emailTextField.borderStyle = UITextField.BorderStyle.none
        emailTextField.layer.addSublayer(emailTextBottomLine)
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.layer.addSublayer(passwordTextBottomLine)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        // Firebase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        print("pw type : ", type(of: password))
        // 신규 사용자 생성
        // 순환참조 방지를 위해 weak self
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            print("넘어온 email : \(email), pw : \(password)")
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007://이미 가입한 계정일때
                    //로그인하기
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else {
                self.showMainViewController()
            }
            
        }
    }
    private func showMainViewController(){
        // storyboard에 우리가 만들어 놓은 애를 연결하기 위해
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    private func loginUser(withEmail email:String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { [weak self]_, error in
            guard let self = self else { return }
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
}

extension EnterEmailViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
