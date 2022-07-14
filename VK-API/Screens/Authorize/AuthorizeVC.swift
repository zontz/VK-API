
import UIKit
import WebKit


final class AuthorizeVC: UIViewController {
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        setupViews()
        if Session.shared.isTokenValid {
            showMainTabScreen()
            return
        }

        authorizeToVk()
    }
    
    //MARK: - Private methods
    private func setupViews(){
        view.addSubview(webView)
        webView.pinEdgesToSuperView()
    }
    
    private func showMainTabScreen(){
        let mainTabBarVC = MainTabBar()
        navigationController?.pushViewController(mainTabBarVC, animated: true)
        navigationController?.isNavigationBarHidden = true
    }
    

    private func authorizeToVk(){
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8202604"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "271366"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1")
        ]
        guard let url = urlComponents.url else {return}
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension  AuthorizeVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            //Продолжаем слушать запросы браузера
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map{ $0.components(separatedBy: "=")}
            .reduce([String:String]()) { partialResult, item in
                var dictionary = partialResult
                let key = item[0]
                let value = item[1]
                dictionary[key] = value
                return dictionary
            }
        guard let token = params["access_token"], let userId = params["user_id"], let expiresIn = params["expires_in"] else {return}
        Session.shared.accessToken = token
        Session.shared.expiresIn = expiresIn 
        Session.shared.userid = Int(userId) ?? 0
        
        showMainTabScreen()
        
        //Останавливаемся слушать запросы браузера
        decisionHandler(.cancel)
    }
}

