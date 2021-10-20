//
//  PianoKey.swift
//  PianoView
//
//  Created by Gary Newby on 23/09/2017.
//  Copyright © 2017 Gary Newby. All rights reserved.
//

import UIKit

public enum PianoKeyType {
    case white
    case black
}

public final class PianoKey {
    public let upImage: UIImage
    public let downImage: UIImage
    public let type: PianoKeyType
    public let imageLayer = CALayer()
    public let highlightLayer = CALayer()
    public let noteNumber: Int
    public var isDown = false
    public var isLatched = false
    public var noteLayer: NoteNameLayer?
    public var resetsHighLight: Bool = true

    init(color: UIColor, rect: CGRect, type: PianoKeyType, cornerRadius: CGFloat, showNotes: Bool, noteNumber: Int, label: String?, blackKeyWidth: CGFloat = 0, blackKeyHeight: CGFloat = 0, whiteKeyUpImage: UIImage?, whiteKeyDownImage: UIImage?, blackKeyUpImage: UIImage?, blackKeyDownImage: UIImage?, darkMode: Bool, whiteKeyUpDarkModeImage: UIImage?, whiteKeyDownDarkModeImage: UIImage?, blackKeyUpDarkModeImage: UIImage? , blackKeyDownDarkModeImage: UIImage?) {
        self.noteNumber = noteNumber
        self.type = type
        let x: CGFloat = 1.0
        let rect = CGRect(x: rect.minX, y: rect.minY - (cornerRadius * 2.0), width: rect.width, height: rect.height + (cornerRadius * 2.0))

        imageLayer.contentsCenter = CGRect(x: 0.5, y: 0.5, width: 0.02, height: 0.02)
        imageLayer.frame = rect.insetBy(dx: x, dy: 0)
        imageLayer.isOpaque = true
        imageLayer.backgroundColor = color.cgColor
        imageLayer.cornerRadius = cornerRadius
        imageLayer.masksToBounds = true
        imageLayer.actions = ["onOrderIn": NSNull(), "onOrderOut": NSNull(), "sublayers": NSNull(), "contents": NSNull(), "bounds": NSNull(), "position": NSNull()]

        highlightLayer.backgroundColor = UIColor.clear.cgColor
        highlightLayer.frame = imageLayer.bounds
        imageLayer.addSublayer(highlightLayer)
        
        if type == .white {
            upImage = (darkMode ? whiteKeyUpDarkModeImage : whiteKeyUpImage) ?? UIImage.keyImage(CGSize(width: 21, height: 21), blackKey: false, keyDown: false, keyCornerRadius: cornerRadius, noteNumber: noteNumber)!
            downImage = (darkMode ? whiteKeyDownDarkModeImage : whiteKeyDownImage) ?? UIImage.keyImage(CGSize(width: 21, height: 21), blackKey: false, keyDown: true, keyCornerRadius: cornerRadius, noteNumber: noteNumber)!
            if let image = upImage.cgImage {
                imageLayer.contents = image
            }
            highlightLayer.compositingFilter = "darkenBlendMode"
        } else {
            upImage = (darkMode ? blackKeyUpDarkModeImage : blackKeyUpImage) ?? UIImage.keyImage(CGSize(width: blackKeyWidth, height: blackKeyHeight), blackKey: true, keyDown: false, keyCornerRadius: cornerRadius, noteNumber: noteNumber) ?? UIImage()
            downImage = (darkMode ? blackKeyDownDarkModeImage : blackKeyDownImage) ?? UIImage.keyImage(CGSize(width: blackKeyWidth, height: blackKeyHeight), blackKey: true, keyDown: true, keyCornerRadius: cornerRadius, noteNumber: noteNumber) ?? UIImage()
            if let image = upImage.cgImage {
                imageLayer.contents = image
            }
            highlightLayer.compositingFilter = "lightenBlendMode"
        }

        if let label = label, showNotes {
            var noteLabelHeight = imageLayer.frame.size.height
            if type == .black { noteLabelHeight = noteLabelHeight/1.25 }
            noteLayer = NoteNameLayer(layerHeight: noteLabelHeight, keyRect: rect, noteNumber: noteNumber, label: label)
            if let noteLayer = noteLayer {
                imageLayer.addSublayer(noteLayer)
            }
        }
    }

    func setImage(keyNum _: Int, isDown: Bool) {
        if type == .white {
            let shadowDimension = 0.02
            imageLayer.contents = isDown ? downImage.cgImage : upImage.cgImage
            imageLayer.contentsCenter = CGRect(x: 0.5, y: 0.5, width: shadowDimension, height: shadowDimension)
        } else {
            imageLayer.contents = isDown ? downImage.cgImage : upImage.cgImage
        }
    }
}
