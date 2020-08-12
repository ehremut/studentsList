//
//  ViewController.swift
//  tApp
//
//  Created by macOS developer on 16.07.2020.
//  Copyright © 2020 macOS developer. All rights reserved.
//

import UIKit

// MARK: - Class
class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var currentTextField = UITextField()
    
    
    @IBOutlet weak var education: UITextField!
    @IBOutlet weak var formOfEducation: UITextField!
    @IBOutlet weak var payment: UITextField!
    @IBOutlet weak var institutions: UITextField!
    @IBOutlet weak var listForm: UITextField!
    @IBOutlet weak var outletLookList: UIButton!
    var timer : Timer!
    var presenter : MainPresenterProtocol!
    
    let activity = UIActivityIndicatorView()
    var educationPickerView = UIPickerView()
    var formOfEducationPickerView = UIPickerView()
    var paymentPickerView = UIPickerView()
    var institutionsPickerView = UIPickerView()
    var listFormPickerView = UIPickerView()
    var post = [Int : String]()
     let queue = DispatchQueue.global(qos: .utility)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outletLookList.isHidden = true
        
        educationPickerView.tag = 1
        formOfEducationPickerView.tag = 2
        paymentPickerView.tag = 3
        institutionsPickerView.tag = 4
        listFormPickerView.tag = 5
        createPickerWithTextField(textField: education, picker: educationPickerView)
        createPickerWithTextField(textField: formOfEducation, picker: formOfEducationPickerView)
        createPickerWithTextField(textField: payment, picker: paymentPickerView)
        createPickerWithTextField(textField: institutions, picker: institutionsPickerView)
        createPickerWithTextField(textField: listForm, picker: listFormPickerView)
       
    }
    
    
    
    @IBAction func lookList(_ sender: UIButton) {
        self.presenter.getStudents(post: self.post)
        let detailView = ModelBuilder.createDetailModule(students: self.presenter.arrayOfStudents)
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    //    if activity.isAnimating == true {
    //        activity.stopAnimating()
    //        activity.isHidden = true
    //    }
    //
    //        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (t) in
    //            self.startActivity()
    //        })
    
    func startActivity(){
        activity.center = self.view.center
        self.view.addSubview(activity)
        activity.isHidden = false
        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { (t) in
            self.startActivity()
        })
        activity.isHidden = true
        activity.stopAnimating()
    }
    
    //    func stopActivity(){
    //        activity.stopAnimating()
    //    }
    
    func createPickerWithTextField(textField: UITextField, picker: UIPickerView){
        textField.inputView = picker
        picker.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView.tag {
        case 1,2,3,4,5:
            return 1
        default:
            return 1
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            let count = presenter.education!.count
            return count
        case 2:
            presenter.getFormOfEdu(edu: education.text!)
            return presenter.formOfEducation!.count
        case 3:
            presenter.getPayment(edu: education.text!, form: formOfEducation.text!)
            return presenter.payment!.count
        case 4:
            presenter.getInstitutions(edu: education.text!, form: formOfEducation.text!, payment: payment.text!)
            return presenter.institutions!.count
        case 5:
            presenter.getListForm(edu: education.text!, form: formOfEducation.text!, payment: payment.text!, instit: institutions.text!)
            return presenter.listForm!.count
        default:
            return 0
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return presenter.education!.list[row]
        case 2:
            
            return presenter.formOfEducation!.list[row]
        case 3:
            return presenter.payment!.list[row]
        case 4:
            return presenter.institutions!.list[row]
        case 5:
            return presenter.listForm!.list[row]
        default:
            return "None"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        outletLookList.isHidden = true
       // startActivity()
        switch pickerView.tag {
        case 1:
            queue.async {
            
                self.presenter.getFormOfEdu(edu: self.presenter.education!.list[row])
            }
            education.text =  presenter.education!.list[row]
            formOfEducation.text?.removeAll()
            payment.text?.removeAll()
            institutions.text?.removeAll()
            listForm.text?.removeAll()
            education.resignFirstResponder()
        case 2:
            presenter.getPayment(edu: education.text!, form: presenter.formOfEducation!.list[row])
            formOfEducation.text = presenter.formOfEducation!.list[row]
            payment.text?.removeAll()
            institutions.text?.removeAll()
            listForm.text?.removeAll()
            formOfEducation.resignFirstResponder()
        case 3:
            presenter.getInstitutions(edu: education.text!, form: formOfEducation.text!, payment: presenter.payment!.list[row])
            payment.text =  presenter.payment!.list[row]
            institutions.text?.removeAll()
            listForm.text?.removeAll()
            payment.resignFirstResponder()
        case 4:
            presenter.getListForm(edu: education.text!, form: formOfEducation.text!, payment: payment.text!, instit: presenter.institutions!.list[row])
            institutions.text = presenter.institutions!.list[row]
            listForm.text?.removeAll()
            institutions.resignFirstResponder()
        case 5:
            listForm.text = presenter.listForm!.list[row]
            if education.text != "None" && formOfEducation.text != "None" && payment.text != "None" && institutions.text != "None" && listForm.text != "None" {
                outletLookList.isHidden = false
                self.post[1] = education.text!
                self.post[2] = formOfEducation.text!
                self.post[3] = payment.text!
                self.post[4] = institutions.text!
                self.post[5] = presenter.listForm!.list[row]
            }
            listForm.resignFirstResponder()
        default:
            return 
        }
    }
}


extension MainViewController: MainViewProtocol {
    func success() {
        
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}


