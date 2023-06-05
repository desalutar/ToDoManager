import Foundation


// Давай тут попробуем все таки вместо `var` указать `let`
// Мы при редактировании создаем новый ToDoItem и заменяем его в массиве
// и по сути мы не редактируем ToDoItem напрямую типа: todos[index].title = "some title"
struct ToDoItem {
    var title: String
    // очепятка: description
    var discription: String
}
