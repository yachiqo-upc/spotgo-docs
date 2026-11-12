# Capítulo IV: Product Implementation & Validation

## 4. Product Implementation & Validation

### 4.1. Software Configuration Management

Para garantizar un desarrollo fluido, estandarizado y compatible entre todos los miembros del equipo Yachiqo, se ha definido el siguiente entorno de desarrollo para el ecosistema SpotGo:

#### 4.1.1. Software Development Environment Configuration

Se listan a continuación las herramientas utilizadas y previstas a lo largo del ciclo de vida del proyecto, desde la gestión de requisitos hasta el despliegue de componentes:

- **Project & Requirements Management:**
  - **Trello:** Herramienta SaaS para la gestión ágil del Product Backlog, Sprints y seguimiento de User Stories. [Referencia: trello.com](https://trello.com/)
  - **UXPressia:** Herramienta SaaS para la elaboración de mapas de empatía, Journey Maps y User Personas. [Referencia: uxpressia.com](https://uxpressia.com/)
- **Modelado y diagramación:**
  - **Lucidchart:** Utilizado para elaborar el diagrama de base de datos. [Referencia: Lucidchart](https://www.lucidchart.com/)
  - **Overflow:** Utilizado para elaborar los User Flows y Wireflows. [Referencia: Overflow](https://www.overflow.co/)
  - **PlantUML y Structurizr DSL:** Utilizados para los diagramas UML y las vistas C4 de la arquitectura, respectivamente.
- **Product UX/UI Design:**
  - **Figma:** Herramienta para la creación colaborativa de Wireframes, Mock-ups y Prototipos interactivos. [Referencia: figma.com](https://www.figma.com/)
- **Herramientas de Desarrollo (IDEs y Editores):**
  - **Android Studio:** IDE para desarrollar, compilar y ejecutar la parte Kotlin con Jetpack Compose y ensamblar la aplicación Android. [Descarga: Android Studio](https://developer.android.com/studio)
  - **Visual Studio Code:** Editor para la Landing Page y el desarrollo de las aplicaciones Flutter y Angular. [Descarga: Visual Studio Code](https://code.visualstudio.com/download)
  - **IntelliJ IDEA:** IDE optimizado para el desarrollo del Backend con Java y Spring Boot. [Descarga: jetbrains.com/idea](https://www.jetbrains.com/idea/)
- **Stack Tecnológico y Entorno de Ejecución:**
  - **Kotlin & Jetpack Compose:** Lenguaje y toolkit para la aplicación Android nativa de Driver, que permite iniciar sesión y registrarse. [Referencia: Kotlin](https://kotlinlang.org/docs/home.html) y [Jetpack Compose](https://developer.android.com/develop/ui/compose/documentation)
  - **Flutter & Dart:** Framework multiplataforma y lenguaje para la aplicación independiente de Parking Admin, que utiliza cuentas provisionadas y permite iniciar sesión sin registro público. [Instalación: Flutter](https://docs.flutter.dev/install) y [Referencia: Dart](https://dart.dev/guides)
  - **Angular, TypeScript y Angular Material:** Tecnologías de la página web administrativa de SpotGo, destinada únicamente a SuperAdmin. [Angular](https://angular.dev/), [TypeScript](https://www.typescriptlang.org/docs/) y [Angular Material](https://material.angular.dev/)
  - **Android SDK y Gradle Wrapper:** Herramientas de compilación e instalación. El proyecto Android configura SDK 37, Android 10/API 29 como mínimo y JDK 25 para el daemon de Gradle, según `app/build.gradle.kts` y `gradle/gradle-daemon-jvm.properties`; este JDK es independiente del utilizado por el backend. [Referencia: SDK Manager](https://developer.android.com/studio/intro/update#sdk-manager) y [Gradle Wrapper](https://docs.gradle.org/current/userguide/gradle_wrapper.html)
  - **HTML5 / CSS3 / JavaScript (Vanilla JS):** Stack base sin frameworks para la Landing Page pública. [Referencia: MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web)
  - **Java Development Kit (JDK 25 LTS):** Entorno de compilación y ejecución del Backend en Spring Boot, alineado con `java.version` en `pom.xml`. [Documentación de Java SE 25](https://docs.oracle.com/en/java/javase/25/)
  - **Maven Wrapper:** Ejecuta las tareas de compilación y empaquetado del backend mediante `mvnw` o `mvnw.cmd`, sin exigir una instalación global de Maven. [Referencia: Maven Wrapper](https://maven.apache.org/wrapper/)
  - **PostgreSQL (en Neon):** Motor de base de datos relacional Serverless alojado en la nube en la plataforma Neon. [Referencia: neon.tech](https://neon.tech/)
- **Herramientas de Pruebas, Documentación y Despliegue:**
  - **Postman:** Plataforma para verificar y ejecutar pruebas de integración sobre los endpoints de la API RESTful. [Descarga: postman.com](https://www.postman.com/downloads/)
  - **Swagger / OpenAPI:** Documentación interactiva de la API generada desde Spring Boot mediante Springdoc. [Referencia: Springdoc](https://springdoc.org/)
  - **Render:** Plataforma para desplegar el Backend como Web Service y la aplicación web administrativa como Static Site. [Web Services](https://render.com/docs/web-services), [Static Sites](https://render.com/docs/static-sites) y [Docker](https://render.com/docs/docker).
  - **GitHub Pages:** Hosting de la Landing Page estática. [Referencia: GitHub Pages](https://docs.github.com/en/pages)
  - **Git & GitHub:** Control de versiones, colaboración y repositorios de código fuente. [Descarga: Git](https://git-scm.com/downloads) y [Referencia: GitHub](https://docs.github.com/)
  - **Firebase App Distribution:** Plataforma utilizada para distribuir las versiones de prueba de las dos aplicaciones móviles a sus usuarios testers. [Referencia: Firebase App Distribution](https://firebase.google.com/docs/app-distribution/)

#### 4.1.2. Source Code Management

El código fuente del proyecto SpotGo se gestiona mediante **Git** como sistema de control de versiones distribuido y **GitHub** como plataforma de alojamiento y colaboración. La organización oficial del equipo es **Yachiqo** (`yachiqo-upc`), y los repositorios correspondientes al proyecto son:

- **Landing Page:** [https://github.com/yachiqo-upc/spotgo-landing.git](https://github.com/yachiqo-upc/spotgo-landing.git)
- **SpotGo Driver Android App (Kotlin / Jetpack Compose):** [https://github.com/yachiqo-upc/spotgo-android-app.git](https://github.com/yachiqo-upc/spotgo-android-app.git). El repositorio incluye las pantallas iniciales de los dos perfiles elaboradas durante el Sprint 1; la aplicación final de Parking Admin se desarrolla por separado en Flutter.
- **SpotGo Parking Admin Flutter App:** [https://github.com/yachiqo-upc/spotgo-flutter-app.git](https://github.com/yachiqo-upc/spotgo-flutter-app.git).
- **Página web administrativa de SpotGo (Angular / TypeScript):** [https://github.com/yachiqo-upc/spotgo-admin-web-app.git](https://github.com/yachiqo-upc/spotgo-admin-web-app.git).
- **RESTful Web Services (Backend):** [https://github.com/yachiqo-upc/spotgo-backend.git](https://github.com/yachiqo-upc/spotgo-backend.git)

**Estrategia de Ramas (GitFlow)**
Se establece un flujo de trabajo estructurado basado en GitFlow para asegurar la estabilidad del software:
- `main`: Rama de producción. Almacena versiones estables, probadas y desplegadas.
- `develop`: Rama de integración continua donde se consolidan las funcionalidades antes de ser promovidas a producción.
- `feature/US[ID]-[nombre]`: Ramas cortas creadas desde `develop` para el trabajo de User Stories específicas (ej. `feature/US01-consult-availability`).
- `release/v[X.Y.Z]`: Ramas de preparación previas a un lanzamiento para realizar pruebas finales.
- `hotfix/[nombre]`: Ramas para corregir errores urgentes detectados en la rama `main`.

**Convenciones de Versionado y Commits**
- **Semantic Versioning (SemVer 2.0.0):** Etiquetado de versiones en `main` bajo el formato `vMAJOR.MINOR.PATCH` (ej. v1.0.0).
- **Conventional Commits 1.0.0:** Todos los commits deben emplear un formato claro (`tipo(alcance): descripción breve`), utilizando tipos como `feat`, `fix`, `docs`, `style`, `refactor` o `test` (ej. `feat(parking): add spot status endpoint`, `docs: add Parking Admin to chapter 2`).

#### 4.1.3. Source Code Style Guide & Conventions

Se establece el uso estricto del idioma **inglés (en_US)** para la denominación de archivos, clases, métodos, variables, tablas y comentarios dentro del código fuente. Se adoptan las siguientes guías de estilo:

- **Landing Page (HTML5 / CSS / Vanilla JS):** Se siguen la [W3Schools HTML Style Guide](https://www.w3schools.com/html/html5_syntax.asp) y la [Google HTML/CSS Style Guide](https://google.github.io/styleguide/htmlcssguide.html). Para JavaScript se adopta la [Google JavaScript Style Guide](https://google.github.io/styleguide/jsguide.html): `lowerCamelCase` para variables y funciones, `UpperCamelCase` para clases, `const` para referencias que no se reasignan y `let` cuando la reasignación es necesaria. Los archivos utilizan nombres descriptivos en minúsculas, los bloques mantienen una indentación consistente y se emplean módulos y funciones con responsabilidades definidas.
- **SpotGo Driver Android App (Kotlin / Jetpack Compose):** Se aplica la [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html) y las recomendaciones oficiales de arquitectura de Android.
- **SpotGo Parking Admin Flutter App (Flutter / Dart):** Se sigue la [Effective Dart Guide](https://dart.dev/guides/language/effective-dart) (`lowerCamelCase` para variables y funciones, `PascalCase` para clases y widgets, `lowercase_with_underscores` para nombres de archivos).
- **SpotGo Administration Web App (Angular / TypeScript):** Se aplican las guías oficiales de estilo de Angular y TypeScript y las convenciones de Angular Material.
- **Backend (Java / Spring Boot):** Cumplimiento de la [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html). La arquitectura respeta la separación en capas (Controllers, Services, Repositories, Entities/DTOs) y las rutas RESTful utilizan sustantivos en plural y minúsculas separados por guiones (ej. `GET /api/v1/parking-zones`).
- **Criterios de Aceptación:** Uso de las [Gherkin Conventions](https://specflow.org/gherkin/gherkin-conventions-for-readable-specifications/) en inglés mediante la estructura `Given - When - Then`.

#### 4.1.4. Software Deployment Configuration

La Landing Page se publica en **GitHub Pages**. El Backend, implementado como monolito modular en una única aplicación Spring Boot, se despliega en **Render** como Web Service y se conecta con una única instancia PostgreSQL en **Neon**. La página web administrativa de SpotGo para SuperAdmin se despliega en Render como Static Site y se desarrolla con Angular, TypeScript y Angular Material. Las aplicaciones móviles de Driver y Parking Admin son clientes independientes y sus versiones de prueba se distribuyen mediante **Firebase App Distribution**.

**Landing Page: GitHub Pages**

1. Clonar `spotgo-landing` y comprobar que `index.html`, `styles.css`, `main.js`, `assets/` e `i18n/` estén disponibles en la raíz del proyecto. Al ser un sitio estático con Vanilla JS, no requiere compilar un framework ni instalar dependencias con npm.
2. Revisar localmente desde un servidor HTTP, por ejemplo `python -m http.server 5500`, y abrir `http://localhost:5500`. El servidor permite cargar las traducciones mediante `fetch`; abrir directamente el archivo HTML no reproduce ese comportamiento.
3. Integrar la versión validada en `main`. En **Settings → Pages**, seleccionar **Deploy from a branch**, la rama **main** y la carpeta **/(root)**, y guardar la configuración. Este procedimiento sigue la [configuración de publicación de GitHub Pages](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site).
4. Comprobar la ejecución de la publicación y abrir [SpotGo Landing Page](https://yachiqo-upc.github.io/spotgo-landing/). Verificar navegación, diseño adaptable, carga de imágenes y traducciones; los recursos deben conservar rutas relativas compatibles con `/spotgo-landing/`.

**Backend: Render Web Service y PostgreSQL**

1. Verificar el código de `spotgo-backend` en la rama `develop`. Para validarlo localmente, ejecutar `./mvnw.cmd --batch-mode test` y construir la imagen con `docker build -t spotgo-backend .`. El Dockerfile compila con Java 25 y Spring Boot 4.1.2 y ejecuta el JAR con Java 25 JRE.
2. Crear o seleccionar la instancia PostgreSQL de Neon que utilizará el Backend y obtener su host, nombre de base, usuario y contraseña. Preparar una URL JDBC con el formato `jdbc:postgresql://<host>/<database>?sslmode=require`; los valores reales se configuran como variables del servicio.
3. En Render, crear o seleccionar el Web Service conectado al repositorio `yachiqo-upc/spotgo-backend` y a la rama `develop`. Render no ofrece un runtime nativo para Java; el servicio debe ejecutarse con una imagen Docker de Java 25 LTS, construida desde un Dockerfile o publicada previamente en un registro. Consultar la [guía oficial de Docker en Render](https://render.com/docs/docker).
4. Configurar en **Environment** las variables necesarias para una base vacía. Render administra las variables y secretos desde el panel del servicio, y los aplica al próximo despliegue ([documentación](https://render.com/docs/configure-environment-variables)):

| Variable | Configuración o propósito |
| --- | --- |
| `SPRING_PROFILES_ACTIVE` | `production`, para activar `application-production.properties`. |
| `SPRING_DATASOURCE_URL` | URL JDBC de la base PostgreSQL de Neon con SSL. |
| `SPRING_DATASOURCE_USERNAME` | Usuario autorizado de la base. |
| `SPRING_DATASOURCE_PASSWORD` | Contraseña del usuario, configurada como secreto. |
| `JWT_SECRET` | Secreto de firma de los tokens de SpotGo, configurado como secreto. |
| `DEMO_ACCOUNT_PASSWORD` | Contraseña secreta compartida por las cuentas demo cargadas desde `db.json`; debe mantenerse configurada mientras el seeder esté habilitado. |
| `SUPERADMIN_BOOTSTRAP_EMAIL` | Correo inicial de `SUPER_ADMIN`; obligatorio mientras la base no tenga ninguno. |
| `SUPERADMIN_BOOTSTRAP_PASSWORD` | Contraseña inicial de `SUPER_ADMIN`, configurada como secreto y solo necesaria para crear la primera cuenta. Debe tener al menos 8 caracteres con mayúscula, minúscula, número y símbolo. |

Variables opcionales:

| Variable | Configuración o propósito |
| --- | --- |
| `CORS_ALLOWED_ORIGIN` | Origen adicional del cliente web, con protocolo y host. |
| `APP_PASSWORD_RESET_FROM_EMAIL` | Remitente verificado para recuperación de contraseña, invitaciones de Parking Admin y comprobantes informativos de reserva. |
| `RESEND_API_KEY` | Clave de Resend para recuperación de contraseña, invitaciones de Parking Admin y comprobantes informativos de reserva. |
| `RESEND_API_URL` | Endpoint de Resend; por defecto `https://api.resend.com/emails`. |
| `RECEIPT_EMAIL_ENABLED` | Habilita el envío del PDF informativo de una reserva por correo. Es `false` por defecto; mantenerlo desactivado localmente y establecerlo en `true` solo en el despliegue. |
| `GOOGLE_CLIENT_ID` | ID del cliente OAuth Web que la app Driver usa como audiencia de su token de Google. |
| `EVIDENCE_STORAGE_DIRECTORY` | Directorio de imágenes de evidencia. `/tmp/spotgo-evidence` es temporal y no desactiva las cargas; los archivos se pierden al reemplazar o reiniciar la instancia. |
| `MONITORING_MINIMUM_QUALITY` | Calidad mínima del sensor, de 0 a 100; valor predeterminado 80. |
| `MONITORING_FRESHNESS_SECONDS` | Antigüedad máxima de lectura en segundos; valor predeterminado 300. |
| `FCM_ENABLED` | `true` para activar notificaciones push con Firebase Cloud Messaging; por defecto es `false`. |
| `FCM_PROJECT_ID` | ID del proyecto Firebase; obligatorio cuando FCM está habilitado. |
| `FCM_SERVICE_ACCOUNT_JSON` | JSON de la cuenta de servicio Firebase Admin; configurarlo como secreto en Render cuando FCM esté habilitado. |

Para activar FCM en Driver, registrar la aplicación Android en el proyecto Firebase y habilitar `FCM_ENABLED` en el backend y en la compilación Android. El backend requiere `FCM_PROJECT_ID` y `FCM_SERVICE_ACCOUNT_JSON`; Android requiere además `FCM_PROJECT_ID`, `FCM_APPLICATION_ID`, `FCM_API_KEY` y `FCM_SENDER_ID`. La app autenticada registra su Firebase Installation ID (FID) con `POST /api/v1/notifications/devices` enviando `installationId` y lo elimina con `DELETE /api/v1/notifications/devices/{deviceTokenId}` antes de cerrar sesión. Para verificar la entrega, provocar un cambio de estado de reserva o de pago simulado y comprobar que la app reciba la notificación. El backend procesa los eventos en memoria después de confirmar la transacción; FCM permanece deshabilitado por defecto hasta configurar ambos lados.

Las variables de integración del cliente Android se leen durante la compilación desde variables de entorno o `local.properties`; no se guardan valores privados en el repositorio.

| Variable de compilación Android | Propósito |
| --- | --- |
| `SPOTGO_API_BASE_URL` | URL base del Backend que consumirá la aplicación. |
| `SPOTGO_GOOGLE_WEB_CLIENT_ID` | OAuth Web Client ID utilizado en el inicio de sesión con Google; debe coincidir con la audiencia validada por `GOOGLE_CLIENT_ID` en el Backend. |
| `FCM_ENABLED`, `FCM_PROJECT_ID`, `FCM_APPLICATION_ID`, `FCM_API_KEY`, `FCM_SENDER_ID` | Configuración de Firebase Installations y FCM del cliente Android. `FCM_ENABLED` se mantiene en `false` hasta habilitar el servicio también en el Backend. |
| `RECEIPT_EMAIL_ENABLED` | Muestra la acción de enviar el comprobante de reserva por correo. Mantener `false` en compilaciones locales; habilitar solo junto con la variable homónima del Backend y la configuración de Resend en despliegue. |

Configurar `SPOTGO_API_BASE_URL` con la URL base HTTPS de Render en la compilación Android y en los otros clientes. Para pruebas Android locales, utilizar `http://10.0.2.2:8080` si el backend corre con Maven o `http://10.0.2.2:18080` si Docker publica ese puerto. En un dispositivo físico, usar la IP local de la máquina y el puerto publicado. Para el cliente web, configurar su origen en `CORS_ALLOWED_ORIGIN`.

Los precios están fijos en el Backend: Tenant paga S/30 por el uso del app más S/1 por cada Parking Spot registrado; Driver paga S/15 al mes con 10% de descuento sobre el precio final de reservas o S/160 al año con 15%. El proveedor académico predeterminado simula cargos y reembolsos con referencias sintéticas, sin procesador externo ni movimiento de dinero. Render asigna `PORT` automáticamente.

5. En el perfil `production`, Hibernate usa `ddl-auto=update` y `DbSeeder` carga los datos compatibles de `src/main/resources/db.json`. Inserta las filas con sus UUID de fixture y omite las que ya existen; no modifica ni elimina filas existentes. El archivo no incluye un `SUPER_ADMIN`: el bootstrap crea esa cuenta con `SUPERADMIN_BOOTSTRAP_EMAIL` y `SUPERADMIN_BOOTSTRAP_PASSWORD` cuando la base todavía no tiene una. El correo de bootstrap debe ser distinto de los correos demo incluidos en el fixture. Las demás cuentas demo comparten `DEMO_ACCOUNT_PASSWORD`, que debe permanecer configurada para que el servicio arranque. Después del primer inicio satisfactorio se pueden retirar las dos variables de bootstrap; la contraseña demo se conserva. Una base recreada requiere nuevamente las variables de bootstrap. No utilizar `ddl-auto=update` como sustituto de migraciones versionadas si hay datos que deban conservarse.
6. Render construye y ejecuta la imagen desde el Dockerfile del repositorio. El contenedor usa un usuario no privilegiado, escucha en el `PORT` proporcionado por Render y ejecuta el perfil `production`.
7. Ejecutar el despliegue y revisar los logs de compilación, inicio y conexión PostgreSQL. Render asigna una URL HTTPS al servicio. Comprobar `/v3/api-docs`, `/swagger-ui/index.html` y una operación pública documentada. Las [verificaciones de estado de Render](https://render.com/docs/health-checks) permiten comprobar que el servicio puede recibir tráfico.

El Backend desplegado en Render se conecta a una única instancia PostgreSQL de Neon. El monolito modular conserva la separación lógica de los datos por bounded context dentro de esa instancia; los contextos no requieren instancias de Backend ni conexiones de base de datos desplegadas por separado.

**SpotGo Driver Android App: Kotlin y Jetpack Compose**

1. Clonar `spotgo-android-app` y abrir la raíz del proyecto en Android Studio. Instalar Android SDK 37 y utilizar JDK 25 para Gradle, conforme a `gradle/gradle-daemon-jvm.properties`. Seleccionar un emulador o dispositivo Android 10/API 29 o superior y sincronizar el proyecto.
2. Desde la raíz Android, generar la versión de prueba con `./gradlew.bat :app:assembleDebug`. El APK se obtiene en `app/build/outputs/apk/debug/app-debug.apk`. Para instalarlo en el dispositivo o emulador conectado, ejecutar `./gradlew.bat :app:installDebug`. En Linux/macOS se utiliza `./gradlew`.
3. Para una entrega release, configurar el almacén de claves, su alias y la firma mediante **Build → Generate Signed Bundle / APK** en Android Studio. Los secretos de firma se mantienen fuera del repositorio. Con la firma configurada, ejecutar `./gradlew.bat :app:assembleRelease` para el APK o `./gradlew.bat :app:bundleRelease` para el AAB; las salidas se conservan en `app/build/outputs/apk/release/` y `app/build/outputs/bundle/release/`, respectivamente.
4. Instalar el APK y comprobar el inicio, el registro público y la navegación de Driver. El AAB se utiliza para distribución mediante un servicio que genere los APK correspondientes y no se instala directamente en el dispositivo. Estas tareas siguen la documentación de [compilación de Android](https://developer.android.com/build/building-cmdline) y [firma de aplicaciones](https://developer.android.com/studio/publish/app-signing).

La aplicación Driver permite descargar en el dispositivo un PDF informativo de la reserva pagada. La exportación de Billing Documents también genera una copia PDF local; esos documentos no se emiten ante SUNAT. El envío por correo está limitado al comprobante informativo de una reserva y se habilita únicamente en despliegue con Resend.

El prototipo del Sprint 1 reunió las pantallas de Driver y Parking Admin en Kotlin y Jetpack Compose. La configuración de entrega usa el cliente Android nativo para Driver y un cliente Flutter independiente para Parking Admin.

**SpotGo Parking Admin Flutter App: Flutter y Dart**

Para generar un APK de Parking Admin, ejecutar `flutter pub get` y `flutter build apk` desde la raíz de su repositorio. Configurar la URL base de la API y probar el inicio de sesión con una cuenta provisionada por SuperAdmin.

**SpotGo Administration Web App: Angular y Render Static Site**

La página web administrativa de SpotGo es exclusiva para SuperAdmin y se desarrolla con Angular, TypeScript y Angular Material. Se publica en Render como Static Site, separada del Backend Web Service. Para configurarla, se conecta el repositorio `spotgo-admin-web-app`, se selecciona la rama `main`, se define el comando de compilación disponible en `package.json` y se indica el directorio generado por Angular según `angular.json`. Render publica los archivos estáticos en una URL HTTPS y puede desplegar automáticamente los cambios de la rama configurada ([Static Sites](https://render.com/docs/static-sites)). Si la aplicación usa rutas del lado del cliente, se configura la reescritura necesaria hacia `index.html` ([redirects and rewrites](https://render.com/docs/redirects-rewrites)).

**Distribución móvil: Firebase App Distribution**

Las versiones de prueba de SpotGo Driver Android App y SpotGo Parking Admin Flutter App están disponibles mediante Firebase App Distribution para los usuarios testers autorizados. La plataforma permite distribuir nuevas compilaciones Android desde la consola, Firebase CLI o Gradle ([documentación](https://firebase.google.com/docs/app-distribution/)).

**Diagrama C4 de despliegue**

La vista de despliegue presenta los clientes, el Backend modular y su única instancia PostgreSQL, además de los sensores. Su explicación corresponde a la sección 2.5.3.3. Software Architecture Deployment Diagrams.

*Figura 93 (Diagrama C4 de despliegue)*  
![SpotGo C4 Deployment Diagram](../assets/diagrams/deployment-diagram.svg)

### 4.2. Landing Page & Mobile Application Implementation

Esta sección presenta, para cada sprint, la planificación y las evidencias de desarrollo, pruebas, ejecución, documentación de la API, despliegue y colaboración del equipo correspondientes a los productos digitales de SpotGo: la Landing Page, el Backend modular, la aplicación Android de Driver, la aplicación Flutter de Parking Admin y la aplicación web Angular de SuperAdmin. Cada sprint reúne los artefactos y resultados que permiten documentar el avance de la solución según su alcance.
