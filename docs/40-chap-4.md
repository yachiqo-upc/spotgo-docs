# Capítulo IV: Product Implementation & Validation

## 4. Product Implementation & Validation

### 4.1. Software Configuration Management

Para garantizar un desarrollo fluido, estandarizado y compatible entre todos los miembros del equipo Yachiqo, se ha definido el siguiente entorno de desarrollo para el ecosistema SpotGo:

#### 4.1.1. Software Development Environment Configuration

Se listan a continuación las herramientas utilizadas a lo largo de todo el ciclo de vida del proyecto, cubriendo desde la gestión de requisitos hasta el despliegue de componentes:

- **Project & Requirements Management:**
  - **Trello:** Herramienta SaaS para la gestión ágil del Product Backlog, Sprints y seguimiento de User Stories. [Referencia: trello.com](https://trello.com/)
  - **UXPressia:** Herramienta SaaS para la elaboración de mapas de empatía, Journey Maps y User Personas. [Referencia: uxpressia.com](https://uxpressia.com/)
- **Product UX/UI Design:**
  - **Figma:** Herramienta para la creación colaborativa de Wireframes, Mock-ups y Prototipos interactivos. [Referencia: figma.com](https://www.figma.com/)
- **Herramientas de Desarrollo (IDEs y Editores):**
  - **Android Studio & Visual Studio Code:** Entornos de desarrollo principal para la aplicación móvil multiplataforma y nativa utilizando Flutter y Jetpack Compose.
  - **IntelliJ IDEA:** IDE optimizado para el desarrollo del Backend con Java y Spring Boot. [Descarga: jetbrains.com/idea](https://www.jetbrains.com/idea/)
- **Stack Tecnológico y Entorno de Ejecución:**
  - **Flutter & Jetpack Compose:** Frameworks seleccionados para el desarrollo de la aplicación móvil (multiplataforma e integración nativa en Android).
  - **HTML5 / CSS3 / JavaScript (Vanilla JS):** Stack base sin frameworks para la Landing Page pública.
  - **Java Development Kit (JDK 21):** Entorno base para la ejecución y desarrollo del Backend en Spring Boot. [Descarga: oracle.com/java](https://www.oracle.com/java/)
  - **PostgreSQL (en Neon):** Motor de base de datos relacional Serverless alojado en la nube en la plataforma Neon. [Referencia: neon.tech](https://neon.tech/)
- **Herramientas de Pruebas, Documentación y Despliegue:**
  - **Postman:** Plataforma para el testeo, verificación y ejecución de pruebas de integración sobre los endpoints de la API RESTful. [Descarga: postman.com](https://www.postman.com/downloads/)
  - **Swagger (OpenAPI 3.0):** Herramienta integrada en el Backend con Spring Boot para la generación interactiva y automatizada de la documentación de la API.
  - **Render & GitHub Pages:** Infraestructuras Cloud para el alojamiento del Backend y de la Landing Page estática, respectivamente.

#### 4.1.2. Source Code Management

El código fuente del proyecto SpotGo se gestiona mediante **Git** como sistema de control de versiones distribuido y **GitHub** como plataforma de alojamientos y colaboración. La organización oficial del equipo es **Yachiqo** (`yachiqo-upc`), y los repositorios correspondientes al proyecto son:

- **Landing Page:** [https://github.com/yachiqo-upc/spotgo-landing.git](https://github.com/yachiqo-upc/spotgo-landing.git)
- **Mobile Application:** [https://github.com/yachiqo-upc/spotgo-mobile-app.git](https://github.com/yachiqo-upc/spotgo-mobile-app.git)
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

- **Landing Page (HTML5 / CSS / Vanilla JS):** Cumplimiento de las directrices de la [W3C HTML Style Guide](https://www.w3schools.com/html/html5_syntax.asp) y [Google HTML/CSS Style Guide](https://google.github.io/styleguide/htmlcssguide.html).
- **Mobile Application (Dart / Flutter & Kotlin / Jetpack Compose):**
  - Para Flutter/Dart, se sigue la [Effective Dart Guide](https://dart.dev/guides/language/effective-dart) (`lowerCamelCase` para variables y funciones, `PascalCase` para clases y widgets, `lowercase_with_underscores` para nombres de archivos).
  - Para Jetpack Compose, se aplica la [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html) y las recomendaciones oficiales de arquitectura de Android.
- **Backend (Java / Spring Boot):** Cumplimiento de la [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html). La arquitectura respeta la separación en capas (Controllers, Services, Repositories, Entities/DTOs) y las rutas RESTful utilizan sustantivos en plural y minúsculas separados por guiones (ej. `GET /api/v1/parking-zones`).
- **Criterios de Aceptación:** Uso de las [Gherkin Conventions](https://specflow.org/gherkin/gherkin-conventions-for-readable-specifications/) en inglés mediante la estructura `Given - When - Then`.

#### 4.1.4. Software Deployment Configuration

El despliegue de las distintas soluciones del ecosistema SpotGo se realiza mediante plataformas en la nube optimizadas para cada componente:

- **Landing Page (Sitio Estático Vanilla JS):** Se aloja y despliega de manera continua mediante **GitHub Pages** desde la rama `main` del repositorio `spotgo-landing`, permitiendo acceso público inmediato.
- **Backend (RESTful Web Services - Spring Boot):** Se despliega en la plataforma PaaS **Render**, vinculando directamente el repositorio `spotgo-backend`. Cada integración confirmada en `main` desencadena la construcción y ejecución automatizada de la aplicación.
- **Base de Datos Relacional:** Se utiliza una instancia de **PostgreSQL** alojada en la plataforma Serverless Cloud **Neon**, conectada mediante variables de entorno seguras hacia el servicio desplegado en Render.
- **Mobile Application:** Se compila y distribuye mediante artefactos ejecutables (`.apk` / `.aab`) directamente desde el repositorio `spotgo-mobile-app` para su instalación y prueba en dispositivos Android y emuladores.