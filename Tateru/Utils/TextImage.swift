//
//  TextImage.swift
//  Tateru
//
//  Created by Tiago Carvalho on 1/22/25.
//


import UIKit

enum TextImage {
    static func generate(from text: String, fontSize: CGFloat = 24) -> UIImage {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize, weight: .medium),
            .foregroundColor: UIColor.label
        ]

        
        let size = (text as NSString).size(withAttributes: attributes)
        
        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { context in
            (text as NSString).draw(at: CGPoint(x: 0, y: 0), withAttributes: attributes)
        }
    }
}
