import UIKit

class PostViewModel {
    
    let networkingHelper = NetworkingHelper()
    
    func getImage(with urlString: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlString = urlString else {
            completion(nil)
            return
        }
        networkingHelper.getImage(with: urlString) { image in
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
