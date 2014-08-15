//
//  SolidButton.swift
//  PopPrototype
//
//  Created by sam on 15/08/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

import UIKit

@IBDesignable
class SolidButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configure()
  }
  
  required init(coder aDecoder: NSCoder!) {
    super.init(coder: aDecoder)
    self.configure()
  }
  
  override func intrinsicContentSize() -> CGSize {
    let originalSize = super.intrinsicContentSize()
    return CGSizeMake(originalSize.width + 50, originalSize.height + 15)
  }
  
  private func configure() {
    self.layer.cornerRadius = 5
  }

}
