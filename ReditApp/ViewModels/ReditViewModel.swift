import Foundation


class ReditViewModel {
    
    let networkingHelper = NetworkingHelper()
    var reditPosts = [RedditPost]()
    var current = ""
    
    func getData(with completion: @escaping () -> Void) {
        networkingHelper.getData { [weak self] reditJSON in
            self?.reditPosts = reditJSON?.data?.children?.compactMap { $0.post } ?? []
            self?.current = reditJSON?.data?.after ?? ""
            completion()
        }
    }
    
    func updateIfRequired(for index: Int, completion: @escaping () -> Void) {
        if isRefreshRequired(for: index) {
            refreshPosts {
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func isRefreshRequired(for index: Int) -> Bool {
        return reditPosts.count - index < 3
    }
    
    private func refreshPosts(with completion: @escaping () -> Void) {
        guard !current.isEmpty else { return }
        
        networkingHelper.refreshData(with: current) { [weak self] reditJSON in
            let posts = reditJSON?.data?.children?.compactMap { $0.post } ?? []
            self?.reditPosts.append(contentsOf: posts)
            self?.current = reditJSON?.data?.after ?? ""
            completion()
        }
    }
}
