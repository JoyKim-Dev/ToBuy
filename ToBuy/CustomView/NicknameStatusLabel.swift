//
//  NicknameStatusLabel.swift
//  ToBuy
//
//  Created by Joy Kim on 6/18/24.
//

import UIKit

class NicknameStatusLabel:UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        textColor = Color.orange
        font = Font.semiBold13
        text = "닉네임에 @는 포함할 수 없어요"

    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
