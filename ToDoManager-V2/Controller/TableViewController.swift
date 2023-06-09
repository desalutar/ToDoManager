import UIKit

class TableViewController: UITableViewController {
    
    private var todos = [ToDoItem]()  // array that we use as a datasource
    private var selectedIndex: Int?   // global var for the operation of the row index in the extension
    
    enum Constants {
        static let addTaskIndentifier: String = "addTaskVc"
        static let cellIndentifier: String = "ToDoCell"
        static let mainStoryboard: String = "Main"
        static let secondVC: String = "secondVC"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.addTaskIndentifier {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIndentifier,
                                                       for: indexPath) as? TableViewCell else { return UITableViewCell() }  // cast on your cell
        _ = todos[indexPath.row] // pick up the current body by cell index
        cell.configureCell(with: todos[indexPath.row]) // config a cell from a cell
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let secondeVC = UIStoryboard(name: Constants.mainStoryboard, bundle: .main).instantiateViewController(
            withIdentifier: Constants.secondVC) as? AddTaskViewController else {
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
