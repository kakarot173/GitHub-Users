//
//  Image.swift
//  GitHub Users
//
//  Created by Animesh Mohanty on 26/06/24.
//

import Foundation
import UIKit

enum Image: String {

    case laptop = "Laptop"

    var bundle: Bundle {
        Bundle(for: BundleHolder.self)
    }

    var value: UIImage? {
        UIImage(named: rawValue, in: bundle, compatibleWith: nil)
    }
}

extension Image {
    class BundleHolder {}
}
