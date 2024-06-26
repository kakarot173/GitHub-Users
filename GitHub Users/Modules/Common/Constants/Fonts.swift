//
//  Fonts.swift
//  GitHub Users
//
//  Created by Animesh Mohanty on 26/06/24.
//

import UIKit

public enum CustomFont: String{
    
    case TitleBold
    case TitleMedium
    case TitleRegular
    
    case BodyMedium
    case BodyRegular
    
    case SubtextMedium
    case SubtextRegular
    
    public var font: UIFont{
        switch self{
            
        case .TitleBold:
            return UIFont.systemFont(ofSize: 18.0, weight: .bold)
        case .TitleMedium:
            return UIFont.systemFont(ofSize: 18.0, weight: .medium)
        case .TitleRegular:
            return UIFont.systemFont(ofSize: 16.0, weight: .regular)
        case .BodyMedium:
            return UIFont.systemFont(ofSize: 14.0, weight: .medium)
        case .BodyRegular:
            return UIFont.systemFont(ofSize: 14.0, weight: .regular)
        case .SubtextMedium:
            return UIFont.systemFont(ofSize: 12.0, weight: .medium)
        case .SubtextRegular:
            return UIFont.systemFont(ofSize: 12.0, weight: .regular)
        }
    }
}

