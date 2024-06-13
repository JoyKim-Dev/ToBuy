//
//  ReuseIdentifierProtocol.swift
//  ToBuy
//
//  Created by Joy Kim on 6/13/24.
//

import UIKit

protocol ReuseIdentifierProtocol {
    
    static var identifier: String {get}
}

extension UIViewController: ReuseIdentifierProtocol {

    static var identifier: String {
        return String(describing: self)
    }

}

extension UITableViewCell: ReuseIdentifierProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReuseIdentifierProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}
