//
//  BadgeView.swift
//  ETMultiColumnBadgeViewProvider
//
//  Created by Petr Urban on 16/02/2017.
//
//

import UIKit

/// View with text inside of colored circle
class BadgeView: UIView {

    // MARK: - Variables

    // MARK: private

    private lazy var label: UILabel = {
        let l = UILabel()

        l.textAlignment = .Center
        l.adjustsFontSizeToFitWidth = true
        l.minimumScaleFactor = 0.5

        return l
    }()

    private var textInset: CGFloat = 2.0

    // MARK: - Initialization

    init(font: UIFont?, textInset inset: CGFloat?) {
        super.init(frame: .zero)
        setup()
        label.font = font ?? UIFont.boldSystemFontOfSize(10)
        if let i = inset {
            textInset = i
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(frame.width/2, frame.height/2)
        label.frame = bounds.insetBy(dx: textInset, dy: textInset)
        label.center = CGPoint(x: frame.width/2, y: frame.height/2)
    }
    
    private func setup() {
        addSubview(label)
    }

    // MARK: - Customize

    func customize(text: String, backgroundColor bg: UIColor, textColor: UIColor) {
        label.text = text
        backgroundColor = bg
        label.textColor = textColor
    }
}
