import Foundation

protocol MainPageViewModelProtocol: AnyObject {
    func setTitle(dateString: String)
    func getData(dish: [Dish])
}

class MainPageViewModel {
    
    weak var delegate: MainPageViewModelProtocol?
    
    func setTitle() {
        let today = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EEEE, MMM d"
        formatter.locale = Locale(identifier: "tr_TR")
        let dateString = formatter.string(from: today)
        
        delegate?.setTitle(dateString: dateString)
    }
    
    func getData(child: String) {
        FirebaseManager.shared.getData(child: "DailyMainDish") { (result: Result<[Dish], NetworkError>) in
            switch result {
            case .success(let success):
                self.delegate?.getData(dish: success)
            case .failure(let failure):
                // TODO: - Show alert messages
                print("Show alert message")
            }
        }
    }
}
