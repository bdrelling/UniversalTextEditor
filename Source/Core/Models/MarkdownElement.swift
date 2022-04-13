/// Source: http://daringfireball.net/projects/markdown/
enum MarkdownElement: CaseIterable {
    case blockQuote
    case codeBlock
    case codeInline
    case emphasis
    case h1
    case h2
    case h3
    case h4
    case h5
    case h6
    case link
    case strikethrough
    case strong
    case unorderedList
    case orderedList

    var pattern: String {
        switch self {
        case .blockQuote:
            return #"(?:^[ \t]*>[ \t]?.+\n(.+\n)*\n*)+"#
        case .codeBlock:
            // Non-static: "(?:\n\n|\\A)((?:(?:[ ]{4}|\t).*\n+)+)((?=^[ ]{0,4}\\S)|\\Z)"
            return #"(?:\n\n|\A)((?:(?:[ ]{4}|\t).*\n+)+)((?=^[ ]{0,4}\S)|\Z)"#
        case .codeInline:
            // Non-static: "(`+)(?:.+?)(?<!`)\\1(?!`)"
            return #"(`{1}).+?\1"#
        case .emphasis:
            // TODO: This should not italicize when preceded by two asterisks, only a single asterisk,
            //       to prevent it from formatting as italic before formatting as bold.
            // Static Modified: #"(\*|_{1})(?=\S)(.+?)(?<=\S)\1"#
            // Old: #"_[^\s][\S ]+[^\s]_"#
            return #"(\*|_{1})[^\s].+?[^\s]\1"#
        case .h1:
            // Old: #"# +[^\s][\S ]+[^\s]\n"#
            return Self.patternForHeader(level: 1)
        case .h2:
            // Old: #"## +[^\s][\S ]+[^\s]\n"#
            return Self.patternForHeader(level: 2)
        case .h3:
            // Old: #"### +[^\s][\S ]+[^\s]\n"#
            return Self.patternForHeader(level: 3)
        case .h4:
            // Old: #"#### +[^\s][\S ]+[^\s]\n"#
            return Self.patternForHeader(level: 4)
        case .h5:
            // Old: #"##### +[^\s][\S ]+[^\s]\n"#
            return Self.patternForHeader(level: 5)
        case .h6:
            // Old: #"###### +[^\s][\S ]+[^\s]\n"#
            return Self.patternForHeader(level: 6)
        case .link:
            // Non-Static: "\\[([^\\[]+)\\]\\([ \t]*<?(.*?)>?[ \t]*((['\"])(.*?)\\4)?\\)"
            return #"\[([^\[]+)\]\([ \t]*<?(.*?)>?[ \t]*((['"])(.*?)\4)?\)"#
        case .strikethrough:
            // TODO: This matches older patterns, not newer patterns.
//            return #"~~[^\s][\S ]+[^\s]~~"#
            return #"(~~)[^\s].+?[^\s]\1"#
        case .strong:
            // Non-Static: "(\\*\\*|__)(?=\\S)(?:.+?[*_]*)(?<=\\S)\\1"
            // Static Modified: #"(\*\*)(?=\S)(?:.+?[*]*)(?<=\S)\1"#
            // Old: #"**[^\s][\S ]+[^\s]**"#
            return #"(\*\*)[^\s].+?[^\s]\1"#
        case .unorderedList:
            return Self.patternForList(marker: #"[*+-]"#)
        case .orderedList:
            // Non-Static: "\\d+[.]"
            return Self.patternForList(marker: #"\d+[.]"#)
        }
    }

    private static func patternForHeader(level: Int) -> String {
        "^(\\#{\(level)})[ \t]*(?:.+?)[ \t]*\\#*\n+"
    }

    private static func patternForList(marker: String) -> String {
        "^(?:[ ]{0,3}(?:\(marker))[ \t]+)(.+)\n"
    }

    // Se-tex Style Headers

    // static let seTextH1 = "^(?:.+)[ \t]*\n=+[ \t]*\n+"
    // static let seTextH2 = "^(?:.+)[ \t]*\n-+[ \t]*\n+"
}
