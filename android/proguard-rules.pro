# ProGuard rules for OnyxOverlay

# Keep WebView JavaScript interface
-keepclasseswithmembernames class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Keep generic types for WebView
-keep public class * extends android.webkit.WebView
-keep public class * extends android.app.Activity

# Keep all classes in com.onyxoverlay package
-keep class com.onyxoverlay.** { *; }

# Preserve source line numbers for debugging
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile
