//
//  BaseViewController.swift
//  ToBuy
//
//  Created by Joy Kim on 7/7/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configHierarchy()
        configLayout()
        configView()
    }
    
    func configHierarchy() {
        print("Base", #function)
    }
    
    func configLayout() {
        print("Base", #function)
    }
    
    func configView() {
        print("Base", #function)
    }
    
    
}
