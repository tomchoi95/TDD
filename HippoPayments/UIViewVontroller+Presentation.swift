//
//  UIViewVontroller+Presentation.swift
//  HippoPayments
//
//  Created by 최범수 on 2025-04-18.
//

import Foundation
import UIKit

extension UIViewController {

  /// Travels the `presentedViewController` hierarchy backwards till it finds the topmost one.
  var viewControllerPresentationSource: UIViewController {
    guard let presentedViewController = self.presentedViewController else { return self }

    return presentedViewController.viewControllerPresentationSource
  }
}
