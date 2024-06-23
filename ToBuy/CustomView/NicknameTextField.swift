//
//  NicknameTextField.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit

class NicknameTextField:UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        borderStyle = .none
        clearButtonMode = .whileEditing
        textAlignment = .left
        // textfield placeholer 색상 변경
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : Color.mediumGray])
    }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
