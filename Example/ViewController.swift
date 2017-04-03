//
//  ViewController.swift
//  Example
//
//  Created by Jan Čislinský on 03/04/2017.
//  Copyright © 2017 Etnetera, a. s. All rights reserved.
//

import UIKit
import ETMultiColumnNestingProvider
import ETMultiColumnView

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let col = ETMultiColumnView.Configuration.Column(layout: .relative(), content: PlaceholderProvider())
        let line = ETMultiColumnView.Configuration(columns: [col, col])
        let nested3Lvl = NestingProvider(with: [line, line])

        let nested2LvlCol = ETMultiColumnView.Configuration.Column(layout: .relative(), content: nested3Lvl)
        let nested2LvlLine = ETMultiColumnView.Configuration(columns: [col, nested2LvlCol])
        let nested2LvlOut = NestingProvider(with: [line, nested2LvlLine])

        let nested1LvlCol = ETMultiColumnView.Configuration.Column(layout: .relative(), content: nested2LvlOut)
        let nested1LvlLine = ETMultiColumnView.Configuration(columns: [col, nested1LvlCol])
        let nested1LvlOut = NestingProvider(with: [line, nested1LvlLine])

        let nestedView = nested1LvlOut.make()
        view.addSubview(nestedView)
        nestedView.frame = view.bounds

        nested1LvlOut.customize(view: nestedView)
    }
}


struct PlaceholderProvider: ViewProvider {
    var hashValue: Int = 1
    var reuseId: String = "1"

    func make() -> UIView {
        let view = UIView()
        view.backgroundColor = makeBackground()
        return view
    }

    func customize(view view: UIView) {}

    func size(for width: CGFloat) -> CGSize {
        return CGSize(width: width, height: width)
    }
}

private func makeBackground() -> UIColor {
    return UIColor.init(white: 0.0, alpha: CGFloat(Double(arc4random_uniform(100)) / 100.0))
}