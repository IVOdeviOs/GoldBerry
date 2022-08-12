

import Foundation
import SwiftUI

class TabBarViewModel: ObservableObject {
    @Published var selected = 0
    @Published var sheetPerehod = false
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
}
