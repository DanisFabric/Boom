//
//  Boom.swift
//  BoomSample
//
//  Created by 黄明 on 2017/5/24.
//  Copyright © 2017年 Danis. All rights reserved.
//

import Foundation

public class Action {
    public let title: String
    public let handler: (() -> Void)
    
    public init(title: String, handler: @escaping (() -> Void)) {
        self.title = title
        self.handler = handler
    }
}

public enum Style {
    public enum InfoType {
        case dark
        case light
    }
    case success
    case warning
    case info(InfoType)
    
    var isBlur: Bool {
        switch self {
        case .info(let infoType):
            switch infoType {
            case .dark:
                return false
            case .light:
                return true
            }
        default:
            return false
        }
    }
    var isLightContent: Bool {
        switch self {
        case .info(let infoType):
            switch infoType {
            case .dark:
                return true
            case .light:
                return false
            }
        case .success:
            return false
        case .warning:
            return true
        }
    }
}


public class Boom {
    public typealias CardIndex = Int
    
    public var offset: UIOffset {
        get {
            return container.offset
        }
        set {
            container.offset = newValue
        }
    }
    
    public var duration: TimeInterval = 2
    
    fileprivate var cards = [CardIndex: CardView]()
    fileprivate var counter: CardIndex = 0
    
    fileprivate var container: BoomContainer!
    
    public init(base: Any) {
        switch base {
        case let viewController as UIViewController:
            container = BoomContainer(baseView: viewController.view)
        case let view as UIView:
            container = BoomContainer(baseView: view)
        default:
            break
        }
    }
}


private let PreferedCardHeight: CGFloat = 40
private let PreferedCardPadding = UIOffset(horizontal: 16, vertical: 9)

extension Boom {
    @discardableResult
    public func show(toast style: Style, title: String, duration: TimeInterval? = nil) -> CardIndex {
        let toast = Toast(frame: container.preferdCardFrame, style: style, title: title)
        counter += 1
        cards[counter] = toast
        
        container.show(card: toast, completion: nil)
        
        let tempIndex = counter
        DispatchQueue.main.asyncAfter(deadline: .now() + (duration ?? self.duration)) {
            self.dismiss(at: tempIndex)
        }
        
        return counter
    }
    @discardableResult
    public func show(snackBar style: Style, title: String, action: Action) -> CardIndex {
        counter += 1
        let tempCount = counter
        let snackBar = SnackBar(frame: container.preferdCardFrame, style: style, title: title, action: action, closeHandler: { [unowned self] in
            self.dismiss(at: tempCount)
        })
        cards[counter] = snackBar
        
        container.show(card: snackBar, completion: nil)
        
        return counter
    }
    
    
    public func dismiss(at index: CardIndex) {
        guard let card = cards.removeValue(forKey: index) else {
            return
        }
        container.dismiss(card: card, completion: nil)
    }

}

