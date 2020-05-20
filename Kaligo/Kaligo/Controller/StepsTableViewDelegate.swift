//
//  StepsTableViewDelegate.swift
//  Kaligo
//
//  Created by Lia Kassardjian on 19/05/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class StepsTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var steps: [ModeloPasso] = [ModeloPasso(number: 1)]
    
    weak var titleDelegate: TextFieldDelegate?
    weak var urlDelegate: TextFieldDelegate?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (steps.isEmpty && section == 0) || section == 1 {
            return 1
        }
        
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "stepCell",
                for: indexPath) as? StepTableViewCell
                else { return UITableViewCell() }
            
            if steps.isEmpty {
                cell.deleteButton.tag = 0
                cell.stepNumber.text = "1"
            } else {
                let step = steps[indexPath.row]
                
                cell.deleteButton.tag = step.number - 1
                cell.stepNumber.text = "\(step.number)"
                
                cell.titleTextField.text = step.title
                cell.titleTextField.tag = step.number - 1
                cell.titleTextField.delegate = titleDelegate
                
                cell.descriptionTextView.text = step.description
                cell.descriptionTextView.tag = step.number - 1
                
                cell.urlTextField.text = step.url
                cell.urlTextField.tag = step.number - 1
                cell.urlTextField.delegate = urlDelegate
            }
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addStepCell", for: indexPath)
            
            return cell
        }
    }
    
    func deleteStep(at index: Int) {
        self.steps.remove(at: index)
        for i in 0 ..< steps.count {
            steps[i].number = i + 1
        }
    }
    

    
}
