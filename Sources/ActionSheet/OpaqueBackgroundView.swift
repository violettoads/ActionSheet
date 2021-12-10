//
//  File.swift
//  
//
//  Created by kat on 10.12.2021.
//

import SwiftUI

struct OpaqueBackgroundView {

  private let callback: (() -> Void)?
  @State private var opacity : Double = 0
  init(callback: (() -> Void)? = nil)
  {
    self.callback = callback
  }

  private var greyView: some View {
    Rectangle()
      .background(Color.gray)
      .opacity(opacity)
      .onTapGesture {
        callback?()
      }
      .edgesIgnoringSafeArea(.all)
  }
}

extension OpaqueBackgroundView: View {

  public var body: some View {
    greyView
      .onAppear {
        withAnimation (Animation.linear(duration: 0.1).delay(0.4)) {
          opacity = 0.4
        }
      }
  }
}

#if DEBUG
struct OpaqueBackgroundView_Previews: PreviewProvider {
  static var previews: some View {
    OpaqueBackgroundView()
  }
}
#endif
