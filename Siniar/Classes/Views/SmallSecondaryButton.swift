//
//  SmallSecondaryButton.swift
//  Siniar
//
//  Created by yoga arie on 10/05/22.
//

import Foundation
import UIKit

class SmallSecondaryButton: SecondaryButton {
    override func setup() {
        super.setup()
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
    }
}
