//
//  Toast.swift
//  BoomSample
//
//  Created by 黄明 on 2017/5/24.
//  Copyright © 2017年 Danis. All rights reserved.
//

import UIKit

class Toast: CardView {
    fileprivate let indicator = UIButton(type: .system)
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()

    init(frame: CGRect, style: Style, title: String) {
        super.init(frame: frame, style: style)
        
        titleLabel.text = title
        indicator.isUserInteractionEnabled = false
        
        addSubview(indicator)
        addSubview(titleLabel)
        
        if style.isLightContent {
            titleLabel.textColor = UIColor.white
            indicator.tintColor = UIColor.white
        } else {
            titleLabel.textColor = UIColor(hex: 0x2d2d2d)
            indicator.tintColor = UIColor(hex: 0x2d2d2d)
        }
        switch style {
        case .info:
            indicator.setImage(UIImage(named: "card-icon-info", in: Bundle(for: Toast.self), compatibleWith: nil), for: .normal)
        case .success:
            indicator.setImage(UIImage(named: "card-icon-success", in: Bundle(for: Toast.self), compatibleWith: nil), for: .normal)
        case .warning:
            indicator.setImage(UIImage(named: "card-icon-warning", in: Bundle(for: Toast.self), compatibleWith: nil), for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        indicator.frame = CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height)
        titleLabel.frame = CGRect(x: indicator.frame.maxX, y: 0, width: bounds.width - indicator.frame.maxX - 16, height: bounds.height)
    }
}
