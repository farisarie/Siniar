//
//  TimeIntervalExtensions.swift
//  Siniar
//
//  Created by yoga arie on 17/05/22.
//

import Foundation

extension TimeInterval{
    var string: String{
        let ti = Int(self)
        
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d", hours,minutes,seconds)
    }
}
