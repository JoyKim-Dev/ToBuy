//
//  LikeBtn.swift
//  ToBuy
//
//  Created by Joy Kim on 6/16/24.
//

import UIKit

class LikeBtn: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
       
        layer.cornerRadius = 10
        clipsToBounds = true
        
        backgroundColor = Color.lightGray
        setImage(Icon.likeUnSelected, for: .normal)
        tintColor = Color.white

        addTarget(self, action: #selector(toggleLikeBtn), for: .touchUpInside)
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleLikeBtn() {
        
        if backgroundColor == Color.lightGray {
            backgroundColor = Color.white
            setImage(Icon.likeSelected, for: .normal)
            tintColor = Color.black
           
        } else {
            backgroundColor = Color.lightGray
            setImage(Icon.likeUnSelected, for: .normal)
            tintColor = Color.white
        }
       
        
    }
    
}
