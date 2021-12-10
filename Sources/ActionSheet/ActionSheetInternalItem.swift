//
//  ActionSheetInternalItem.swift
//
//
//  Created by Ecaterina Raducan on 5/6/21.
//

import SwiftUI

struct ActionSheetInternalItem: View {
  
  private let label: String
  private let type: ActionSheetInternalItemType
  private let callback: (() -> Void)?
  
  static func wrapped(item: ActionSheetItem, closeCallBack: @escaping (() -> Void)) -> ActionSheetInternalItem {
    return ActionSheetInternalItem(label: item.label, type: item.type.internalType, closeCallback: {
      item.callback?()
      closeCallBack()
    })
  }
  
  init(
    label: String,
    type: ActionSheetInternalItemType = .normal,
    closeCallback: (() -> Void)? = nil
  ) {
    self.label = label
    self.type = type
    self.callback = closeCallback
  }
  
  private var content: some View {
    Text(label).frame(maxWidth: .infinity)
  }
}

extension ActionSheetInternalItem {
  var body: some View {
    content
      .frame(height: type.height)
      .contentShape(Rectangle())
      .onTapGesture {
        callback?()
      }
      .font(type.font)
      .foregroundColor(type.foregroundColor)
  }
}

extension ActionSheetInternalItem {
  
  enum ActionSheetInternalItemType {
    case normal, stressed, cancel, title
    
    var foregroundColor: Color {
      switch self {
      case .title: return .gray
      case .stressed: return .red
      case .normal, .cancel: return .green
      }
    }
    
    var font: Font {
      switch self {
        case .cancel: return .system(size: 20, weight: .semibold)
      case .title: return .system(size: 13, weight: .semibold)
      default: return .system(size: 20, weight: .regular)
      }
    }
    
    var height: CGFloat {
      switch self {
      case .title: return 52
      default: return 62
      }
    }
  }
}

#if DEBUG
struct ActionSheetInternalItem_Previews: PreviewProvider {
  static var previews: some View {
    ActionSheetInternalItem(label: "Choose an action", type: .cancel)
  }
}
#endif
