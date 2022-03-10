//
//  ViewController.swift
//  Firebase
//
//  Created by Timur Kaldybek on 09.03.2022.
//

import UIKit

class PhoneViewController: UIViewController{
    
    private let phoneField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .secondarySystemBackground
        field.textAlignment = .center
        field.placeholder = "Phone number"
        field.returnKeyType = .continue
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        phoneField.delegate = self
        phoneField.frame = CGRect(x: 0 , y: 0, width: 220, height: 50)
        phoneField.center = view.center
        view.addSubview(phoneField)
    }
}

extension PhoneViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text, !text.isEmpty {
            let number = "+1\(text)"
            AuthManager.shared.startAuth(phoneNumber: number) { [weak self]  success in
                guard success else { return }
                DispatchQueue.main.async {
                    let vc = SMSViewController()
                    vc.title = "Enter Code"
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        return true
    }
}
