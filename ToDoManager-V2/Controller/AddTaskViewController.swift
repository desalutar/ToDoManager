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
        case none
    }
    
    var controllerCreate = ControllerType.none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        textField.delegate = self
        textView.delegate = self
    }
    
    
    func configure(with todos: ToDoItem) {
        textField.text = todos.title
        textView.text = todos.discription
    }
    
    
    @IBAction func myButton(_ sender: Any) {
        let todoFromTappedButton = ToDoItem(title: textField.text!, discription: textView.text!)
        
        switch controllerCreate {
        case .create:
            delegate?.didCreateToDo(todo: todoFromTappedButton) // here we send data to the object who is subscribed to our delegate
            dismiss(animated: true)
        case .edit:
            delegate?.didUpdateToDo(todo: todoFromTappedButton)
            navigationController?.popViewController(animated: true)
        case .none:
            print("Error")
        }
    }
}



extension AddTaskViewController: UITextFieldDelegate {
    
}
