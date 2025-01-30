import UIKit

class AddUserViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let genderOptions = ["Male", "Female", "Other", "Prefer not to say"]
    var selectedGender: String = "Other"
    var user: User?
    var userIndex: Int?
    var onSave: ((User, Int?) -> Void)?
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var birthDate: UIDatePicker!
    @IBOutlet weak var gender: UIPickerView!
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gender.delegate = self
        gender.dataSource = self
        
        if let user = user {
            print(user)
            firstName.text = user.firstName
            lastName.text = user.lastName
            emailID.text = user.email
            phone.text = user.phone
            birthDate.date = user.DOB
            selectedGender = user.gender
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGender = genderOptions[row]
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func isValidPhone(_ phone: String) -> Bool {
        let phoneRegex = "^[0-9]{10}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phone)
    }
    
    @IBAction func cancelPresentation(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func saveUser(_ sender: Any) {
        guard let firstName = firstName.text,
              let lastName = lastName.text,
              let email = emailID.text,
              let phone = phone.text,
                isValidEmail(email),
                isValidPhone(phone) else {return}
        let newUser = User(firstName: firstName, lastName: lastName, gender: selectedGender, email: email, phone: phone, DOB: birthDate.date)
        
        if let index = userIndex {
            onSave?(newUser, index)
        } else {
            onSave?(newUser, nil)
        }
        //onSave?(newUser, users.count)
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func populate(_ sender: Any) {
        firstName.text = "Hemanth"
        lastName.text = "Palani"
        emailID.text = "hemanthpalani001@gmail.com"
        phone.text = "9150998077"
    }

}
