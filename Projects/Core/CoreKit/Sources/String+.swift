import Foundation

extension String {
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    public func isValidPhone() -> Bool {
        let phoneRegEx = "^[0-9]{0,1}+[0-9]{5,16}$"
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return phonePred.evaluate(with: self) && self.hasPrefix("010")
    }
    
    public func isValidPassword() -> Bool {
        /// 8자 이상, 영문, 대소문자, 숫자, 특수문자 조합
        let pwRegEx = "^.*(?=.{8,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#$%&?]).*$"
        let pwPred = NSPredicate(format: "SELF MATCHES %@", pwRegEx)
        return pwPred.evaluate(with: self)
    }
    
    public func isValidName() -> Bool {
        /// 한글, 영문, 대소문자, 공백
        /// 앞 뒤 공백 불가
        let nameRegEx = "^.*(?=.{2,20})(?=.*[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z\\s]).*$"
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return namePred.evaluate(with: self) && !self.hasPrefix(" ") && !self.hasSuffix(" ")
    }
    
    public func isValidNickname() -> Bool {
        /// 한글, 영문, 대소문자, 공백
        /// 앞 뒤 공백 불가
        let nicknameRegEx = "^.*(?=.{2,20})(?=.*[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z\\s]).*$"
        let nicknamePred = NSPredicate(format: "SELF MATCHES %@", nicknameRegEx)
        return nicknamePred.evaluate(with: self) && !self.hasPrefix(" ") && !self.hasSuffix(" ")
    }
}
