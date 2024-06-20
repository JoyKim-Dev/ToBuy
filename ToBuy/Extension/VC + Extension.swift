//
//  VC + Extension.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//


import UIKit

extension UIViewController {
    
    func configureView(_ navTitle: String) {
        view.backgroundColor = .white
        navigationItem.title = navTitle
    }
    
    func hideKeyboardWhenTappedAround() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
}





