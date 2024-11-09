//
//  endEditing.swift
//  Cryptocurrency_Test
//
//  Created by Ashish Viltoriya on 04/11/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

