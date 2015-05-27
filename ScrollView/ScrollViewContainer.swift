//
//  ScrollViewContainer.swift
//  ScrollView
//
//  Created by Macbook Pro MD102 on 5/27/15.
//  Copyright (c) 2015 Macbook Pro MD102. All rights reserved.
//

import UIKit

class ScrollViewContainer: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet var scrollViewD:UIScrollView!
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, withEvent: event)
        if let  theView = view {
            return scrollViewD
        }
        return view
    }

}
