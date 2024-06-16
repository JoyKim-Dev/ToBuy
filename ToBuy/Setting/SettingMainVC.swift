//
//  SettingMainVC.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit
import SnapKit

class SettingMainVC: UIViewController {

    let profileView = UIView()
    lazy var profileImageView = ProfileImageView(profileImageNum: profileImageNumData, imageBorderWidth: .isSelected, imageBorderColor: .isSelected, imageAlpha: .isSelected, cameraBtnMode: .isHidden)
    
    // 디자인 TODO: 스택뷰 넣어서 centerY잡기
    let profileNameLabel = UILabel()
    let joinedDateLabel = UILabel()

    let toEditProfileBtn = UIButton()
    var profileImageNumData = UserDefaultManager.profileImage[0] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configUI()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            profileNameLabel.text = UserDefaultManager.nickname
        }
   

}

extension SettingMainVC:ConfigureBasicSettingProtocol {
    func configHierarchy() {
        view.addSubview(profileView)
        view.addSubview(profileImageView)
        view.addSubview(profileNameLabel)
        view.addSubview(joinedDateLabel)
        view.addSubview(toEditProfileBtn)
    }
    
    func configLayout() {
        profileView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(100)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalTo(profileView)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.height.equalTo(70)
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }
        
        joinedDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileNameLabel)
            make.top.equalTo(profileNameLabel.snp.bottom).offset(10)
        }
        
        toEditProfileBtn.snp.makeConstraints { make in
            make.centerY.equalTo(profileView)
            make.trailing.equalTo(profileView).inset(20)
        }
        
        

    }
    
    func configUI() {
        configureView("SETTING")
        navigationController?.navigationBar.shadowImage = nil
        
        profileNameLabel.text = UserDefaultManager.nickname
        profileNameLabel.font = Font.heavy20
        
        joinedDateLabel.text = "2024.06.15 가입"
        toEditProfileBtn.setImage(Icon.chevronRight, for: .normal)
        toEditProfileBtn.addTarget(self, action: #selector(rightBarBtnTapped), for: .touchUpInside)
        
    }
    
    @objc func rightBarBtnTapped() {
        let vc = ProfileNicknameSettingVC()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}
