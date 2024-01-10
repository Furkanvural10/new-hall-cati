import Foundation

protocol MainPageViewModelProtocol: AnyObject {
    func setTitle(dateString: String)
    func getDailyMainDish(dish: [Product])
    func getDailyDessert(dessert: [Product])
    func getDrink(drink: [Product])
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
    
    func getDailyMainDish() {
        GetMainDish.shared.getMainDish(child: FirebaseConstants.dailyMainDishChildText) { result in
            switch result {
            case .success(let success):
                self.delegate?.getDailyMainDish(dish: success)
            case .failure(let failure):
                print("Show alert message \(failure.localizedDescription)")
            }
        }
    }
    
    func getDailyDessert() {
        GetDailyDessert.shared.getDailyDessert(child: FirebaseConstants.dailyDessertChildText) { result in
            switch result {
            case .success(let success):
                self.delegate?.getDailyDessert(dessert: success )
            case .failure(let failure):
                print("Failure dessert")
            }
        }
    }
    
    func getAllDrink() {
        GetAllDrink.shared.getAllDrink(child: FirebaseConstants.allDrinkChildText) { result in
            switch result {
            case .success(let success):
                self.delegate?.getDrink(drink: success)
            case .failure(let failure):
                print("Failure drink")
            }
        }
    }
    
}
