//
//  LikedItemCollectionViewCell.swift
//  ToBuy
//
//  Created by Joy Kim on 7/7/24.
//
import UIKit
import SnapKit

final class LikedItemCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = UIImageView()
    let dateLabel = UILabel()
    let likeBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(likeBtn)
    }
    
    override func configLayout() {
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(contentView).multipliedBy(0.7)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        likeBtn.snp.makeConstraints { make in
            make.trailing.equalTo(dateLabel)
            make.top.bottom.equalTo(dateLabel).inset(10)
            make.width.equalTo(likeBtn.snp.height)
        }
    }
    
    override func configUI() {
        likeBtn.setImage(Icon.likeUnSelected, for: .normal)
        
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.masksToBounds = true
        
        dateLabel.text = "2024-05-07"
    }
    
    
}
