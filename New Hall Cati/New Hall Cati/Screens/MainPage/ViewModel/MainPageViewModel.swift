import Foundation

protocol MainPageViewModelProtocol: AnyObject {
    func setTitle(dateString: String)
    func getDailyMainDish(dish: [Product])
    func getDailyDessert(dessert: [Product])
    func getColdDrink(coldDrink: [Product])
    func getHotDrink(hotDrink: [Product])
    func getDailySnack(snack: [Product])
    func updateRestaurantStatusIsOn()
    func updateRestaurantStatusIsOff()
    func getDailyVideoURL(videoURL: String)
}

final class MainPageViewModel {
    
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
    
    func getAllColdDrink() {
        GetAllDrink.shared.getAllDrink(child: FirebaseConstants.allColdDrinkChildText) { result in
            switch result {
            case .success(let success):
                self.delegate?.getColdDrink(coldDrink: success)
            case .failure(let failure):
                print("Failure cold drink")
            }
        }
    }
    
    func getAllHotDrink() {
        GetAllDrink.shared.getAllDrink(child: FirebaseConstants.allHotDrinkChildText) { result in
            switch result {
            case .success(let success):
                self.delegate?.getHotDrink(hotDrink: success)
            case .failure(let failure):
                print("Failure hot drink")
            }
        }
    }
    
    func getAllSnack() {
        GetAllSnack.shared.getAllSnack(child: FirebaseConstants.dailySnackChildText) { result in
            switch result {
            case .success(let success):
                self.delegate?.getDailySnack(snack: success)
            case .failure(let failure):
                print("Failure snack")
            }
        }
    }
    
    func getDailyVideoURL() {
        FirebaseManager.shared.getDailyVideoURL { result in
            self.delegate?.getDailyVideoURL(videoURL: result)
        }
    }
    
    func getRestaurantStatus() {
        FirebaseManager.shared.getRestaurantStatus { result in
            switch result {
            case .success(let success):
                if success.status {
                    self.delegate?.updateRestaurantStatusIsOff()
                } else {
                    self.delegate?.updateRestaurantStatusIsOn()
                }
                
            case .failure(_):
                break
            }
        }
    }
    
    
}

