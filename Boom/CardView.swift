//
//  CardView.swift
//  BoomSample
//
//  Created by 黄明 on 2017/5/24.
//  Copyright © 2017年 Danis. All rights reserved.
//

import UIKit


class CardView: UIView {
    var blurView: UIVisualEffectView?
    
    init(frame: CGRect, style: Style) {
        super.init(frame: frame)
        
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        switch style {
        case .warning:
            backgroundColor = UIColor(hex: 0xf13649)
        case .info(let infoType):
            if infoType == .light {
                blurView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
                blurView?.layer.cornerRadius = 2
                blurView?.layer.masksToBounds = true
                addSubview(blurView!)
            } else {
                backgroundColor = UIColor(hex: 0x2d2d2d)
            }
        case .success:
            backgroundColor = UIColor(hex: 0xffd200)
        }
        
        layer.cornerRadius = 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        blurView?.frame = bounds
    }
}
