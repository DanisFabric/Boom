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
    
    init(frame: CGRect, backgroundStyle: BackgroundStyle) {
        super.init(frame: frame)
        
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        
        switch backgroundStyle {
        case .color(let color):
            layer.contents = UIImage.image(size: frame.size, color: color, cornerRadius: Boom.Appearence.cornerRadius).cgImage
        case .blur(let blurEffectStyle):
            blurView = UIVisualEffectView(effect: UIBlurEffect(style: blurEffectStyle))
            blurView?.layer.cornerRadius = Boom.Appearence.cornerRadius
            blurView?.layer.masksToBounds = true
            
            addSubview(blurView!)
        }
        
        if Boom.Appearence.Shadow.isEnabled {
            layer.shadowColor = Boom.Appearence.Shadow.color.cgColor
            layer.shadowOpacity = Float(Boom.Appearence.Shadow.alpha)
            layer.shadowOffset = CGSize(width: Boom.Appearence.Shadow.offset.horizontal, height: Boom.Appearence.Shadow.offset.vertical)
            layer.shadowRadius = Boom.Appearence.Shadow.radius
            layer.shadowPath = UIBezierPath(roundedRect: CGRect(origin: CGPoint(), size: frame.size), cornerRadius: Boom.Appearence.cornerRadius).cgPath
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        blurView?.frame = bounds
    }
}
