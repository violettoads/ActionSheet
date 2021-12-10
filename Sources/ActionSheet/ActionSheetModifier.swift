//
//  ActionSheetModifier.swift
//  
//
//  Created by Ecaterina Raducan on 5/7/21.
//

import SwiftUI

struct ActionSheetModifier {
  
  private var actionSheetFullScreenHost: ActionSheetFullScreenHost<ActionSheet>
  
  init(_ isShowing: Binding<Bool>, showingState: @escaping ((Bool) -> Void), baseView: AnyView, actionSheet: ActionSheet) {
    self.actionSheetFullScreenHost = ActionSheetFullScreenHost<ActionSheet>(isShowing,
                                                                            actionSheet: actionSheet,
                                                                            baseView: baseView,
                                                                            showingState: showingState)
  }
}

extension ActionSheetModifier: ViewModifier {
  func body(content: Content) -> some View {
    actionSheetFullScreenHost.body
  }
}

extension View {
  /// Action Sheet
  func containerStyle(blurred: Bool = false) -> some View {
    let backgroundColor = Color.white
    let cornerRadus: CGFloat = 4.7
    
    return self.background(backgroundColor.opacity(blurred ? 0.9 : 1).blur(radius: blurred ? 50 : 0, opaque: true))
      .cornerRadius(cornerRadus)
  }
  
  public func actionSheet(isPresented: Binding<Bool>, showingState: @escaping ((Bool) -> Void), content: () -> ActionSheet) -> some View {
    ModifiedContent(content: self, modifier: ActionSheetModifier(isPresented, showingState: showingState, baseView: AnyView(self), actionSheet: content()))
  }
}