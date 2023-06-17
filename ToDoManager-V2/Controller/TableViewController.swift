import UIKit

class TableViewController: UITableViewController {
    
    private var todos = [[ToDoItem]]()
    private var selectedIndex: Int?   // global var for the operation of the row index in the extension
    private var sectionToDo: Int?
    
    enum Constants {
        static let addTaskIndentifier: String = "addTaskVc"
        static let cellIndentifier: String = "ToDoCell"
        static let mainStoryboard: String = "Main"
        static let secondVC: String = "secondVC"
        static let firstTitleForSection = "Unfulfilled"
        static let secondTitleForSection = "Сompleted"
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
        todos[section].count
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIndentifier,
            for: indexPath
        ) as? TableViewCell else { return UITableViewCell() }  // cast on your cell
        
        let todo = todos[indexPath.section]
        cell.configureCell(with: todo[indexPath.row], indexPath: indexPath) // config a cell from a cell
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        Constants.firstTitleForSection
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let secondeVC = UIStoryboard(name: Constants.mainStoryboard, bundle: .main).instantiateViewController(
            withIdentifier: Constants.secondVC) as? AddTaskViewController else {
            fatalError("Unable to Instantiate Quotes View Controller")
        }
        
        let todoSection = todos[indexPath.section]
        
        _ = secondeVC.view
        secondeVC.configure(with: todoSection[indexPath.row])
        secondeVC.type = .edit
        secondeVC.delegate = self
        navigationController?.pushViewController(secondeVC, animated: true)
        
        selectedIndex = indexPath.row
        sectionToDo = indexPath.section
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { // swipe deleted todo
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            todos[indexPath.section].remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

// MARK: - Extensions
extension TableViewController: AddTaskVCDelegate {
    // here we get data from the second view
    func didCreateToDo(todo: ToDoItem) {
        if todos.isEmpty{
            todos.append([todo]) // add a new element to the
        } else {
            todos[0].append(todo)
        }
        tableView.reloadData() // reload the table
    }
    
    func didUpdateToDo(todo: ToDoItem) {
        guard let index = selectedIndex,
              let section = sectionToDo else { return }
        
        todos[section][index] = todo
        tableView.reloadData()
    }
    
    func didDeleteToDo() { // add protocol method for delete todo
        guard let index = selectedIndex else { return }
        todos.remove(at: index)
        tableView.reloadData()
    }
}

extension TableViewController: TableViewCellDelegate { // extension for button in cell
    func cell(_: TableViewCell, didSelectedAt indexPath: IndexPath) {
        todos[indexPath.section][indexPath.row].isCompleted.toggle()
        tableView.reloadData()
    }
}
