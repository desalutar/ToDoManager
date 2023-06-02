import UIKit

protocol AddTaskVCDelegate: AnyObject {
    func didCreateToDo(todo: ToDoItem)
    func didUpdateToDo(todo: ToDoItem)
}

class AddTaskViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: AddTaskVCDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    
    enum ControllerType {
        case create
        case edit
    }
    var controllerCreate = ControllerType.create
    var controllerEdit = ControllerType.edit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        textField.delegate = self
        textView.delegate = self
    }
    
    
    func cellsSetup(with todos: ToDoItem) {
        textField.text = todos.title
        textView.text = todos.discription
    }
    
    
    @IBAction func myButton(_ sender: Any) {
        let todo = ToDoItem(title: textField.text!, discription: textView.text!)
        delegate?.didCreateToDo(todo: todo) // here we send data to the object who is subscribed to our delegate
        dismiss(animated: true)

        let updateToDo = ToDoItem(title: textField.text!, discription: textView.text!)
        delegate?.didUpdateToDo(todo: updateToDo)
        dismiss(animated: true)

    }
    
}



extension AddTaskViewController: UITextFieldDelegate {
    
}
