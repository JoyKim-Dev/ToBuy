//
//  BaseCollectionViewCell.swift
//  ToBuy
//
//  Created by Joy Kim on 7/7/24.
//
import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configHierarchy()
        configLayout()
        configUI()
    }
    
    func configHierarchy() {
        
    }
    
    func configLayout() {
        
    }
    
    func configUI() {
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
