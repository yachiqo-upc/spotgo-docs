# Capítulo III: Solution UI/UX Design
## 3.1. Product design
### 3.1.1. Style Guidelines
Las Style Guidelines de SpotGo establecen los criterios visuales y de interacción que deberán utilizarse durante el desarrollo de la Landing Page y de la aplicación móvil.

El objetivo es contar con un lenguaje visual centralizado que permita que todos los componentes mantengan una apariencia consistente, independientemente de la pantalla o funcionalidad en la que sean utilizados.
#### 3.1.1.1. General Style Guidelines

**Branding**

La identidad visual de SpotGo busca transmitir una imagen de tecnología, orden, confianza y eficiencia. Debido a que el producto está relacionado con la gestión y búsqueda de estacionamientos, la interfaz debe permitir identificar rápidamente información como disponibilidad, ocupación, ubicación y estado de las Reservations.

El lenguaje visual evita una apariencia excesivamente decorativa y prioriza componentes funcionales, información resumida y jerarquía visual.

El nombre SpotGo representa la idea de encontrar y utilizar un espacio de estacionamiento de manera rápida, por lo que la identidad se asocia con conceptos como; disponibilidad, movimiento, ubicación, rapidez, organización, tecnología.

![spotgo-logo](./assets/images/others/spotgo-logo.png)

**Typography**

Se utilizara Plus Jakarta Sans como familia tipográfica principal. La tipografía se empleará de manera consistente en títulos, textos, botones, etiquetas, estados y metadatos.

Se propone la siguiente jerarquía:

![spotgo-tipography](./assets/images/others/spotgo-tipography.png)

**Colors**

La paleta implementa un Dark Design System diseñado para reducir la fatiga visual del conductor en entornos de baja luminosidad, priorizando el contraste para identificar rápidamente el estado del estacionamiento:

* **#0F0D17 (Base):** Fondo oscuro profundo que evita deslumbramientos y permite que los colores semánticos resalten.   
* **#FFD84D (Action):** Color ámbar utilizado para los botones de acción principales.   
* **#263044 (Blocks):** Azul grisáceo apagado que manda los espacios ocupados a un segundo plano visual, reduciendo distracciones.   
* **#44E38B (Available):** Verde de alto contraste para que el conductor ubique los espacios libres de inmediato.   
* **#FF5D68 (Error/Unavailable):** Rojo destinado a comunicar errores del sistema o espacios físicos inhabilitados.   
* **#F7F5FA (Text):** Blanco que garantiza la máxima legibilidad de los datos en la pantalla móvil sobre los fondos oscuros.   

![spotgo-palette](./assets/images/others/spotgo-palette.png)

### 3.1.2. Information Architecture

Esta sección define la organización del contenido del Landing Page y la aplicación de SpotGo mediante sistemas de organización, etiquetado, búsqueda y navegación que reducen la carga cognitiva. La arquitectura prioriza las necesidades de dos perfiles principales: Drivers, enfocados en buscar, consultar disponibilidad y reservar espacios; y Parking Admins, centrados en administrar y monitorear los estacionamientos.

### 3.1.2.1. Organization Systems

En esta sección se definen los sistemas de organización que se plantearán para SpotGo, considerando tanto el Landing Page como las aplicaciones destinadas a Drivers y Parking Admins. El objetivo será estructurar la información de manera clara y facilitar el acceso a las funcionalidades principales.

**Organización visual del contenido:**

- **De forma jerárquica (Visual Hierarchy):** Se utilizará principalmente en las interfaces de la aplicación, priorizando la información más relevante para cada usuario. En el caso del Driver, se dará mayor importancia a la disponibilidad, ubicación y precio de los estacionamientos. Para los Parking Admins, se priorizarán indicadores como ocupación, disponibilidad, reservas y estado de las zonas.

- **Organización secuencial (Step-by-step):** Se aplicará en procesos que requieran completar diferentes etapas, principalmente en el flujo de reserva de un estacionamiento. El usuario podrá seleccionar una zona, revisar la disponibilidad, seleccionar un espacio, confirmar la reserva y realizar el pago.

- **Organización matricial:** Se utilizará principalmente en las vistas de monitoreo y análisis para Parking Admins. La información podrá visualizarse considerando diferentes variables como zonas, espacios, estados de ocupación y periodos de tiempo.

**Esquemas de categorización:**

- **Según audiencia (Audience-based):** Se aplicará principalmente en el Landing Page, diferenciando el contenido dirigido a **Drivers** y **Parking Admins**.

- **Por tópicos:** Se utilizará para agrupar funcionalidades como Reservations, Payments, Vehicles, Parking Zones, Monitoring, Reports y Settings.

- **Cronológico:** Se utilizará para organizar información relacionada con Reservations, Payments, Parking History y Reports, permitiendo consultar los registros de acuerdo con fechas o periodos.

- **Por estado:** Se utilizará para clasificar los Parking Spots según estados como **Available, Occupied, Reserved y Unavailable**, facilitando la identificación de la situación actual de cada espacio.

### 3.1.2.2. Labelling Systems

En esta sección se definen las etiquetas que se plantearán para representar la información y funcionalidades de SpotGo. Estas etiquetas buscarán ser cortas, directas y consistentes, permitiendo que los usuarios comprendan rápidamente el propósito de cada sección o acción.

Para el segmento de **Drivers**, se utilizarán etiquetas relacionadas con las principales acciones del usuario:

- **Explore:** búsqueda y exploración de estacionamientos.
- **Reservations:** consulta y gestión de reservas.
- **Payments:** gestión de pagos.
- **Profile:** información y configuración del usuario.
- **Vehicles:** administración de vehículos registrados.

Para el segmento de **Parking Admins**, se utilizarán etiquetas orientadas a la gestión del estacionamiento:

