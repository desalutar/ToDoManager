import Foundation

struct ToDoItem {
    let title: String
    let description: String
    var isCompleted: Bool
    
    init(
        title: String,
        description: String,
        isCompleted: Bool = false
    ) {
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
    }
}


