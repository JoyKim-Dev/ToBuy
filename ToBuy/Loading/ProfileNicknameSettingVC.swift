//
//  ProfileNicknameSettingVC.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit
import SnapKit

class ProfileNicknameSettingVC: UIViewController {

    lazy var mainImageView = ProfileImageView(profileImageNum: selectedProfileImageNum, imageBorderWidth: .isSelected, imageBorderColor: .isSelected, imageAlpha: .isSelected, cameraBtnMode: .isShowing)
    
    var selectedProfileImageNum = Int.random(in: 0...11)
    
    let nicknameTextField = NicknameTextField(placeholder: "닉네임을 입력해주세요 :)")
    let lineView = LineView()
    let nicknameStatusLabel = UILabel()
    
    let submitBtn = OnboardingButton(btnTitle: "완료", target: self, action: #selector(submitBtnTapped))
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configHierarchy()
        configLayout()
        configUI()
        
    }

}

extension ProfileNicknameSettingVC:ConfigureBasicSettingProtocol  {
    func configHierarchy() {
        view.addSubview(mainImageView)
        view.addSubview(nicknameTextField)
        view.addSubview(lineView)
        view.addSubview(nicknameStatusLabel)
        view.addSubview(submitBtn)
    }
    
    func configLayout() {
        mainImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.width.equalTo(125)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(mainImageView.snp.bottom).offset(20)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(5)
            
        }
        
        nicknameStatusLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        submitBtn.snp.makeConstraints { make in
            make.top.equalTo(nicknameStatusLabel.snp.bottom).offset(20)
            make.centerX.equalTo(view)
            make.height.equalTo(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        
    }
    
    func configUI() {
        configureView("PROFILE SETTING")
        navigationItem.leftBarButtonItem = NavBackBtnChevron(previousVC: self)
        
        mainImageView.profileDelegate = self
        
        nicknameTextField.delegate = self
        nicknameStatusLabel.textColor = Color.orange
        nicknameStatusLabel.font = Font.semiBold13
        nicknameStatusLabel.text = "닉네임에 @는 포함할 수 없어요"
        
    }
    
    @objc func submitBtnTapped() {
        
        UserDefaultManager.nickname = nicknameTextField.text ?? UserDefaultManager.nickname
        print("저장됨")
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let rootViewController = UINavigationController(rootViewController: SearchMainVC())
        sceneDelegate?.window?.rootViewController = rootViewController
        sceneDelegate?.window?.makeKeyAndVisible()
        print("루트뷰 바뀜")
        
    }
    
}

extension ProfileNicknameSettingVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let forbiddenCharacter = ["@", "#", "$", "%"]
        
        guard let text = textField.text else {
            return false
        }
        
         if text.count < 2 || text.count > 10 {
            nicknameStatusLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
        } else if forbiddenCharacter.contains(where: text.contains) {
            nicknameStatusLabel.text = "닉네임에 @, #, $, % 는 포함할 수 없어요"
        } else if Int(text) != nil {
            nicknameStatusLabel.text = "닉네임에 숫자는 포함할 수 없어요"
        } else {
            nicknameStatusLabel.text = "사용할 수 있는 닉네임이에요"
        }
                    
        return true
    }
}

extension ProfileNicknameSettingVC: ProfileCameraBtnDelegate {
    
    func cameraButtonTapped() {
        let vc = ProfileImageSettingVC()
        vc.imageDataFromPreviousPage = selectedProfileImageNum
        navigationController?.pushViewController(vc, animated: true)
    }
}
