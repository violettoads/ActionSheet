//
//  ActionSheetItem.swift
//
//
//  Created by Ecaterina Raducan on 5/5/21.
//

import SwiftUI

public struct ActionSheetItem {
  public enum ActionSheetItemType {
    case normal, stressed
    
    internal var internalType: ActionSheetInternalItem.ActionSheetInternalItemType {
      self == .stressed ? .stressed : .normal
    }
  }
  
  let label: String
  let type: ActionSheetItemType
  let callback: (() -> Void)?
  
  public init(
    label: String,
    type: ActionSheetItemType = .normal,
    callback: (() -> Void)? = nil
  ) {
    self.label = label
    self.type = type
    self.callback = callback
  }
}
