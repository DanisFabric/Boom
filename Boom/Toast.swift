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

    init(frame: CGRect, style: ToastStyle, title: String) {
        
        let background: BackgroundStyle
        let icon: Icon
        let content: ContentStyle
        
        switch style {
        case .success:
            icon = .success
            background = Boom.Appearence.Background.success
            content = Boom.Appearence.Content.success
        case .info:
            icon = .info
            background = Boom.Appearence.Background.info
            content = Boom.Appearence.Content.info
        case .warning:
            icon = .warning
            background = Boom.Appearence.Background.warning
            content = Boom.Appearence.Content.warning
        case .custom(let customBackground, let customIcon, let customContent):
            icon = customIcon
            background = customBackground
            content = customContent
        }
        
        super.init(frame: frame, backgroundStyle: background)
        
        titleLabel.text = title
        indicator.isUserInteractionEnabled = false
        
        addSubview(indicator)
        addSubview(titleLabel)
        
        
        let contentColor: UIColor
        switch content {
        case .light:
            contentColor = UIColor.white
        case .dark:
            contentColor = UIColor.black
        case .custom(let color):
            contentColor = color
        
        }
        titleLabel.textColor = contentColor
        indicator.tintColor = contentColor
        
        switch icon {
        case .info:
            indicator.setImage(Boom.Appearence.Icon.info, for: .normal)
        case .success:
            indicator.setImage(Boom.Appearence.Icon.success, for: .normal)
        case .warning:
            indicator.setImage(Boom.Appearence.Icon.warning, for: .normal)
        case .custom(let image):
            indicator.setImage(image, for: .normal)
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
