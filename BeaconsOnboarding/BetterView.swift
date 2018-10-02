//
//  BetterView.swift
//  BeaconsOnboarding
//
//  Created by Franco Rivera on 9/25/18.
//  Copyright © 2018 Franco Rivera. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class BetterView: UIView{
    @IBInspectable var borderRadius: CGFloat = 0.0{
        didSet{
            self.layer.cornerRadius = borderRadius
        }
    }
}
