//
//  TopBarMeunCollectionCell.swift
//  TopBarMenuDemo
//
//  Created by Min on 2018/12/23.
//  Copyright © 2018 Min. All rights reserved.
//

import UIKit

class TopBarMeunCollectionCell: UICollectionViewCell {
    
    var titleType: DemoTestViewModel = .red {
        didSet {
            titleLabel.text = titleType.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUserInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? .white : .lightGray
        }
    }
    
    // MARK: - private Method
    
    private func setUserInterface() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(titleLabel)
    }
    
    // MARK: - init Element
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: (bounds.height - 20) / 2, width: bounds.width, height: 20))
        label.textAlignment = .center
        label.font = UIFont(name: GlobalClass.avenirNext_Regular, size: 10)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
}
