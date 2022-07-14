

import Foundation

class Formatter {
    class func membersCount(_ value:Int)->String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.groupingSize = 3
        return String((formatter.string(for: value) ?? ""))
    }
}

