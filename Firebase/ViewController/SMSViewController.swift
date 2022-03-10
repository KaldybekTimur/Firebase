//
//  SMSViewController.swift
//  Firebase
//
//  Created by Timur Kaldybek on 09.03.2022.
//

import UIKit

class SMSViewController: UIViewController{

       private let codeField: UITextField = {
        let field = UITextField()
           field.backgroundColor = .secondarySystemBackground
           field.textAlignment = .center
           field.placeholder = "Enter code "
           field.returnKeyType = .continue
        return field
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .systemBackground
            codeField.delegate = self
            codeField.frame = CGRect(x: 0 , y: 0, width: 220, height: 50)
            codeField.center = view.center
            view.addSubview(codeField)
        }
    }

extension SMSViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text, !text.isEmpty {
            let code = text
            AuthManager.shared.verifyCode(smsCode: code) { [weak self] success in
                guard success else { return }
                DispatchQueue.main.async {
                    let vc = AccountViewController ()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)
                }
            }
            
        }
        return true
    }
}
