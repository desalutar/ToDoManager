import UIKit

class TableViewController: UITableViewController {
    
    private var todos = [ToDoItem]()  // array that we use as a datasource
    private var selectedIndex: Int?   // глобальная переменная для работы индекса строки в расширении
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Не рекомендуется писать захардкоженный текст вот в таком виде как тут
        // для этого создай `enum Constants` например где будет статичное поле к примеру `addTaskIndentifier` которому будет
        // присвоена строка "addTaskVc"
        if segue.identifier == "addTaskVc" {
            let addTaskVC = segue.destination as? AddTaskViewController // create a link to the second view controller
            addTaskVC?.type = .create
            addTaskVC?.delegate = self // subscribe it to the delegate of the second controller
        }
    }
    
    
    
    // MARK: - Table view Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Тоже и тут про захардкоженный текст. Убрать в константы
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell",
                                                       for: indexPath) as? TableViewCell else { return UITableViewCell() }  // cast on your cell
        let todo = todos[indexPath.row] // pick up the current body by cell index
        
        // тут как вариант можно немного упростить, но это по желанию
        // `cell.configuriCell(with: todos[indexPath.row])`
        cell.configuriCell(with: todo) // config a cell from a cell
        return cell
    }
    
    
    //     redefining the height of our row
    // Нет, так не пойдет! ❌ 💩💩💩
    // Вот что такое `118` ? я то понимаю что высота ячейки, но ячейка должна менять высоту динамически в зависимости от текста
    // Удали это, в исправь констрэнты
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Захардкоженные строки
        guard let secondeVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(
            withIdentifier: "secondVC") as? AddTaskViewController else {
            fatalError("Unable to Instantiate Quotes View Controller")
        }
        
        let todo = todos[indexPath.row]
        _ = secondeVC.view
        secondeVC.configure(with: todo)
        secondeVC.type = .edit
        secondeVC.delegate = self
        navigationController?.pushViewController(secondeVC, animated: true)
        
        selectedIndex = indexPath.row
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { // swipe deleted todo
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            todos.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
}


// MARK: - Extensions
extension TableViewController: AddTaskVCDelegate {
    // here we get data from the second view
    func didCreateToDo(todo: ToDoItem) {
        todos.append(todo) // add a new element to the array
        tableView.reloadData() // reload the table
    }
    
    func didUpdateToDo(todo: ToDoItem) {
        guard let index = selectedIndex else { return }
        todos[index] = todo
        tableView.reloadData()
    }
    
    func didDeleteToDo() { // add protocol method for delete todo
        guard let index = selectedIndex else { return }
        todos.remove(at: index)
        tableView.reloadData()
    }
}
