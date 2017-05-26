//
//  BoomContainer.swift
//  BoomSample
//
//  Created by 黄明 on 2017/5/24.
//  Copyright © 2017年 Danis. All rights reserved.
//

import UIKit

class BoomContainer: UIView {
    var offset: UIOffset = UIOffset()
    
    var preferdCardFrame: CGRect {
        return CGRect(x: 0, y: 0, width: self.bounds.width - Boom.Appearence.padding.horizontal * 2, height: Boom.Appearence.preferdHeight)
    }
    
    func show(card: CardView, completion: (() -> Void)?) {
        addSubview(card)
        card.alpha = 0
        card.center = CGPoint(x: bounds.width / 2 + offset.horizontal, y: offset.vertical + card.frame.height / 2 + Boom.Appearence.padding.vertical)
        card.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.2, animations: {
            card.alpha = 1
            card.transform = CGAffineTransform.identity
            
            self.subviews.filter { $0 != card }.forEach { (subview) in
                if let otherCard = subview as? CardView {
                    otherCard.frame = otherCard.frame.offsetBy(dx: 0, dy: otherCard.frame.height + Boom.Appearence.padding.vertical)
                }
            }
            
        }) { (_) in
            completion?()
        }
    }
    func dismiss(card: CardView, completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.2, animations: {
            card.alpha = 0
            card.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            self.subviews.filter {
                $0.frame.minY > card.frame.minY
                }.forEach { (otherCard) in
                    otherCard.frame = otherCard.frame.offsetBy(dx: 0, dy: -(otherCard.frame.height + Boom.Appearence.padding.vertical))
            }
            
        }) { (_) in
            card.removeFromSuperview()
            completion?()
        }

    }
}

extension BoomContainer  {
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for card in subviews {
            if card.frame.contains(point) {
                return super.hitTest(point, with: event)
            }
        }
        return nil
    }
    
}
