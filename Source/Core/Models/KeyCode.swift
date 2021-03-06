// Copyright © 2022 Brian Drelling. All rights reserved.

// Source: https://raw.githubusercontent.com/zakkhoyt/KeyCodes/master/KeyCode.swift

#if canImport(Carbon)

    import Carbon

    struct KeyCode {
        static let a = UInt16(kVK_ANSI_A)
        static let b = UInt16(kVK_ANSI_B)
        static let c = UInt16(kVK_ANSI_C)
        static let d = UInt16(kVK_ANSI_D)
        static let e = UInt16(kVK_ANSI_E)
        static let f = UInt16(kVK_ANSI_F)
        static let g = UInt16(kVK_ANSI_G)
        static let h = UInt16(kVK_ANSI_H)
        static let i = UInt16(kVK_ANSI_I)
        static let j = UInt16(kVK_ANSI_J)
        static let k = UInt16(kVK_ANSI_K)
        static let l = UInt16(kVK_ANSI_L)
        static let m = UInt16(kVK_ANSI_M)
        static let n = UInt16(kVK_ANSI_N)
        static let o = UInt16(kVK_ANSI_O)
        static let p = UInt16(kVK_ANSI_P)
        static let q = UInt16(kVK_ANSI_Q)
        static let r = UInt16(kVK_ANSI_R)
        static let s = UInt16(kVK_ANSI_S)
        static let t = UInt16(kVK_ANSI_T)
        static let u = UInt16(kVK_ANSI_U)
        static let v = UInt16(kVK_ANSI_V)
        static let w = UInt16(kVK_ANSI_W)
        static let x = UInt16(kVK_ANSI_X)
        static let y = UInt16(kVK_ANSI_Y)
        static let z = UInt16(kVK_ANSI_Z)

        static let number0 = UInt16(kVK_ANSI_0)
        static let number1 = UInt16(kVK_ANSI_1)
        static let number2 = UInt16(kVK_ANSI_2)
        static let number3 = UInt16(kVK_ANSI_3)
        static let number4 = UInt16(kVK_ANSI_4)
        static let number5 = UInt16(kVK_ANSI_5)
        static let number6 = UInt16(kVK_ANSI_6)
        static let number7 = UInt16(kVK_ANSI_7)
        static let number8 = UInt16(kVK_ANSI_8)
        static let number9 = UInt16(kVK_ANSI_9)

        static let keypad0 = UInt16(kVK_ANSI_Keypad0)
        static let keypad1 = UInt16(kVK_ANSI_Keypad1)
        static let keypad2 = UInt16(kVK_ANSI_Keypad2)
        static let keypad3 = UInt16(kVK_ANSI_Keypad3)
        static let keypad4 = UInt16(kVK_ANSI_Keypad4)
        static let keypad5 = UInt16(kVK_ANSI_Keypad5)
        static let keypad6 = UInt16(kVK_ANSI_Keypad6)
        static let keypad7 = UInt16(kVK_ANSI_Keypad7)
        static let keypad8 = UInt16(kVK_ANSI_Keypad8)
        static let keypad9 = UInt16(kVK_ANSI_Keypad9)
        static let keypadClear = UInt16(kVK_ANSI_KeypadClear)
        static let keypadDivide = UInt16(kVK_ANSI_KeypadDivide)
        static let keypadEnter = UInt16(kVK_ANSI_KeypadEnter)
        static let keypadEquals = UInt16(kVK_ANSI_KeypadEquals)
        static let keypadMinus = UInt16(kVK_ANSI_KeypadMinus)
        static let keypadPlus = UInt16(kVK_ANSI_KeypadPlus)
        static let pageDown = UInt16(kVK_PageDown)
        static let pageUp = UInt16(kVK_PageUp)
        static let end = UInt16(kVK_End)
        static let home = UInt16(kVK_Home)

        static let f1 = UInt16(kVK_F1)
        static let f2 = UInt16(kVK_F2)
        static let f3 = UInt16(kVK_F3)
        static let f4 = UInt16(kVK_F4)
        static let f5 = UInt16(kVK_F5)
        static let f6 = UInt16(kVK_F6)
        static let f7 = UInt16(kVK_F7)
        static let f8 = UInt16(kVK_F8)
        static let f9 = UInt16(kVK_F9)
        static let f10 = UInt16(kVK_F10)
        static let f11 = UInt16(kVK_F11)
        static let f12 = UInt16(kVK_F12)
        static let f13 = UInt16(kVK_F13)
        static let f14 = UInt16(kVK_F14)
        static let f15 = UInt16(kVK_F15)
        static let f16 = UInt16(kVK_F16)
        static let f17 = UInt16(kVK_F17)
        static let f18 = UInt16(kVK_F18)
        static let f19 = UInt16(kVK_F19)
        static let f20 = UInt16(kVK_F20)

        static let apostrophe = UInt16(kVK_ANSI_Quote)
        static let backApostrophe = UInt16(kVK_ANSI_Grave)
        static let backslash = UInt16(kVK_ANSI_Backslash)
        static let capsLock = UInt16(kVK_CapsLock)
        static let comma = UInt16(kVK_ANSI_Comma)
        static let help = UInt16(kVK_Help)
        static let forwardDelete = UInt16(kVK_ForwardDelete)
        static let decimal = UInt16(kVK_ANSI_KeypadDecimal)
        static let delete = UInt16(kVK_Delete)
        static let equals = UInt16(kVK_ANSI_Equal)
        static let escape = UInt16(kVK_Escape)
        static let leftBracket = UInt16(kVK_ANSI_LeftBracket)
        static let minus = UInt16(kVK_ANSI_Minus)
        static let multiply = UInt16(kVK_ANSI_KeypadMultiply)
        static let period = UInt16(kVK_ANSI_Period)
        static let `return` = UInt16(kVK_Return)
        static let rightBracket = UInt16(kVK_ANSI_RightBracket)
        static let semicolon = UInt16(kVK_ANSI_Semicolon)
        static let slash = UInt16(kVK_ANSI_Slash)
        static let space = UInt16(kVK_Space)
        static let tab = UInt16(kVK_Tab)

        static let mute = UInt16(kVK_Mute)
        static let volumeDown = UInt16(kVK_VolumeDown)
        static let volumeUp = UInt16(kVK_VolumeUp)

        static let command = UInt16(kVK_Command)
        static let rightCommand = UInt16(kVK_RightCommand)
        static let control = UInt16(kVK_Control)
        static let rightControl = UInt16(kVK_RightControl)
        static let function = UInt16(kVK_Function)
        static let option = UInt16(kVK_Option)
        static let rightOption = UInt16(kVK_RightOption)
        static let shift = UInt16(kVK_Shift)
        static let rightShift = UInt16(kVK_RightShift)

        static let downArrow = UInt16(kVK_DownArrow)
        static let leftArrow = UInt16(kVK_LeftArrow)
        static let rightArrow = UInt16(kVK_RightArrow)
        static let upArrow = UInt16(kVK_UpArrow)
    }

#endif
