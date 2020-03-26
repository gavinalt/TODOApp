//
//  PassableUIButton.swift
//  TODOTable
//
//  Created by Gavin Li on 3/25/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import UIKit
class PassableUIButton: UIButton {
    var params: Dictionary<String, Any>
    override init(frame: CGRect) {
        self.params = [:]
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        self.params = [:]
        super.init(coder: aDecoder)
    }
}
