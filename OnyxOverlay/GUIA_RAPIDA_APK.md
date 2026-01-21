# Guía Rápida - Convertir a APK

## ✅ Lo que se ha hecho:

1. **Estructura Gradle completa** en `android/`
2. **MainActivity.kt** - Equivalente Android de tu ViewController
3. **AndroidManifest.xml** - Configuración de la app
4. **Recursos** - Colores, strings, temas (matching con tu diseño iOS)
5. **Archivos www/** copiados a `android/src/main/assets/www/`
6. **GitHub Actions** - Workflow para compilar APK automáticamente

## 🚀 Para compilar localmente:

### Opción 1: Android Studio (Recomendado)
```
1. Abre Android Studio
2. File → Open → Selecciona la carpeta "android/"
3. Espera a que Gradle sincronice
4. Build → Build Bundle(s) / APK(s) → Build APK(s)
5. El APK se genera en: android/build/outputs/apk/debug/app-debug.apk
```

### Opción 2: Línea de comandos
```bash
cd android
./gradlew assembleDebug      # APK Debug
./gradlew assembleRelease    # APK Release
```

## 🔐 Para firmar el APK (necesario para Play Store):

```bash
# Generar keystore
keytool -genkey -v -keystore release.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias onyxoverlay

# Luego compilar con firma
cd android
./gradlew bundleRelease
```

## 📱 Instalar en dispositivo

```bash
# Conectar dispositivo con USB debugger activado
cd android
./gradlew installDebug
```

## 🔄 GitHub Actions (Automático)

Ya está configurado. Cada push hará:
1. ✅ Compilación Debug
2. ✅ Compilación Release (sin firmar)
3. ✅ Subida de artefactos (descargables)

## 📦 Estructura de carpetas generada:

```
android/
├── build.gradle.kts                 ← Configuración Gradle
├── settings.gradle.kts
├── proguard-rules.pro
├── gradle.properties
├── .gitignore
├── README_ANDROID.md
└── src/main/
    ├── AndroidManifest.xml
    ├── java/com/onyxoverlay/app/
    │   └── MainActivity.kt
    ├── res/
    │   ├── layout/
    │   │   └── activity_main.xml
    │   └── values/
    │       ├── colors.xml
    │       ├── strings.xml
    │       └── themes.xml
    └── assets/
        └── www/
            └── index.html (+ todos tus archivos)
```

## ⚙️ Configuraciones importantes

### WebView (Android ≥ 6.0)
- ✅ JavaScript habilitado
- ✅ CORS permitido desde archivos locales
- ✅ Mixed Content (HTTP/HTTPS) permitido
- ✅ LocalStorage y SessionStorage habilitados

### Permisos Android
- ✅ INTERNET (para URLs externas)
- ✅ ACCESS_FINE_LOCATION
- ✅ CAMERA
- Añade más en `AndroidManifest.xml` si necesitas

### Versiones
- **Min SDK**: 24 (Android 7.0)
- **Target SDK**: 34 (Android 14)
- **Versión App**: 1.0.0 (cambiar en build.gradle.kts)

## 🐛 Troubleshooting

### Error: "Could not find com.android.application"
```bash
cd android && ./gradlew clean
```

### WebView dice "Cannot load file"
Verifica que existe: `android/src/main/assets/www/index.html`

### Build falla con permisos
```bash
chmod +x android/gradlew
```

### Quiero cambiar el nombre de la app
Edita: `android/src/main/res/values/strings.xml`
```xml
<string name="app_name">Tu Nombre Aquí</string>
```

## 📝 Próximos pasos:

1. ✅ Descarga Android Studio
2. ✅ Abre la carpeta `android/` en Android Studio
3. ✅ Deja que Gradle sincronice
4. ✅ Presiona Build APK
5. ✅ Prueba en emulador o dispositivo
6. ✅ Cuando funcione, genera Release firmado para Play Store

¡Listo! Es prácticamente idéntico a tu workflow de iOS con GitHub Actions. 🎉
