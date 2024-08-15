import Foundation

extension String {
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    public func isValidPhone() -> Bool {
        let phoneRegEx = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: self)
    }
    
    public func isValidPassword() -> Bool {
        let pwRegEx = "^.*(?=.{8,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#$%&?]).*$"
        let pwPred = NSPredicate(format: "SELF MATCHES %@", pwRegEx)
        return pwPred.evaluate(with: self)
    }
}
