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
    lazy var profileImageView = ProfileImageView(profileImageNum: profileImageNumData, imageBorderWidth: .isSelected, imageBorderColor: .isSelected, cameraBtnMode: .isHidden)
    
    let profileNameLabel = UILabel()
    let joinedDateLabel = UILabel()

    let toEditProfileBtn = UIButton()
    var profileImageNumData = UserDefaultManager.profileImage
    
    let tableView = UITableView()
    let settingMenu = ["나의 장바구니 목록", "자주 묻는 질문", "1:1문의", "알림 설정", "탈퇴하기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configUI()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
        profileNameLabel.text = UserDefaultManager.nickname
        profileImageNumData = UserDefaultManager.profileImage
        print("새로이미지넘버저장됨")
        profileImageView.profileImage.image = UIImage(named: "catProfile_\(profileImageNumData)")
        tableView.reloadData()
        
        }

}

extension SettingMainVC:ConfigureBasicSettingProtocol {
    func configHierarchy() {
        view.addSubview(profileView)
        view.addSubview(profileImageView)
        view.addSubview(profileNameLabel)
        view.addSubview(joinedDateLabel)
        view.addSubview(toEditProfileBtn)
        view.addSubview(tableView)
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
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        

    }
    
    func configUI() {
        configureView("SETTING")
        navigationController?.navigationBar.shadowImage = nil
        
        
        profileNameLabel.text = UserDefaultManager.nickname
        profileNameLabel.font = Font.heavy20
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: UserDefaultManager.joinedDate)
        print(date)
        
        joinedDateLabel.text = "\(date)가입"
        toEditProfileBtn.setImage(Icon.chevronRight, for: .normal)
        toEditProfileBtn.addTarget(self, action: #selector(rightBarBtnTapped), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.rowHeight = 40
    }
    
    @objc func rightBarBtnTapped() {
        let vc = ProfileNicknameSettingVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension SettingMainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
        let data = settingMenu[indexPath.row]
        cell.configUI(data: data, indexPath: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            
        let alert = UIAlertController(
                title: "탈퇴하기",
                message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?",
                preferredStyle: .alert)
           
            let ok = UIAlertAction(title: "확인", style: .default) {_ in
                UserDefaultManager.shared.clearUserDefaults()
                print("삭제완료")
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let rootViewController = UINavigationController(rootViewController: OnboardingVC())
                sceneDelegate?.window?.rootViewController = rootViewController
                sceneDelegate?.window?.makeKeyAndVisible()
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)

            alert.addAction(ok)
            alert.addAction(cancel)
            
            
            present(alert, animated: true)
            
        } else {
            return
        }
    }

}
