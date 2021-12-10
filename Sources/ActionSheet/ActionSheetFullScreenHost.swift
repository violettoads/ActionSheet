//
//  ActionSheetFullScreenHost.swift
//  
//
//  Created by Ecaterina Raducan on 5/11/21.
//

import UIKit
import SwiftUI

struct ActionSheetFullScreenHost<Content> where Content: View {
  
  @Binding private var isShowing: Bool
  
  private var actionSheet: ActionSheet
  private var baseView: AnyView
  private var showingState: ((Bool) -> Void)
  
  init(_ isShowing: Binding<Bool>, actionSheet: ActionSheet, baseView: AnyView, showingState: @escaping ((Bool) -> Void)) {
    self._isShowing = isShowing
    self.actionSheet = actionSheet
    self.baseView = baseView
    self.showingState = showingState
  }
  
  private static func rootController() -> UIViewController? {
    let scenes = UIApplication.shared.connectedScenes.compactMap {
      $0 as? UIWindowScene
    }
    
    guard !scenes.isEmpty else { return nil }
    for scene in scenes {
      guard let root = scene.windows.first?.rootViewController else {
        continue
      }
      return root
    }
    return nil
  }
  
  private func presentSheet() {
    guard let controller = ActionSheetFullScreenHost.rootController() else { return }
    
    let sheet =  ActionSheetPresentingView(actionSheet, closeAction: {
      guard let controller = ActionSheetFullScreenHost.rootController() else { return }
      controller.presentedViewController?.dismiss(animated: true, completion: nil)
      showingState(false)
    })
    
    let presented = UIHostingController(rootView: sheet)
    presented.modalPresentationStyle = .overCurrentContext
    presented.view.backgroundColor = .clear
    controller.present(presented, animated: true, completion: nil)
  }
  
  private var bodyContent: some View {
    if isShowing { presentSheet() }
    return baseView
  }
}

extension ActionSheetFullScreenHost: View {
  var body: some View {
    bodyContent
  }
}
