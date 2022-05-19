//
//  SmallGhostButton.swift
//  Siniar
//
//  Created by yoga arie on 10/05/22.
//

import Foundation
import UIKit

class SmallGhostButton: GhostButton {
    override func setup() {
        super.setup()
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
}
