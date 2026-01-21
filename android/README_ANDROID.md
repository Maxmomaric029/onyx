# OnyxOverlay - Android Build Guide

## Estructura del Proyecto

```
android/
├── build.gradle.kts           # Configuración de Gradle
├── settings.gradle.kts        # Configuración de módulos
├── proguard-rules.pro         # Reglas de ofuscación
├── gradle.properties          # Propiedades de Gradle
├── README_ANDROID.md          # Este archivo
└── src/
    └── main/
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
        └── assets/www/         # Copiar todos los archivos de www/ aquí
```

## Requisitos Previos

- Android Studio (versión 2023.1.1 o superior)
- JDK 11 o superior
- SDK de Android 34
- Gradle 8.1.1 o superior

## Instalación y Compilación

### 1. Preparar el proyecto

Copia todos los archivos HTML/CSS/JavaScript de `www/` a la carpeta `android/src/main/assets/www/`:

```bash
mkdir -p android/src/main/assets/www
cp -r www/* android/src/main/assets/www/
```

### 2. Abrir en Android Studio

```bash
# En la raíz del proyecto
open android
```

O abre Android Studio y selecciona "Open Project" → carpeta `android/`

### 3. Sincronizar Gradle

- Android Studio sincronizará automáticamente
- Si no lo hace, usa: `Build` → `Rebuild Project`

### 4. Compilar APK Debug

```bash
cd android
./gradlew assembleDebug
```

El APK se generará en: `android/build/outputs/apk/debug/app-debug.apk`

### 5. Compilar APK Release

```bash
cd android
./gradlew assembleRelease
```

## Generar APK Firmado (para Play Store)

### 1. Crear keystore

```bash
keytool -genkey -v -keystore release.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias onyxoverlay
```

### 2. Configurar signing en build.gradle.kts

Añade esto antes de `buildTypes`:

```kotlin
signingConfigs {
    create("release") {
        storeFile = file("../release.keystore")
        storePassword = "tu_contraseña"
        keyAlias = "onyxoverlay"
        keyPassword = "tu_contraseña"
    }
}
```

### 3. Compilar APK firmado

```bash
cd android
./gradlew assembleRelease -Pandroid.injected.signing.store.file=../release.keystore \
  -Pandroid.injected.signing.store.password=tu_contraseña \
  -Pandroid.injected.signing.key.alias=onyxoverlay \
  -Pandroid.injected.signing.key.password=tu_contraseña
```

## GitHub Actions para APK

Crea el archivo `.github/workflows/build-android.yml`:

```yaml
name: Build Android APK

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3

    - name: Set up JDK 11
      uses: actions/setup-java@v3
      with:
        java-version: '11'
        distribution: 'temurin'

    - name: Make gradlew executable
      run: chmod +x android/gradlew

    - name: Build APK
      run: |
        cd android
        ./gradlew assembleDebug

    - name: Upload APK
      uses: actions/upload-artifact@v3
      with:
        name: app-debug.apk
        path: android/build/outputs/apk/debug/app-debug.apk
```

## Estructura de Permisos

El `AndroidManifest.xml` incluye:
- `INTERNET`: Para acceso a URLs externas
- `ACCESS_FINE_LOCATION`: Para geolocalización
- `CAMERA`: Si necesitas acceso a cámara

Puedes añadir más según tus necesidades.

## Solución de Problemas

### "Could not find com.android.application"
```bash
cd android
./gradlew clean
```

### WebView no carga el contenido
Verifica que la carpeta `src/main/assets/www/` contiene `index.html`

### CORS errors
Verificado: `MainActivity.kt` permite acceso CORS desde archivos locales

### Permisos en runtime
Para Android 6.0+ (nivel 23+), necesitas solicitar permisos en tiempo de ejecución:

```kotlin
if (ContextCompat.checkSelfPermission(this, Manifest.permission.INTERNET)
    != PackageManager.PERMISSION_GRANTED) {
    ActivityCompat.requestPermissions(
        this,
        arrayOf(Manifest.permission.INTERNET),
        1
    )
}
```

## Instalación en dispositivo

```bash
# Conectar dispositivo USB y activar depuración USB

cd android
./gradlew installDebug

# O directamente:
adb install build/outputs/apk/debug/app-debug.apk
```

## Próximos Pasos

1. Copiar archivos de `www/` a `src/main/assets/www/`
2. Compilar y probar en Android Studio
3. Si funciona bien, generar APK release
4. Configurar firma digital para Play Store
5. Subir a Play Store o distribuir el APK
