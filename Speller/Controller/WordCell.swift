//
//  wordCell.swift
//  Speller
//
//  Created by ZhengWu Pan on 01.04.2022.
//

import Foundation
import UIKit

class WordCell: UITableViewCell {
    
    public static let identifier = "WordCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.textAlignment = .center
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setText(text: String) {
        textLabel?.text = text
    }
}
