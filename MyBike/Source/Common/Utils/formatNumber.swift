//
//  FormatNumber.swift
//  MyBike
//
//  Created by Sebastian Narvaez on 27/12/24.
//

import Foundation

func formatNumber(_ number: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.minimumFractionDigits = 0
    numberFormatter.maximumFractionDigits = 0
    return numberFormatter.string(from: NSNumber(value: number)) ?? ""
}
