package com.onyxoverlay.app

import android.os.Bundle
import android.webkit.WebSettings
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.appcompat.app.AppCompatActivity
import androidx.webkit.WebSettingsCompat
import androidx.webkit.WebViewFeature

class MainActivity : AppCompatActivity() {
    private lateinit var webView: WebView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        webView = findViewById(R.id.webview)

        // Configurar WebView
        configureWebView()

        // Cargar index.html desde assets
        loadWebContent()
    }

    private fun configureWebView() {
        webView.apply {
            settings.apply {
                javaScriptEnabled = true
                domStorageEnabled = true
                databaseEnabled = true
                mixedContentMode = WebSettings.MIXED_CONTENT_ALWAYS_ALLOW

                // Permitir acceso a archivos locales (IMPORTANTE PARA EL FUNCIONAMIENTO)
                allowFileAccess = true
                allowContentAccess = true

                userAgentString = "Mozilla/5.0 (Linux; Android ${android.os.Build.VERSION.RELEASE}; ${android.os.Build.MODEL}) AppleWebKit/537.36"

                // Cache
                cacheMode = WebSettings.LOAD_DEFAULT
                setAppCacheEnabled(true)
                setAppCachePath(cacheDir.absolutePath)

                // Rendimiento
                setSupportMultipleWindows(true)
                javaScriptCanOpenWindowsAutomatically = true

                useWideViewPort = true
                loadWithOverviewMode = true
                setSupportZoom(false)
                builtInZoomControls = false
                displayZoomControls = false
            }

            // Cliente de web
            webViewClient = object : WebViewClient() {
                override fun shouldOverrideUrlLoading(view: WebView?, url: String?): Boolean {
                    if (url != null && !url.startsWith("file://")) {
                        // Permitir acceso a URLs externas
                        return false
                    }
                    return false
                }
            }

            // Permitir acceso desde archivos locales a URLs externas (Cross-Origin)
            if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_MESSAGE_LISTENER)) {
                val settings = settings
                if (WebViewFeature.isFeatureSupported(WebViewFeature.SUPPRESS_MIXED_CONTENT)) {
                    WebSettingsCompat.setMixedContentMode(settings, WebSettingsCompat.MIXED_CONTENT_ALWAYS_ALLOW)
                }
            }
        }
    }

    private fun loadWebContent() {
        webView.loadUrl("file:///android_asset/www/index.html")
    }

    override fun onBackPressed() {
        if (webView.canGoBack()) {
            webView.goBack()
        } else {
            super.onBackPressed()
        }
    }
}
