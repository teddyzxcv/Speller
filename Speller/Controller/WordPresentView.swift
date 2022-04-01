//
//  WordPresentView.swift
//  Speller
//
//  Created by ZhengWu Pan on 01.04.2022.
//

import Foundation
import UIKit

class WordPresentView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI(buttons: [UIButton]) {
        for button in buttons {
            addSubview(button)
            NSLayoutConstraint.activate([
                button.topAnchor.constraint(equalTo:centerYAnchor),
                button.leadingAnchor.constraint(equalTo:leadingAnchor),
                button.trailingAnchor.constraint(equalTo:trailingAnchor),
                button.bottomAnchor.constraint(equalTo:bottomAnchor)
            ])
        }
    }
}
