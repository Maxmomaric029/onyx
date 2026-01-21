import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // USAMOS NUESTRA CLASE PERSONALIZADA
        let window = PassThroughWindow(windowScene: windowScene)
        
        // --- LA MAGIA DEL OVERLAY ---
        // UIWindow.Level.alert hace que flote sobre las apps normales
        window.windowLevel = UIWindow.Level.alert + 1 
        window.backgroundColor = .clear
        window.isOpaque = false
        
        let rootVC = ViewController()
        rootVC.view.backgroundColor = .clear
        
        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
    }
}