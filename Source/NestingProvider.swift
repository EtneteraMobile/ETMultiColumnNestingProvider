//
//  NestingProvider.swift
//  ETMultiColumnNestingProvider
//
//  Created by Jan Čislinský on 31/03/2017.
//  Copyright © 2017 Etnetera, a. s. All rights reserved.
//

import Foundation
import ETMultiColumnView

// MARK: - BadgeViewProvider

public struct NestingProvider: ViewProvider {

    // MARK: - Variables
    // MARK: public

    public var reuseId: String {
        return "NestingProvider_" + configs.reduce("") { $0 + String($1.columns.count) }
    }

    public var hashValue: Int {
        var hasher = Hasher()
        hasher.combine(configs.hashValue)
        return hasher.finalize()
    }

    // MARK: private

    fileprivate let configs: [ETMultiColumnView.Configuration]

    // MARK: - Initialization

    public init(with configs: [ETMultiColumnView.Configuration]) {
        self.configs = configs
    }

    // MARK: - ViewProvider

    public func make() -> UIView {
        let container = UIView()
        configs.forEach { container.addSubview(ETMultiColumnView(with: $0)) }
        return container
    }

    public func customize(view superview: UIView) {
        guard
            let subviews = superview.subviews as? [ETMultiColumnView], subviews.count == configs.count else {
            preconditionFailure("Expected: [ETMultiColumnView]")
        }

        var lastBottom: CGFloat = 0.0
        for (view, config) in zip(subviews, configs) {
            view.frame = CGRect(origin: view.frame.origin, size: CGSize(width: superview.frame.width, height: view.frame.height))
            do {
                try view.customize(with: config)
                view.frame = CGRect(origin: CGPoint(x: view.frame.origin.x, y: lastBottom), size: view.frame.size)
                lastBottom += view.frame.size.height
            } catch {
                view.frame = CGRect(origin: CGPoint(x: view.frame.origin.x, y: lastBottom), size: .zero)
            }
        }
    }

    public func boundingSize(widthConstraint width: CGFloat) -> CGSize {
        let height = configs.reduce(0) { $0 + ((try? ETMultiColumnView.height(with: $1, width: width)) ?? 0.0) }
        return CGSize(width: width, height: height)
    }
}
