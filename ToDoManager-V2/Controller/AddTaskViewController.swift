import UIKit

protocol AddTaskVCDelegate: AnyObject {
    func didCreate(todo: ToDoItem)
}

class AddTaskViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: AddTaskVCDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        textField.delegate = self
        textView.delegate = self
    }
    
    @IBAction func myButton(_ sender: Any) {
        let todo = ToDoItem(title: textField.text!, discription: textView.text!)
        delegate?.didCreate(todo: todo) // here we send data to the object who is subscribed to our delegate
        dismiss(animated: true)
    }
    
}



extension AddTaskViewController: UITextFieldDelegate {
    
}
