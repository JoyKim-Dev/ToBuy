//
//  NavBackBtnChevron.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit

class NavBackBtnChevron:UIBarButtonItem {
    
    override init() {
        super.init()
        
        image = Icon.chevronLeft
        tintColor = .black
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
