//
//  likedVCBrandCollectionViewCell.swift
//  ToBuy
//
//  Created by Joy Kim on 7/8/24.
//

import UIKit
import SnapKit
import RealmSwift

final class likedVCBrandTableViewCell: BaseTableViewCell {
    
    let brandLabel = UILabel()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout:  collectionViewLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configHierarchy() {
        contentView.addSubview(brandLabel)
        contentView.addSubview(collectionView)
    }
    
    override func configLayout() {
        brandLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(15)
            make.height.equalTo(30)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(brandLabel.snp.bottom).offset(5)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    
    func configUI(data: Folder) {
        super.configUI()
        
        brandLabel.text = data.brandName
        brandLabel.backgroundColor = Color.orange
        brandLabel.textColor = Color.white
        brandLabel.font = Font.heavy20
        
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
       
       let layout = UICollectionViewFlowLayout()
       layout.itemSize = CGSize(width: 140, height:210)
       layout.minimumLineSpacing = 10
       layout.minimumInteritemSpacing = 0
       layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10)
       layout.scrollDirection = .horizontal
       return layout
       
   }
}
