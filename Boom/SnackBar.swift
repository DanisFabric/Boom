//
//  SnakerBar.swift
//  BoomSample
//
//  Created by 黄明 on 2017/5/24.
//  Copyright © 2017年 Danis. All rights reserved.
//

import UIKit

class SnackBar: CardView {
    var closeHandler: (() -> Void)
    fileprivate let actionHandler: (() -> Void)
    
    fileprivate let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "card-button-close", in: Bundle(for: Toast.self), compatibleWith: nil), for: .normal)
        
        return button
    }()
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    fileprivate let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        return button
    }()

    init(frame: CGRect, style: SnackBarStyle, title: String, action: Action, closeHandler: @escaping (() -> Void)) {
        self.actionHandler = action.handler
        self.closeHandler = closeHandler
        
        let background: BackgroundStyle
        let content: ContentStyle
        
        switch style {
        case .success:
            background = Boom.Appearence.Background.success
            content = Boom.Appearence.Content.success
        case .info:
            background = Boom.Appearence.Background.info
            content = Boom.Appearence.Content.info
        case .warning:
            background = Boom.Appearence.Background.warning
            content = Boom.Appearence.Content.warning
        case .custom(let customBackground, let customContent):
            background = customBackground
            content = customContent
        }
        
        super.init(frame: frame, backgroundStyle: background)
        
        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(actionButton)
        
        titleLabel.text = title
        actionButton.setTitle(action.title, for: .normal)
        actionButton.addTarget(self, action: #selector(onTouchActionButton(_:)), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(onTouchCloseButton(_:)), for: .touchUpInside)
        
        let contentColor: UIColor
        switch content {
        case .light:
            contentColor = UIColor.white
        case .dark:
            contentColor = UIColor.black
        case .custom(let color):
            contentColor = color
            
        }
        closeButton.tintColor = contentColor
        titleLabel.textColor = contentColor
        actionButton.tintColor = contentColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        closeButton.frame = CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height)
        actionButton.sizeToFit()
        let preferedActionButtonWidth = min(64, actionButton.frame.width)
        actionButton.frame = CGRect(x: bounds.width - preferedActionButtonWidth - 16, y: 0, width: preferedActionButtonWidth, height: bounds.height)
        
        titleLabel.frame = CGRect(x: closeButton.frame.maxX, y: 0, width: actionButton.frame.minX - closeButton.frame.maxX - 8, height: bounds.height)
    }
    func onTouchActionButton(_ sender: UIButton) {
        actionHandler()
    }
    func onTouchCloseButton(_ sender: UIButton) {
        closeHandler()
    }
}
