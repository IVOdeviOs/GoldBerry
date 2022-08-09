

import Foundation
import SwiftUI

class TabBarViewModel: ObservableObject {
    @Published var selected = 0
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
}
