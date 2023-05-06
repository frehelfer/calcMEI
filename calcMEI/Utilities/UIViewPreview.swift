//
//  UIViewPreview.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 27/04/23.
//

import Foundation

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View

    init(_ builder: @escaping () -> View) {
        view = builder()
    }

    // MARK: - UIViewRepresentable
    func makeUIView(context: Context) -> UIView {
        return view
    }

    func updateUIView(_ view: UIView, context: Context) {
        
    }
}
#endif

//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//@available(iOS 13.0, *)
//struct ViewController_Preview: PreviewProvider {
//  static var previews: some View {
//      UIViewPreview {
//
//      }
//  }
//}
//#endif
