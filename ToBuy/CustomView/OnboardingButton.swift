//
//  OnboardingButton.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit

class OnboardingButton:UIButton {
    
    init(btnTitle: String) {
        super.init(frame: .zero)
        
        setTitle(btnTitle, for: .normal)
        titleLabel?.font = Font.semiBold15
        setTitleColor(Color.white, for: .normal)
        backgroundColor = Color.orange
        layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension OnboardingButton {
    func toggleOnboardingBtn() {
        if isEnabled {
            backgroundColor = Color.orange
            setTitleColor(Color.white, for: .normal)
        } else {
            backgroundColor = Color.unselectedGray
            setTitleColor(Color.darkGray, for: .normal)
        }
    }
}
