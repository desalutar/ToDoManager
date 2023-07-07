import UIKit

final class TableViewController: UITableViewController {
    
    private var todos = [[ToDoItem]]() {
        didSet { tableView.reloadData() }
    }
    
    private var indexToDo: Int?   // global var for the operation of the row index in the extension
    private var sectionToDo: Int?
    
    private var buttonOnTheCell: Bool?
    private var sectionTitle = [firstTitleForSection, secondTitleForSection]
    
    static let firstTitleForSection = "title_of_the_first_task_section".locolized
    static let secondTitleForSection = "title_of_the_second_task_section".locolized
    
    enum Constants {
        static let addTaskIndentifier: String = "addTaskVc"
        static let cellIndentifier: String = "ToDoCell"
        static let mainStoryboard: String = "Main"
        static let secondVC: String = "secondVC"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // removes the name of the upper section in its absence
        
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
        ) as? ToDoCell else { return UITableViewCell() }  // cast on your cell
        
        let todo = todos[indexPath.section]
        cell.configureCell(with: todo[indexPath.row], indexPath: indexPath) // config a cell from a cell
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if todos[section].isEmpty {
            return nil
        }
        return sectionTitle[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let secondeVC = UIStoryboard(name: Constants.mainStoryboard, bundle: .main).instantiateViewController(
            withIdentifier: Constants.secondVC) as? AddTaskViewController else {
            fatalError("class_instance_creation_error_output".locolized)
        }
        
        let todoSection = todos[indexPath.section]
        
        _ = secondeVC.view
        secondeVC.configure(with: todoSection[indexPath.row])
        secondeVC.type = .edit
        secondeVC.delegate = self
        navigationController?.pushViewController(secondeVC, animated: true)
        
        indexToDo = indexPath.row
        sectionToDo = indexPath.section
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { // swipe deleted todo
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            todos[indexPath.section].remove(at: indexPath.row) // find the desired section, then the desired cell and delete
        }
    }
}

// MARK: - Extensions
extension TableViewController: AddTaskVCDelegate {
    // here we get data from the second view
    func didCreateToDo(todo: ToDoItem) {
        if todos.isEmpty {
            todos.append([todo])
        } else {
            todos[0].append(todo)
        }
    }
    
    func didUpdateToDo(todo: ToDoItem) { 
        guard let index = indexToDo,
              let section = sectionToDo else { return }
        todos[section][index] = todo
    }
    
    func didDeleteToDo() { // add protocol method for delete todo
        guard let index = indexToDo else { return }
        todos.remove(at: index)
    }
}


extension TableViewController: TableViewCellDelegate { // extension for button in cell
    func cell(_: ToDoCell, didSelectedAt indexPath: IndexPath) {
        todos[indexPath.section][indexPath.row].isCompleted.toggle() // through the section we find the desired cell with a button and switch
        buttonOnTheCell = todos[indexPath.section][indexPath.row].isCompleted
        let selectedTodo = todos[indexPath.section][indexPath.row]
        
        if buttonOnTheCell! {
            if todos.count == 1 {
                todos.append([selectedTodo])
                todos[0].remove(at: indexPath.row)
            } else if todos.count >= 1 {
                todos[1].append(selectedTodo)
                todos[0].remove(at: indexPath.row)
            } else if todos[1].count == 1{
                todos[1].append(selectedTodo)
                todos[0].remove(at: indexPath.row)
            }
        } else {
            if todos[1].count >= 1 {
                todos[0].append(selectedTodo)
                todos[1].remove(at: indexPath.row)
            }
        }
    }
}
