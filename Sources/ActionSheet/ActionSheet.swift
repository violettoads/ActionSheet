//
//  ActionSheet.swift
//
//  Created by Ecaterina Raducan on 5/5/21.
//

import SwiftUI

public struct ActionSheet {

  private let items: [ActionSheetItem]
  private let cellHeight: CGFloat = 62
  private let title: String
  private let cancelButtonTitle: String
  private var closeAction: (() -> Void)?

  public init(
    title: String,
    items: [ActionSheetItem],
    closeAction:(() -> Void)? = nil,
    cancelButtonTitle: String) {
    self.items = items
    self.title = title
    self.cancelButtonTitle = cancelButtonTitle
    self.closeAction = closeAction
  }

  static func wrapped(actionSheet: ActionSheet, closeAction: @escaping (() -> Void)) -> ActionSheet {
    // Adding 'closeAction' to the actionSheet formed externally, containing only the items
    ActionSheet(title: actionSheet.title, items: actionSheet.items, closeAction: closeAction, cancelButtonTitle: actionSheet.cancelButtonTitle)
  }

  private var blackDivider: some View {
    Rectangle().fill(Color.gray).frame(height: 1)
  }

  private var itemsView: some View {
    VStack(spacing: 0) {
      ActionSheetInternalItem(label: title, type: .title)
        .frame(height: 52)
      blackDivider
      ForEach(0..<items.count) { index in
        if index > 0 {
          blackDivider
        }
        let item = items[index]
        ActionSheetInternalItem.wrapped(item: item, closeCallBack: closeAction ?? { return })
          .frame(height: cellHeight)
      }
    }
  }

  private var sheetView: some View {
    VStack(spacing: 12) {
      Spacer()
      // Options container
      itemsView
        .containerStyle(blurred: true)
      // Cancel container
      ActionSheetInternalItem(label: cancelButtonTitle, type: .cancel, closeCallback: {
        closeAction?()
      })
      .containerStyle()
    }
  }

}

extension ActionSheet: View {
  public var body: some View {
      sheetView
  }
}

#if DEBUG
struct ActionSheet_Previews: PreviewProvider {
  static var previews: some View {
    ActionSheet(title: "Generic title", items: [
      ActionSheetItem(label: "Confirm", callback: {
      }),
      ActionSheetItem(label: "Disable all", type: .stressed)
    ], cancelButtonTitle: "Cancel")
  }
}
#endif
