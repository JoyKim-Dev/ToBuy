//
//  ProfileImageSettingVC.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit

class ProfileImageSettingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView("PROFILE SETTING")
        
        configHierarchy()
        configLayout()
        configUI()
     
    }

}

extension ProfileImageSettingVC: ConfigureBasicSettingProtocol {
    func configHierarchy() {
        //
    }
    
    func configLayout() {
        //
    }
    
    func configUI() {
        
        navigationItem.leftBarButtonItem = NavBackBtnChevron()
    }
    
    
    
    
}
