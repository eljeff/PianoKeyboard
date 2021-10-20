//
//  PianoKeyboard+DarkMode.swift
//  VHS Synth
//
//  Created by Matthew Fecher on 10/20/21.
//

import UIKit

public class PianoKeyboardDarkMode: PianoKeyboard {
    
    @IBInspectable public var darkMode: Bool = true {
        didSet {
            whiteKeyUpImage = darkMode ? whiteKeyUpDarkModeImage : whiteKeyUpLightModeImage
            whiteKeyDownImage = darkMode ? whiteKeyDownDarkModeImage : whiteKeyDownLightkModeImage
            blackKeyUpImage = darkMode ? blackKeyUpDarkModeImage : blackKeyUpLightModeImage
            blackKeyDownImage = darkMode ? blackKeyDownDarkModeImage : blackKeyDownLightModeImage
        }
    }
    
    @IBInspectable public var whiteKeyUpDarkModeImage: UIImage?
    @IBInspectable public var whiteKeyDownDarkModeImage: UIImage?
    @IBInspectable public var blackKeyUpDarkModeImage: UIImage?
    @IBInspectable public var blackKeyDownDarkModeImage: UIImage?
    @IBInspectable public var whiteKeyUpLightModeImage: UIImage?
    @IBInspectable public var whiteKeyDownLightkModeImage: UIImage?
    @IBInspectable public var blackKeyUpLightModeImage: UIImage?
    @IBInspectable public var blackKeyDownLightModeImage: UIImage?
}
