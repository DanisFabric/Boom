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

public enum Icon {
    case success
    case warning
    case info
    case custom(UIImage)
}

public enum BackgroundStyle {
    case color(UIColor)
    case blur(UIBlurEffectStyle)
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
        public static var preferdHeight: CGFloat = 40
        public static var maxHeight: CGFloat = 64
        public static var padding = UIOffset(horizontal: 16, vertical: 8)
        public static var duration: TimeInterval = 2
        
        public struct Shadow {
            public static var isEnabled = true
            public static var offset = UIOffset(horizontal: 0, vertical: 2)
            public static var alpha: CGFloat = 0.3
            public static var color = UIColor.black
            public static var radius: CGFloat = 2
        }
        
        public struct Icon {
            public static var success = UIImage(named: "card-icon-success", in: Bundle(for: Boom.self), compatibleWith: nil)!
            public static var warning = UIImage(named: "card-icon-warning", in: Bundle(for: Boom.self), compatibleWith: nil)!
            public static var info = UIImage(named: "card-icon-info", in: Bundle(for: Boom.self), compatibleWith: nil)!
        }
        
        public struct Background {
            public static var success = BackgroundStyle.color(UIColor.green)
            public static var warning = BackgroundStyle.color(UIColor.red)
            public static var info = BackgroundStyle.blur(.extraLight)
        }
        
        public struct Content {
            public static var success = ContentStyle.dark
            public static var warning = ContentStyle.dark
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

extension Boom {
    @discardableResult
    public func show(toast style: ToastStyle, title: String, duration: TimeInterval? = nil) -> CardIndex {
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
    public func show(snackBar style: SnackBarStyle, title: String, action: Action) -> CardIndex {
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

