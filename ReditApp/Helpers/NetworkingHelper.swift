import UIKit

class NetworkingHelper {
    
    enum Constants {
        static let baseURL = "http://www.reddit.com/.json"
        static let afterURL = baseURL + "?after="
    }
    
    func getData(with completion: @escaping (ReditJSON?) -> Void) {
        executeRequest(with: Constants.baseURL, completion: completion)
    }
    
    func refreshData(with after: String, completion: @escaping (ReditJSON?) -> Void) {
        let urlString = Constants.afterURL + after
        executeRequest(with: urlString, completion: completion)
    }
    
    private func executeRequest(with urlString: String, completion: @escaping (ReditJSON?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completion(nil)
            } else {
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                let reditJSON = try! JSONDecoder().decode(ReditJSON.self, from: data)
                completion(reditJSON)
            }
        }.resume()
    }
    
    func getImage(with urlString: String, completion: @escaping (UIImage?) -> Void)  {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error {
                completion(nil)
            } else {
                guard let data = data else { return }
                let image = UIImage(data: data)
                completion(image)
            }
        }.resume()
    }
}
