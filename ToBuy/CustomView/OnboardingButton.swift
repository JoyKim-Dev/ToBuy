//
//  OnboardingButton.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit

class OnboardingButton:UIButton {
    
    init(btnTitle: String, target: Any ,action: Selector) {
        super.init(frame: .zero)
        
        setTitle(btnTitle, for: .normal)
        titleLabel?.font = Font.semiBold15
        setTitleColor(Color.white, for: .normal)
        backgroundColor = Color.orange
        layer.cornerRadius = 20
        self.addTarget(target, action: action, for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
