//
//  NavBackBtnChevron.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit

class NavBackBtnChevron:UIBarButtonItem {
    
    var returnToVC: UIViewController?
    
    init(previousVC: UIViewController) {
         super.init()
        
         returnToVC = previousVC
         image = Icon.chevronLeft
         style = .plain
         target = self
         action = #selector(self.leftBarBtnTapped)
         tintColor = .black
     }

     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

     @objc private func leftBarBtnTapped() {
         // 여기에 원하는 동작을 구현하세요.
         print("Back button tapped")
            returnToVC?.navigationController?.popViewController(animated: true)
     }
 }
