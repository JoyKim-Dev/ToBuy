//
//  OnboardingVC.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//


// 프로필 없는 사용자 & 설정화면(탈퇴)버튼 클릭 시 뜨는 화면 
import UIKit

import SnapKit

class OnboardingVC: UIViewController {

    let appTitleLabel = AppTitleLabel()
    let nameLabel = UILabel()
    let appMainImage = UIImageView()
    let appStartBtn = OnboardingButton(btnTitle: "시작하기", target: self, action: #selector(startBtnTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configHierarchy()
        configLayout()
        configUI()
    }
}

extension OnboardingVC:ConfigureBasicSettingProtocol {
    func configHierarchy() {
        view.addSubview(appTitleLabel)
        view.addSubview(appMainImage)
        view.addSubview(appStartBtn)
        view.addSubview(nameLabel)
    }
    
    func configLayout() {
        appTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.centerX.equalTo(view)
        }
        
        appMainImage.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.3)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
   
        appStartBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.centerX.equalTo(view)
            make.height.equalTo(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(appMainImage.snp.bottom).offset(30)
        }
    }
    
    func configUI() {
        view.backgroundColor = Color.white
        appMainImage.image = Image.mainImage
        appMainImage.contentMode = .scaleAspectFill
       

        
    }
    
    @objc func startBtnTapped() {
        
        let vc = ProfileNicknameSettingVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
