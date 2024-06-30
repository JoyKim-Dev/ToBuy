//
//  ReuseIdentifierProtocol.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit

protocol ReuseIdentifierProtocol: AnyObject {
    
    static var identifier: String {get}
}

extension UIView: ReuseIdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }
}

