import UIKit

class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        // Si tocamos la ventana base (lo transparente), devuelve nil para que el toque pase al juego
        if hitView == self {
            return nil
        }
        return hitView
    }
}