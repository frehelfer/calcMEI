//
//  UIViewControllerPreview.swift
//  calcMEI
//
//  Created by Frédéric Helfer on 27/04/23.
//

import Foundation

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController

    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }

    // MARK: - UIViewControllerRepresentable
    func makeUIViewController(context: Context) -> ViewController {
        viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: UIViewControllerRepresentableContext<UIViewControllerPreview<ViewController>>) {
        return
    }
}
#endif

//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//@available(iOS 13.0, *)
//struct ViewController_Preview: PreviewProvider {
//  static var previews: some View {
//      UIViewControllerPreview {
//          SaveConsultViewController()
//      }
//  }
//}
//#endif
