//
//  SecondaryButton.swift
//  Siniar
//
//  Created by yoga arie on 10/05/22.
//

import Foundation
import UIKit

class SecondaryButton: UIButton {
    
    convenience init() {
        self.init(type: .system)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        tintColor = UIColor.brand1
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layer.cornerRadius = 4
        layer.masksToBounds = true
        layer.borderColor = UIColor.brand1.cgColor
        layer.borderWidth = 1.0
    }
}
