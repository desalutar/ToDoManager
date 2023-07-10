import Foundation
import UIKit

struct ToDoItem {
    let title: String
    let description: String
    var isCompleted: Bool
    var picture: UIImage?
    
    init(
        title: String,
        description: String,
        isCompleted: Bool = false,
        picture: UIImage? = nil
    ) {
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.picture = picture
    }
}


