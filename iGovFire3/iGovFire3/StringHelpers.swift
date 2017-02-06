//
//  StringHelpers.swift
//  iGovFire3
//
//  Created by Ake on 1/10/17.
//  Copyright © 2017 iGov Direct. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}



