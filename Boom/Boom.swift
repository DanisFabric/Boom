//
//  Boom.swift
//  BoomSample
//
//  Created by 黄明 on 2017/5/24.
//  Copyright © 2017年 Danis. All rights reserved.
//

import Foundation

class Action {
    public let title: String
    public let handler: (() -> Void)
    
    public init(title: String, handler: @escaping (() -> Void)) {
        self.title = title
        self.handler = handler
    }
}

public enum Icon {
    case success
    case warning
    case info
    case custom(UIImage)
}

public enum BackgroundStyle {
    case color(UIColor)
    case blur(UIBlurEffectStyle)
    
    var isBlur: Bool {
        switch self {
        case .blur:
            return true
        default:
            return false
        }
    }
}

public enum ContentStyle {
    case light
    case dark
    case custom(UIColor)
}

public enum ToastStyle {
    case success
    case warning
    case info
    case custom(BackgroundStyle, Icon, ContentStyle)
}

public enum SnackBarStyle {
    case success
    case warning
    case info
    case custom(BackgroundStyle, ContentStyle)
}

public class Boom {
    public struct Appearence {
        public static var cornerRadius: CGFloat = 2
        public static var preferdHeight: CGFloat = 48
        public static var maxHeight: CGFloat = 64
        public static var padding = UIOffset(horizontal: 16, vertical: 8)
        public static var duration: TimeInterval = 2
        public static var autoDismissOnAction = true
        
        public struct Shadow {
            public static var isEnabled = true
            public static var offset = UIOffset(horizontal: 0, vertical: 2)
            public static var alpha: CGFloat = 0.3
            public static var color = UIColor.black
            public static var radius: CGFloat = 2
            public static var exceptBlurBackground = true
        }
        
        public struct Icon {
            public static var success = UIImage(named: "card-icon-success", in: Bundle(for: Boom.self), compatibleWith: nil)!
            public static var warning = UIImage(named: "card-icon-warning", in: Bundle(for: Boom.self), compatibleWith: nil)!
            public static var info = UIImage(named: "card-icon-info", in: Bundle(for: Boom.self), compatibleWith: nil)!
        }
        
        public struct Background {
            public static var success = BackgroundStyle.color(UIColor(hex: 0x1bc864))
            public static var warning = BackgroundStyle.color(UIColor(hex: 0xf13649))
            public static var info = BackgroundStyle.blur(.extraLight)
        }
        
        public struct Content {
            public static var success = ContentStyle.light
            public static var warning = ContentStyle.light
            public static var info = ContentStyle.dark
        }
    }
    
    public typealias CardIndex = Int
    
    
    
    
    
    public var offset: UIOffset {
        get {
            return container.offset
        }
        set {
            container.offset = newValue
        }
    }
    
    fileprivate var cards = [CardIndex: CardView]()
    fileprivate var counter: CardIndex = 0
    
    fileprivate lazy var container: BoomContainer = BoomContainer()
    fileprivate var baseView: UIView
    
    public init(base: UIViewController) {
        self.baseView = base.view
    }
    public init(base: UIView) {
        self.baseView = base
    }
}

extension Boom {
    @discardableResult
    public func show(toast style: ToastStyle, title: String, duration: TimeInterval? = nil) -> CardIndex {
        fill()
        let toast = Toast(frame: container.preferdCardFrame, style: style, title: title)
        counter += 1
        cards[counter] = toast
        
        container.show(card: toast, completion: nil)
        
        let tempIndex = counter
        DispatchQueue.main.asyncAfter(deadline: .now() + (duration ?? Boom.Appearence.duration)) {
            self.dismiss(at: tempIndex)
        }
        
        return counter
    }
    @discardableResult
    public func show(snackBar style: SnackBarStyle, title: String, actionTitle: String, action: @escaping (() -> Void)) -> CardIndex {
        fill()
        counter += 1
        let tempCount = counter
        let snackBar = SnackBar(frame: container.preferdCardFrame, style: style, title: title, action: Action(title: actionTitle, handler: { [unowned self] in
            if Boom.Appearence.autoDismissOnAction {
                self.dismiss(at: tempCount)
            }
            
            action()
        }), closeHandler: { [unowned self] in
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
    
    fileprivate func fill() {
        if container.superview == nil {
            baseView.addSubview(container)
            container.frame = baseView.bounds
        }
    }


}

