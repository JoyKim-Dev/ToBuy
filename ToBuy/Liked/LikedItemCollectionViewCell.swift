//
//  LikedItemCollectionViewCell.swift
//  ToBuy
//
//  Created by Joy Kim on 7/7/24.
//
import UIKit
import SnapKit
import RealmSwift
import Kingfisher


final class LikedItemCollectionViewCell: BaseCollectionViewCell {
    
    let realm = try! Realm()
    let repository = LikedItemTableRepository()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    let likeBtn = UIButton()
    var id = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(likeBtn)
        contentView.addSubview(priceLabel)
    }
    
    override func configLayout() {
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(contentView).multipliedBy(0.7)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(5)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(5)
        }
        
        likeBtn.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(imageView).inset(3)
            make.width.height.equalTo(20)
        }
    }
    
    func configUI(data: LikedItemTable) {
        super.configUI()
        
        id = data.id
        likeBtn.setImage(Icon.likeSelected, for: .normal)
        likeBtn.backgroundColor = Color.white
        
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.masksToBounds = true
        let url = URL(string: data.image)
        imageView.kf.setImage(with: url)
        
        titleLabel.text = data.title.replacingOccurrences(of: "[<b></b>]", with: "", options: .regularExpression)
        titleLabel.numberOfLines = 2
        titleLabel.font = Font.semiBold13
        
        priceLabel.text = "\(data.price)원"
        priceLabel.font = Font.semiBold14
    }
    
}
