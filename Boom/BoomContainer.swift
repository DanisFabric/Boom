//
//  BoomContainer.swift
//  BoomSample
//
//  Created by 黄明 on 2017/5/24.
//  Copyright © 2017年 Danis. All rights reserved.
//

import UIKit

private let PreferedCardHeight: CGFloat = 40
private let PreferedCardPadding = UIOffset(horizontal: 16, vertical: 9)

class BoomContainer: UIView {
    var baseView: UIView
    
    var offset: UIOffset = UIOffset()
    
    var preferdCardFrame: CGRect {
        fill()
        
        return CGRect(x: 0, y: 0, width: self.bounds.width - PreferedCardPadding.horizontal * 2, height: PreferedCardHeight)
    }
    
    init(baseView: UIView) {
        self.baseView = baseView
        
        super.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(card: CardView, completion: (() -> Void)?) {
        addSubview(card)
        card.alpha = 0
        card.center = CGPoint(x: bounds.width / 2 + offset.horizontal, y: offset.vertical + card.frame.height / 2 + PreferedCardPadding.vertical)
        card.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.2, animations: {
            card.alpha = 1
            card.transform = CGAffineTransform.identity
            
            self.subviews.filter { $0 != card }.forEach { (subview) in
                if let otherCard = subview as? CardView {
                    otherCard.frame = otherCard.frame.offsetBy(dx: 0, dy: otherCard.frame.height + PreferedCardPadding.vertical)
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
                    otherCard.frame = otherCard.frame.offsetBy(dx: 0, dy: -(otherCard.frame.height + PreferedCardPadding.vertical))
            }
            
        }) { (_) in
            card.removeFromSuperview()
            completion?()
        }

    }
}

extension BoomContainer  {
    fileprivate func fill() {
        if superview == nil {
            baseView.addSubview(self)
            self.frame = baseView.bounds
        }
    }
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        for card in subviews {
            if card.frame.contains(point) {
                return super.hitTest(point, with: event)
            }
        }
        return nil
    }
    
}
