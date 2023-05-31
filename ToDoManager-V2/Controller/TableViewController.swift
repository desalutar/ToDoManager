import UIKit

class TableViewController: UITableViewController {

    private var todos = [ToDoItem]()  // array that we use as a datasource
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTaskVc" {
            let addTaskVC = segue.destination as? AddTaskViewController // create a link to the second view controller
            addTaskVC?.delegate = self // subscribe it to the delegate of the second controller
        }
    }

    
    
    // MARK: - Table view Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell",
                                                       for: indexPath) as? TableViewCell else { return UITableViewCell() }  // cast on your cell
        let todo = todos[indexPath.row] // pick up the current body by cell index
        cell.configuriCell(with: todo) // config a cell from a cell
        
        // Swich in Cell
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.tag = indexPath.row
        
        cell.accessoryView = switchView
        return cell
    }
    
    // redefining the height of our row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
}


// MARK: - Extensions
extension TableViewController: AddTaskVCDelegate { // here we get data from the second view
    func didCreate(todo: ToDoItem) {
        todos.append(todo) // add a new element to the array
        tableView.reloadData() // reload the table
    }
}
