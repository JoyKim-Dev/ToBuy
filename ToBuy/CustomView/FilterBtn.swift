//
//  FilterBtn.swift
//  ToBuy
//
//  Created by Joy Kim on 6/16/24.
//


import UIKit

class FilterBtn:UIButton{
    
    init(btnTitle: String) {
        super.init(frame: .zero)
        
        backgroundColor = Color.white
        layer.borderColor = Color.darkGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        clipsToBounds = true
        setTitleColor(Color.darkGray, for: .normal)
        titleEdgeInsets.left = 5
        titleEdgeInsets.right = 5
        titleEdgeInsets.top = 5
        titleEdgeInsets.bottom = 5
        
        titleLabel?.font = Font.semiBold14
        setTitle(btnTitle, for: .normal)
        addTarget(self, action: #selector(toggleFilterBtn), for: .touchUpInside)
        
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleFilterBtn() {
        guard !isSelected else { return }
            backgroundColor = Color.darkGray
            setTitleColor(Color.white, for: .normal)
        deselectOtherButtons()
    }
    
    func deselectOtherButtons() {
        guard let superView = superview else { return }
        
        for case let button as FilterBtn in superView.subviews {
            if button != self {
                button.isSelected = false
                button.backgroundColor = Color.white
                               button.setTitleColor(Color.darkGray, for: .normal)
            }
        }
    }

    
}
