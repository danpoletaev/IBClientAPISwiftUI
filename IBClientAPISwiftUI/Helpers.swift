//
//  Helpers.swift
//  IBClientAPISwiftUI
//
//  Created by Danil Poletaev on 06.05.2022.
//

import Foundation

class Helpers {
    func parseTime(time: String) -> String {
        return "\(time[6])\(time[7]):\(time[8])\(time[9]):\(time[10])\(time[11])"
    }
}
