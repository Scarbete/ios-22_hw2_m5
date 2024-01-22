import UIKit




class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let isOnBoardShow = UserDefaults.standard.bool(forKey: "isOnBoardShow")
        var nav = UINavigationController()
    
        if isOnBoardShow == true {
            nav = UINavigationController(rootViewController: HomeViewVC())
        }
        else {
            nav = UINavigationController(rootViewController: OnBoardVC())
        }
        window.rootViewController = nav
        
        self.window = window
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}
