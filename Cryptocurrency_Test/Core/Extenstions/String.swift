//
//  String.swift
//  Cryptocurrency_Test
//
//  Created by Ashish Viltoriya on 04/11/24.
//

import Foundation

extension String {
    var removingHTMLOccurancies: String {
        return self.replacingOccurrences(of: "<[ˆ>]+>", with: "", options: .regularExpression, range: nil)
    }
}

extension String {

    func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"

         return convertDateFormatter.string(from: oldDate!)
    }
}
