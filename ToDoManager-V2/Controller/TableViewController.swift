//
//  TableViewController.swift
//  ToDoManager-V2
//
//  Created by Ишхан Багратуни on 27.05.23.
//

import UIKit

class TableViewController: UITableViewController {

    private var todos = [ToDoItem]()  // масив который используем как датасорс
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTaskVc" {
            let addTaskVC = segue.destination as? AddTaskViewController // создаем ссылку на второй вьюконтроллер
            addTaskVC?.delegate = self // подписываем его на делегат второго контроллера
        }
    }

    
    
    // MARK: - Table view DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count // номер секции в таблице
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { 
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? TableViewCell else { // кастим по своему ячейку
            return UITableViewCell()
        }
        let todo = todos[indexPath.row] // забираем текущую тудушку по индексуц ячейки
        cell.configuriCell(with: todo) // конфигим ячейку исзодя из ячейки
        return cell // возвращаю ячейку
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 118
//    }
}


extension TableViewController: AddTaskVCDelegate { // тут мы получаем данные с второго вью
    func didCreate(todo: ToDoItem) {
        todos.append(todo) // добавляем новый элемент в массив
        tableView.reloadData() // перезагрузка таблицы
    }
}
