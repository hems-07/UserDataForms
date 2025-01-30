import UIKit

class UserDetailViewController: UIViewController {
    
    var user: User?
    var userIndex: Int?
    var onSave: ((User, Int) -> Void?)?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var viewStack: UIStackView!
    @IBOutlet weak var fullName: UILabel!
    //@IBOutlet weak var editUser: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addUser))
        
        nameLabel.layer.cornerRadius = CGRectGetWidth(nameLabel.frame)/2
        nameLabel.layer.masksToBounds = true
        viewStack.layer.cornerRadius = 8
        
        if let user = user {
            print("User: \(user.firstName) \(user.lastName)")
            nameLabel.text = "\(user.firstName.prefix(1)) \(user.lastName.prefix(1))"
            fullName.text = "\(user.firstName) \(user.lastName)"
            emailLabel.text = user.email
            phoneLabel.text = user.phone
            dobLabel.text = DateFormatter.localizedString(from: user.DOB, dateStyle: .medium, timeStyle: .none)
            genderLabel.text = user.gender
        }
    }

    @IBAction func editUser(_ sender: Any) {
        print("Called")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let addUserVc = storyboard.instantiateViewController(withIdentifier: "AddUserViewController") as? AddUserViewController {
            addUserVc.user = user
            addUserVc.userIndex = userIndex
            //print(addUserVc.user!)
            addUserVc.onSave = { [weak self] updatedUser, index in
                guard let self = self else { return }
                self.onSave?(updatedUser, index!)
                //self.navigationController?.popViewController(animated: true)
                dismiss(animated: true, completion: nil)
                self.user = updatedUser
                self.viewDidLoad()
            }
            self.present(addUserVc, animated: true, completion: nil)
        }
    }
    
}
/*
 if let index = viewModel.users.firstIndex(where: {$0.id == user.id}){
     viewModel.users[index] = updatedUser
     user = updatedUser
 }
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "EditUserSegue" {
         if let detailVC = segue.destination as? AddUserViewController{
             detailVC.user = user
             
             detailVC.onSave = { [weak self] updateUser in
                 guard let self = self else { return }
                 if let index = user?.id {
                     let userIndex = users?.firstIndex(where: {$0.id == index})
                     users?[userIndex!] = updateUser
                     user = updateUser
                     print(user!)
                     dismiss(animated: true, completion: nil)
                 }
             }
         }
     }
 }
 */
