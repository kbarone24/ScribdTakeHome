//
//  UIImageExtension.swift
//  Scribd Take Home
//
//  Created by Kenny Barone on 3/5/24.
//

import UIKit

extension UIImage {
    enum Asset: String {
        case AmericanGods
        case TheSavageDetectives
        case GiovannisRoom
        case IWhoHaveNeverKnownMen
        case NewDarkAge
        case Underworld
        case HerBodyAndOtherParties
        case PilgrimAtTinkerCreek
        case Lot
        case Island
    }

    convenience init?(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}

