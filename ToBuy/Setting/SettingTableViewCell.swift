//
//  SettingTableViewCell.swift
//  ToBuy
//
//  Created by Joy Kim on 6/17/24.
//

import UIKit

import SnapKit

class SettingTableViewCell: UITableViewCell {

    let label = UILabel()
    let bagBtn = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configHierarchy()
        configLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SettingTableViewCell {
    
    func configHierarchy() {
        contentView.addSubview(label)
        contentView.addSubview(bagBtn)
    }
    
    func configLayout() {
        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        bagBtn.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.height.equalTo(25)
            make.width.equalTo(125)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func configUI(data: String, indexPath: Int) {
        label.text = data
        label.font = Font.semiBold15
        
        let likes = UserDefaultManager.likedItemID.count

        if indexPath == 0 {
            bagBtn.isHidden = false
            bagBtn.setTitleColor(Color.black, for: .normal)
            bagBtn.setTitle("\(likes)개의 상품", for: .normal)
            bagBtn.titleLabel?.font = Font.semiBold15
            bagBtn.setImage(Icon.likeSelected, for: .normal)
            bagBtn.imageEdgeInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 100)
        } else {
            bagBtn.isHidden = true
        }
    }
    
 

}