- **Dashboard:** vista general de la operación.
- **Monitoring:** monitoreo de los estacionamientos.
- **Parking Zones:** administración de zonas.
- **Parking Spots:** administración de espacios.
- **Reservations:** gestión de reservas.
- **Reports:** consulta de información y métricas.
- **Settings:** configuración del sistema.

Asimismo, se utilizarán etiquetas consistentes para representar los estados de los espacios:

- **Available**
- **Occupied**
- **Reserved**
- **Unavailable**

Las etiquetas de las acciones utilizarán términos directos como **Reserve**, **View Details**, **Get Directions**, **Confirm** y **Cancel**, evitando textos extensos que puedan dificultar la comprensión de las acciones.

### 3.1.2.3. SEO Tags and Meta Tags

En esta sección se definen los SEO Tags y Meta Tags que se plantearán para el Landing Page de SpotGo. Estos elementos estarán orientados a comunicar claramente la propuesta de valor del producto y facilitar su posicionamiento en motores de búsqueda.

**Landing Page**

- **Title:** `SpotGo | Smart Parking`
- **Description:** `Find and reserve available parking with SpotGo, while Parking Admins manage spaces, monitor occupancy and optimize parking operations.`
- **Keywords:** `smart parking, parking reservation, parking availability, parking management, parking admins, parking spaces`
- **Author:** `SpotGo Team`

**For Drivers**

- **Title:** `SpotGo for Drivers | Find and Reserve Parking`
- **Description:** `Find available parking spaces, check availability and reserve your spot with SpotGo.`
- **Keywords:** `find parking, parking reservation, available parking, smart parking`
- **Author:** `SpotGo Team`

**For Parking Admins**

- **Title:** `SpotGo for Parking Admins | Smart Parking Management`
- **Description:** `Manage parking spaces, monitor occupancy and optimize parking operations with SpotGo.`
- **Keywords:** `parking management, parking admin, occupancy monitoring, parking operations`
- **Author:** `SpotGo Team`

La estructura de la Landing Page se organizará alrededor de contenidos dirigidos a **Drivers** y **Parking Admins**, además de las secciones **How it works, Pricing y FAQ**.

### 3.1.2.4. Searching Systems

En esta sección se definen los mecanismos de búsqueda que se plantearán en SpotGo para facilitar que los usuarios encuentren rápidamente la información que necesitan.

Para el segmento de **Drivers**, el sistema de búsqueda estará principalmente orientado a encontrar estacionamientos disponibles. Se planteará una búsqueda mediante mapa que permita visualizar las **Parking Zones** cercanas y consultar información relacionada con su disponibilidad.

La búsqueda podrá complementarse con filtros que permitan reducir los resultados según las necesidades del usuario:

- **Distance:** para encontrar estacionamientos cercanos.
- **Price:** para establecer un rango de precio.
- **Availability:** para mostrar espacios disponibles.
- **Services:** para buscar estacionamientos según los servicios ofrecidos.
- **Operating Hours:** para considerar el horario de funcionamiento.

Los resultados de búsqueda se plantearán mediante tarjetas y elementos visuales dentro del mapa, mostrando información relevante como nombre del estacionamiento, distancia, precio, disponibilidad y ubicación.

Para los **Parking Admins**, el sistema de búsqueda estará orientado a localizar información dentro del entorno administrativo. Se plantearán filtros por **Dashboard, Live Map, Alerts, More**, permitiendo consultar rápidamente información operacional.

### 3.1.2.5. Navigation Systems

En esta sección se definen los sistemas de navegación que se plantearán para guiar a los usuarios a través del Landing Page y las aplicaciones de SpotGo, permitiéndoles acceder a las funcionalidades necesarias de acuerdo con sus objetivos.

**Navegación del Landing Page:**

- **Global Navigation:** Se planteará una barra de navegación superior con accesos a las principales secciones: **For Drivers, For Parking Admins, How it works, Pricing y FAQ**.
- **Section Navigation:** Los elementos de navegación permitirán desplazarse hacia las diferentes secciones del Landing Page sin necesidad de abandonar la página.
- **Call To Action:** Se utilizarán botones como **Open App** para dirigir al usuario hacia la experiencia principal del producto.
- **Mobile Navigation:** En dispositivos móviles se planteará un menú desplegable que permitirá acceder a las diferentes secciones manteniendo una interfaz limpia y aprovechando el espacio reducido de la pantalla.

**Navegación de la aplicación para Drivers:**

- **Bottom Navigation:** Se planteará una barra de navegación inferior con acceso a las principales funcionalidades: **Explore, Reservations, Payments y Profile**.
- **Contextual Navigation:** Dentro de cada sección se incluirán acciones relacionadas con el contexto del usuario, como **Reserve, View Details, Get Directions y Cancel**.
- **Reservation Flow:** El proceso de reserva utilizará navegación secuencial para guiar al Driver desde la selección del estacionamiento hasta la confirmación de la reserva y el pago.

**Navegación de la aplicación para Parking Admins:**

- **Sidebar Navigation:** Se planteará un menú lateral para acceder a las principales funciones administrativas, como **Dashboard, Live Map, Alerts, More**.
- **Dashboard Navigation:** El Dashboard funcionará como punto de entrada para visualizar información general y acceder rápidamente a las principales funciones de administración.
- **Contextual Navigation:** Las acciones de administración estarán disponibles directamente desde las vistas correspondientes, permitiendo consultar una zona, revisar sus espacios o analizar información relacionada con la ocupación.

Finalmente, la navegación mantendrá una estructura consistente entre las diferentes interfaces, utilizando etiquetas claras, jerarquía visual y patrones de interacción similares para facilitar el aprendizaje del sistema.
