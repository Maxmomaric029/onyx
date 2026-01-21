import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = WKWebViewConfiguration()
        
        // ESTO ES LO QUE ARREGLA LAS KEYS:
        // Permite que el HTML cargado localmente hable con internet (KeyAuth)
        config.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        config.setValue(true, forKey: "allowUniversalAccessFromFileURLs")
        
        // Permitir acceso CORS desde archivos locales
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        config.preferences.javaScriptEnabled = true
        
        webView = WKWebView(frame: view.bounds, configuration: config)
        webView.backgroundColor = .clear
        webView.isOpaque = false
        webView.scrollView.backgroundColor = .clear
        webView.scrollView.isScrollEnabled = true
        webView.navigationDelegate = self
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.isUserInteractionEnabled = true
        view.addSubview(webView)
        
        // Cargar desde la carpeta www
        if let bundlePath = Bundle.main.resourcePath,
           let www = bundlePath.appending("/www"),
           let indexPath = Bundle.main.path(forResource: "index", ofType: "html", inDirectory: "www") {
            let url = URL(fileURLWithPath: indexPath)
            let baseURL = URL(fileURLWithPath: www)
            webView.loadFileURL(url, allowingReadAccessTo: baseURL)
        } else {
            // Error fallback
            webView.loadHTMLString("<html><body style='background: #000; color: #a020f0; font-family: sans-serif; display: flex; align-items: center; justify-content: center; height: 100vh;'><h1>Error: No se pudo cargar index.html</h1></body></html>", baseURL: nil)
        }
    }
}