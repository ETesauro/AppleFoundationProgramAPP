//
//  CustomView.swift
//  BeMyPal
//
//  Created by Vincenzo Riccio on 12/02/2020.
//  Copyright © 2020 Vincenzo Riccio. All rights reserved.
//

import SwiftUI

extension View {
    static func show(_ shared: Shared) {
        shared.viewToShow = String(describing: self)
    }
}
