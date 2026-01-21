import UIKit

class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        
        // Si tocamos la ventana base (lo transparente), devuelve nil para que el toque pase al juego
        if hitView == self {
            return nil
        }
        
        // Si el elemento tocado es parte del webView, permitir la interacción
        if hitView is UIView && !(hitView is UIWindow) {
            return hitView
        }
        
        return hitView
    }
}