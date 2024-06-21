//
//  ProfileNicknameSettingVC.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit
import SnapKit
//텍스트필드 errorhandling 위한 열거형 케이스
enum ValidationError: Error {
    case emptyString
    case tooShortOrTooLong
    case isInt
    case containsSymbol
}

class ProfileNicknameSettingVC: UIViewController {
    lazy var mainImageView = ProfileImageView(profileImageNum: selectedProfileImageNum, imageBorderWidth: .isSelected, imageBorderColor: .isSelected, cameraBtnMode: .isShowing)
    lazy var nicknameTextField = NicknameTextField(placeholder: nicknameTextFieldPlaceholder)
    var nicknameTextFieldPlaceholder = "닉네임을 입력해주세요 :)"
    let lineView = LineView()
    let nicknameStatusLabel = NicknameStatusLabel()
    let submitBtn = OnboardingButton(btnTitle: "완료")
    var selectedProfileImageNum = UserDefaultManager.profileImage
    let textIsValid = "사용할 수 있는 닉네임이에요"

       
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainImageView.profileImage.image = UIImage(named: "catProfile_\(selectedProfileImageNum)")
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
        // 뷰컨 익스텐션 - 아무데나 탭 했을 때 키보드 내리기
        hideKeyboardWhenTappedAround()
        // 뷰컨 익스텐션 - 흰 배경, 네비바 타이틀 (nickname 저장값 있으면 EDIT PROFILE, 없으면 PROFILE SETTING
        configureView("PROFILE SETTING")
        if UserDefaultManager.nickname.isEmpty == false {
            navigationItem.title = "EDIT PROFILE"
        }
        // 커스텀뷰 - 네비바 왼쪽버튼
        let backbtn = NavBackBtnChevron(image: Icon.chevronLeft, style: .plain, target: self, action: #selector(backBtnTapped))
        navigationItem.leftBarButtonItem = backbtn
        // 이미지 - 액션 추가
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        mainImageView.addGestureRecognizer(imageTapGesture)
        //화면 재사용 위해 조건 처리 (닉네임 재설정 창으로 활용 시 기존 닉네임 표시)
        nicknameTextField.text = {
            if UserDefaultManager.nickname.isEmpty {
                return ""
            } else {
                return UserDefaultManager.nickname
            }
        }()
        
        nicknameTextField.delegate = self
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        if UserDefaults.standard.object(forKey: "profileImage") == nil {
            selectedProfileImageNum = Int.random(in: 0...11)
            UserDefaultManager.profileImage = selectedProfileImageNum
        }
        
        submitBtn.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)

    }
    
    //이미지 눌리면 다음 뷰로 이동
    @objc func imageTapped() {
        let vc = ProfileImageSettingVC()
        vc.imageDataFromPreviousPage = selectedProfileImageNum
        vc.imageForDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 에러 발라내는데 활용할 기준 함수 구현
    func validateUserInput(text: String) throws -> Bool {
        guard !text.isEmpty else {
            submitBtn.isEnabled = false
            submitBtn.toggleOnboardingBtn()
            throw ValidationError.emptyString
        }
        guard text.count > 1 && text.count < 10 else {
            nicknameStatusLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
            submitBtn.isEnabled = false
            submitBtn.toggleOnboardingBtn()
            throw ValidationError.tooShortOrTooLong
        }
        guard text.containsNumber() == false else {
            nicknameStatusLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            submitBtn.isEnabled = false
            submitBtn.toggleOnboardingBtn()
            throw ValidationError.isInt
        }
        guard text.containsAnyOfSpecificSymbols(["@","#","$","%"]) == false else {
            nicknameStatusLabel.text = "닉네임에 @, #, $, % 는 포함할 수 없어요"
            submitBtn.isEnabled = false
            submitBtn.toggleOnboardingBtn()
            throw ValidationError.containsSymbol
        }
        nicknameStatusLabel.text = textIsValid
        submitBtn.isEnabled = true
        submitBtn.toggleOnboardingBtn()
        return true
    }
    // 입력되는 글자마다 조건 확인하여 에러 발라내고 do-try / catch 활용하여 enum case로 에러 분기처리
    @objc func textFieldDidChange(_ sender: Any?) {
        if let text = nicknameTextField.text{
            do{
                let result = try validateUserInput(text: text)
                print(result)
            } catch ValidationError.emptyString {
                
            } catch ValidationError.tooShortOrTooLong {
                
            } catch ValidationError.isInt {
                
            } catch ValidationError.containsSymbol {
                
            } catch {
                print("그 외")
            }
        }
    }
    
    // 완료 시 동작 trigger : 1. 버튼 addtarget 2. 텍스트필드 return (버튼 함수 실행 - 재활용) 3. UserDefault 저장(닉네임. 가입일.이미지)
    @objc func submitBtnTapped() {
        //유효하지 않으면 버튼 비활성화
        if nicknameStatusLabel.text != textIsValid {
            return
        } else if UserDefaultManager.nickname.isEmpty {
            UserDefaultManager.nickname = nicknameTextField.text ?? UserDefaultManager.nickname
            UserDefaultManager.joinedDate = Date()
            UserDefaultManager.profileImage = selectedProfileImageNum
            print("저장됨")
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            let rootViewController = TabBarController()
            sceneDelegate?.window?.rootViewController = rootViewController
            sceneDelegate?.window?.makeKeyAndVisible()
            print("루트뷰 바뀜")
        } else {
            UserDefaultManager.nickname = nicknameTextField.text ?? UserDefaultManager.nickname
            print("닉네임저장됨")
            UserDefaultManager.profileImage = selectedProfileImageNum
            navigationController?.popViewController(animated: true)
        }
    }
    @objc func backBtnTapped() {
        navigationController?.popViewController(animated: true)
        print(#function)
        if navigationItem.title == "PROFILE SETTING" {
            UserDefaults.standard.removeObject(forKey: "profileImage")
        }
    }
}

extension ProfileNicknameSettingVC: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if nicknameStatusLabel.text != textIsValid {
            return false
        } else {
            submitBtnTapped()
            return true
        }
    }
}

extension ProfileNicknameSettingVC: ImageDelegate {
    func imageDataFromImageSettingpage(int: Int) {
//        mainImageView.profileImage.image = UIImage(named: "catProfile_\(int)")
        selectedProfileImageNum = int
        print("\(int) 전달 받음")
    }
    
}
