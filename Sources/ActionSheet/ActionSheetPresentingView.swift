//
//  ActionSheetPresentingView.swift
//  
//
//  Created by Ecaterina Raducan on 5/11/21.
//

import SwiftUI

struct ActionSheetPresentingView {
  
  private var actionSheet: ActionSheet
  private var closeAction: (() -> Void)?
  
  init(_ actionSheet: ActionSheet, closeAction: @escaping () -> Void) {
    self.actionSheet = actionSheet
    self.closeAction = closeAction
  }
  
  private var bodyContent: some View {
    ZStack {
      OpaqueBackgroundView {
        self.closeAction?()
      }
      ActionSheet.wrapped(actionSheet: actionSheet, closeAction: closeAction ?? { return })
    }
  }
}

extension ActionSheetPresentingView: View {
  
  public var body: some View {
      bodyContent
  }
}

#if DEBUG
struct ActionSheetPresentingView_Previews: PreviewProvider {
  
  static var previews: some View {
    ActionSheetPresentingView(ActionSheet(title: "Test", items: [], cancelButtonTitle: "Cancel")) { return }
  }
}
#endif
