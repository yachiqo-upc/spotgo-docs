# Capítulo II: Requirements Development and Software Solution Design

## 2.1. Competidores

### 2.1.1. Análisis competitivo

**Competitive Analysis Landscape**

*¿Por qué llevar a cabo este análisis?*

Permite identificar cómo funcionan las soluciones actuales de estacionamiento, detectar sus fortalezas y limitaciones, y determinar oportunidades de diferenciación para SpotGo, especialmente en la organización por zonas, clasificación de usuarios y monitoreo de ocupación.

*Logos*

| SpotGo | Apparka | iPark | Parkopedia |
| --- | --- | --- | --- |
| <img src="../assets/images/others/spotgo-logo.png" alt="Spotgo Logo" width="150px"> | <img src="../assets/images/others/apparka-logo.png" alt="Apparka Logo" width="150px"> | <img src="../assets/images/others/ipark-logo.png" alt="iPark Logo" width="150px"> | <img src="../assets/images/others/parkopedia-logo.png" alt="Parkopedia Logo" width="150px"> |

*Perfil*

|     | SpotGo | Apparka | iPark | Parkopedia |
| --- | --- | --- | --- | --- |
| Overview | Sistema de gestión de estacionamientos que monitorea la ocupación por zonas, clasifica usuarios y genera alertas para apoyar la supervisión operativa. | Empresa peruana de gestión de estacionamientos con app para ubicación, disponibilidad, pagos, reservas y servicios empresariales. | Solución peruana en la nube para gestión digital de estacionamientos, pagos, registro vehicular y control operativo. | Plataforma global de datos de estacionamiento con información estática, disponibilidad dinámica, reservas, pagos e integraciones. |
| Ventaja competitiva | Organización por zonas según tipo de usuario, monitoreo actualizado y apoyo al control operativo desde una misma solución. | Amplia presencia en Perú, operación directa de estacionamientos y servicios digitales integrados. | Integra gestión administrativa, pagos digitales, control vehicular y aforo en tiempo real. | Cobertura global, gran volumen de datos y fuerte integración con vehículos y servicios de movilidad. |

*Perfil de marketing*

|     | SpotGo | Apparka | iPark | Parkopedia |
| --- | --- | --- | --- | --- |
| Mercado Objetivo | Operadores de estacionamientos de alta demanda y conductores que utilizan estos espacios. | Conductores urbanos que buscan optimizar tiempo en estacionar. | Operadores y empresas que administran estacionamientos. | Conductores, fabricantes de vehículos, operadores y servicios de movilidad. |
| Estrategias de Marketing | Pruebas piloto con operadores de estacionamientos y alianzas con centros comerciales, universidades y empresas. | Presencia física nacional, app móvil, servicios empresariales y alianzas con distintos tipos de establecimientos. | Venta B2B orientada a digitalización y mejora operativa. | Alianzas con fabricantes, integración mediante APIs y presencia internacional. |

*Perfil de producto*

|     | SpotGo | Apparka | iPark | Parkopedia |
| --- | --- | --- | --- | --- |
| Productos y Servicios | Monitoreo de ocupación por zonas, clasificación de usuarios, visualización de disponibilidad, alertas y panel administrativo. | Ubicación, disponibilidad, pagos, reservas, abonados y administración de estacionamientos. | Registro vehicular, pagos, facturación, aforo y portal administrativo. | Datos de parking, disponibilidad, reservas, pagos y APIs. |
| Precios y costos | Modelo preliminar basado en suscripción para operadores de estacionamientos; los costos de implementación dependerán de los mecanismos de monitoreo requeridos. | Tarifas variables según estacionamiento, servicio o modalidad de abonado. | Modelo de suscripción con planes según capacidad y requerimientos. | Gratuito para usuarios finales; servicios B2B y licenciamiento de datos. |
| Canales de distribución | App móvil y servicios backend integrados. | App móvil, web y red física de estacionamientos. | Plataforma web, app e integraciones con dispositivos. | Web, app, APIs y sistemas integrados en vehículos. |

*Análisis SWOT*

|     | SpotGo | Apparka | iPark | Parkopedia |
| --- | --- | --- | --- | --- |
| Fortalezas | Organización por tipo de usuario, monitoreo por zonas y alertas integradas. | Presencia nacional, operación de estacionamientos y servicios digitales. | Gestión cloud, pagos digitales y aforo en tiempo real. | Cobertura global, datos dinámicos e integración vehicular. |
| Debilidades | Producto nuevo y aún en proceso de validación. | Menor enfoque en clasificación interna de usuarios por zonas. | Puede requerir mayor configuración e integración operativa. | Menor enfoque en gestión interna de zonas por usuario. |
| Oportunidades | Digitalización de estacionamientos de alta demanda. | Expansión de servicios digitales y empresariales. | Escalamiento hacia más operadores y verticales. | Mayor integración con movilidad conectada y vehículos. |
| Amenazas | Competidores consolidados con mayor infraestructura y alcance. | Nuevas soluciones digitales y plataformas globales. | Soluciones más simples o especializadas. | Competidores locales con enfoque operativo específico. |

### 2.1.2. Estrategias y tácticas frente a competidores

1. Organización por zonas según tipo de usuario.
   - SpotGo busca diferenciarse mediante la clasificación de conductores y la asignación de zonas específicas, facilitando una distribución más ordenada y con el objetivo de reducir posibles usos indebidos.

2. Monitoreo actualizado de ocupación.
   - La solución ofrecerá información actualizada sobre la disponibilidad por zonas, permitiendo a conductores y personal operativo tomar decisiones con mayor rapidez.

3. Gestión centralizada para administradores.
   - El panel administrativo permitirá consultar ocupación, distribución de zonas e incidencias desde un único entorno, facilitando la supervisión operativa.

4. Experiencia de búsqueda enfocada en disponibilidad.
   - Los conductores podrán consultar qué zonas presentan disponibilidad y cuáles pueden utilizar según su clasificación, con el objetivo de reducir recorridos innecesarios.

5. Modelo modular y adaptable.
   - La solución podrá implementarse progresivamente según las necesidades y características de cada estacionamiento, buscando reducir las barreras de adopción.

6. Analítica para soporte de decisiones.
   - Los reportes de ocupación permitirán identificar patrones de uso, periodos de alta demanda y comportamiento de las diferentes zonas.

## 2.2. Entrevistas

### 2.2.1. Diseño de entrevistas

**Primer Segmento Objetivo (Administradores o personal operativo de estacionamiento)**

1. ¿Cuáles son los principales retos que enfrenta en la gestión del estacionamiento?
2. ¿Cómo organizan actualmente la distribución de espacios dentro del estacionamiento?
3. ¿De qué manera registran y diferencian a los usuarios como clientes o colaboradores?
4. ¿Qué situaciones ocurren cuando un vehículo ocupa un espacio que no le corresponde?
5. ¿Cómo monitorean la ocupación de las diferentes zonas del estacionamiento?
6. ¿Qué problemas se presentan con mayor frecuencia en horas de alta demanda?
7. ¿Qué dificultades enfrentan los vigilantes para mantener el orden?
8. ¿Qué herramientas o sistemas utilizan actualmente para la gestión del estacionamiento?
9. ¿Qué limitaciones o inconvenientes encuentran en el sistema actual?
10. ¿Cómo cree que la visualización en tiempo real de la ocupación podría ayudar en la gestión?
11. ¿Qué tipo de alertas o notificaciones considera necesarias para mejorar el control?
12. ¿Cómo influye el registro de usuarios en la organización del estacionamiento?
13. ¿Qué beneficios esperaría obtener de un sistema inteligente de estacionamiento?
14. ¿De qué manera considera que se podría reducir el tiempo de búsqueda de espacios?
15. ¿Cómo evaluaría la implementación de una solución como SpotGo en su entorno?

**Segundo Segmento Objetivo (Conductores y usuarios finales)**

1. ¿Cómo suele ser su experiencia al buscar estacionamiento en lugares concurridos?
2. ¿En qué tipos de lugares encuentra más dificultades para estacionar y por qué?
3. ¿Cuánto tiempo suele invertir en encontrar un espacio disponible?
4. ¿Qué siente o piensa cuando no logra encontrar estacionamiento rápidamente?
5. ¿Qué acciones suele tomar cuando no encuentra un espacio libre?
6. ¿Cómo describiría la organización de los estacionamientos que frecuenta?
7. ¿Qué tan fácil le resulta orientarse dentro de un estacionamiento grande?
8. ¿Cómo cree que una aplicación podría ayudarle durante la búsqueda de estacionamiento?
9. ¿Qué tipo de información le gustaría recibir antes de ingresar a un estacionamiento?
10. ¿Qué información le sería útil mientras busca un espacio dentro del lugar?
11. ¿Cómo prefiere visualizar la disponibilidad de espacios: por zonas o de otra forma?
12. ¿Qué opinión tiene sobre la existencia de zonas exclusivas dentro de un estacionamiento?
13. ¿Qué problemas ha tenido relacionados con la señalización dentro del estacionamiento?
14. ¿Cómo mejoraría su experiencia al momento de estacionar?
15. ¿Qué valor le daría a un sistema que reduzca el tiempo de búsqueda de espacios?

### 2.2.2. Registro de entrevistas

**Needfinding Interviews Link:** 

**Primer Segmento Objetivo (Administradores o personal operativo de estacionamiento)**

**Entrevista 1**

| Screenshot: | ![Entrevista S1 1](../assets/images/interviews/needfinding/entrevista-1-1.png) |
| --- | --- |
| Inicia: | 00:00 |
| Duración:| 4:50 |
| Nombre completo: | Cecilia Lopez |
| Edad: | 31 años |
| Distrito: | Cercado de Lima |
| Resumen: | Cecilia nos indica que la gestión del estacionamiento se basa en organización manual y registro mediante boletas y tablas, sin asignación de zonas específicas, ya que los vehículos ocupan cualquier espacio disponible. El monitoreo se realiza con cámaras y control físico, y en horas de alta demanda surgen dificultades para movilizar vehículos debido al espacio reducido. Aunque el sistema actual funciona, depende en gran medida de la intervención manual, incluso solicitando llaves para reorganizar los autos. Considera que un sistema inteligente podría mejorar la organización, visibilidad y control, además de aportar beneficios para atraer más clientes. |

**Entrevista 2**

| Screenshot: | ![Entrevista S1 2](../assets/images/interviews/needfinding/entrevista-1-2.png) |
| --- | --- |
| Inicia: | 04:50 |
| Duración:| 5:04 |
| Nombre completo: | Reinaldo Torres |
| Edad: | 42 años |
| Distrito: | Breña |
| Resumen: | Nos comenta que la gestión de su estacionamiento combina métodos manuales y digitales, registrando a los clientes sin asignación fija de espacios, ya que ocupan cualquier lugar disponible. El monitoreo se realiza mediante un aplicativo que permite control remoto, pero en horas de alta demanda surgen problemas de congestión y necesidad de movilizar vehículo. Él nos destaca que un sistema en tiempo real mejoraría significativamente la gestión, permitiendo mayor control y reducción de pérdidas económicas. También resalta la importancia de alertas, especialmente para pagos, y considera que la implementación de una solución inteligente sería beneficiosa, aunque requeriría capacitación del personal. |

**Entrevista 3**

| Screenshot: | ![Entrevista S1 3](../assets/images/interviews/needfinding/entrevista-1-3.png) |
| --- | --- |
| Inicia: | 10:44 |
| Duración:| 6:16 |
| Nombre completo: | Juan Vega |
| Edad: | 30 años |
| Distrito: | La Victoria |
| Resumen: | La entrevista a Juan Carlos, un administrador de estacionamientos de 30 años, expone las dificultades de una gestión basada en procesos manuales, registros en papel y vigilancia visual, lo que genera desorden en horas pico y un control ineficiente de los espacios reservados. Debido a la falta de un sistema en tiempo real, el personal debe realizar rondas a pie y vocear placas para gestionar la ocupación, una carga operativa que el administrador busca eliminar. En este contexto, la propuesta de la aplicación "SpotGo" es recibida con gran optimismo, ya que el uso de sensores para identificar vehículos y un mapa en vivo permitiría automatizar la asignación de lugares, mejorar el control de pagos y proyectar una imagen mucho más profesional y organizada de la empresa. |

**Segundo Segmento Objetivo (Conductores y usuarios finales)**

**Entrevista 1**

| Screenshot: | ![Entrevista S2 1](../assets/images/interviews/needfinding/entrevista-2-1.png) |
| --- | --- |
| Inicia: | 17:01 |
| Duración:| 3:53 |
| Nombre completo: | Emiliano Lozano |
| Edad: | 51 años |
| Distrito: | San Martin de Porres |
| Resumen: | Emiliano nos señala que, como taxista, cuenta con un espacio asignado dentro del estacionamiento, lo que facilita su experiencia y evita dificultades para encontrar lugar. La organización se apoya en señalización básica como carteles, y en algunos casos utilizan conos para asegurar sus espacios. En momentos de alta demanda, otros usuarios ocupan sus espacios, obligándolos a esperar o buscar alternativas. Además, señala que los clientes tienen más dificultades para estacionar. Considera que una solución tecnológica con señales o alertas podría mejorar la organización. |

**Entrevista 2**

| Screenshot: | ![Entrevista S2 2](../assets/images/interviews/needfinding/entrevista-2-2.png) |
| --- | --- |
| Inicia: | 20:54 |
| Duración:| 7:05 |
| Nombre completo: | Angel Pariona |
| Edad: | 23 años |
| Distrito: | Lince |
| Resumen: | Angel menciona que encuentra difícil hallar estacionamiento debido a zonas no autorizadas o cocheras ocupadas, especialmente cerca de cines y parques de agua, demorando entre 10 a 15 minutos. Califica la organización actual como muy poco ordenada porque los vehículos no respetan los espacios y generan bloqueos ante la falta de fiscalización municipal. Ante la falta de espacio, da vueltas por las cuadras o se aleja un poco más, calificando la situación de frustrante por la pérdida de tiempo. Considera que una aplicación sería muy útil si le señala zonas libres, muestra la seguridad del lugar y permite reservar espacios. Sugiere medir mejor los tiempos y buscar estacionamiento en horas punta, valorando que un sistema así reduciría significativamente el tiempo de búsqueda en Lima. |

**Entrevista 3**

| Screenshot: | ![Entrevista S2 3](../assets/images/interviews/needfinding/entrevista-2-3.png) |
| --- | --- |
| Inicia: |  |
| Duración:|  |
| Nombre completo: |  |
| Edad: |  |
| Distrito: |  |
| Resumen: |  |

### 2.2.3. Análisis de entrevistas

**Primer Segmento Objetivo (Administradores o personal operativo de estacionamiento)**

Este segmento es clave porque son responsables de la organización, control y funcionamiento del estacionamiento. Las entrevistas realizadas evidencian cómo se gestionan actualmente estos espacios y las principales limitaciones que enfrentan, así como la oportunidad de mejora mediante soluciones tecnológicas.

*¿Quienes son?*
Se trata de administradores y personal operativo encargados de supervisar el estacionamiento y organizar el flujo de vehículos.
- Utilizan una combinación de métodos manuales y sistemas básicos (boletas, registros, aplicativos).
- Se encargan del control de ingresos, ocupación y organización de los vehículos.
- En muchos casos, deben intervenir directamente para reordenar los autos.

*¿Qué les preocupa y anhelan?*
- Desorden en la ocupación: No existen zonas definidas, los usuarios ocupan cualquier espacio disponible.
- Congestión en horas pico: Dificultad para movilizar vehículos en espacios reducidos.
- Dependencia de procesos manuales: Uso de boletas, registros y control físico. 
- Necesidad de control: Buscan mayor visibilidad sin tener que estar presentes todo el tiempo.
- Pérdidas operativas: Riesgo de errores en cobros o control del tiempo de permanencia.

*Requisitos del producto*
- Eficiente, permitiendo una mejor organización del estacionamiento.
- Clara y visual, mostrando la ocupación por zonas en tiempo real.
- Con alertas, para detectar uso indebido de espacios o eventos importantes.
- De fácil control remoto, para que el administrador supervise sin estar presente.
- Apoyo a la gestión, reduciendo la dependencia de procesos manuales.

**Segundo Segmento Objetivo (Conductores y usuarios finales (clientes))**

Este segmento es fundamental porque son quienes utilizan directamente el estacionamiento y experimentan los problemas al momento de buscar un espacio. Las entrevistas realizadas evidencian dificultades relacionadas con el tiempo de búsqueda, la organización del lugar y la falta de información clara, lo que impacta en su experiencia.

*¿Quienes son?*
Se trata de conductores que utilizan estacionamientos en centros comerciales, universidades u otros espacios concurridos.
- Buscan estacionar de forma rápida, segura y sencilla.
- Su experiencia varía según el nivel de congestión y organización del lugar.
- Dependen de la señalización, su conocimiento del lugar o apoyo del personal.
- En algunos casos, recurren a alternativas como estacionar en la calle.

*¿Qué les preocupa y anhelan?*
- Tiempo de búsqueda elevado: Puede tomar varios minutos encontrar un espacio, especialmente en horas pico.
- Congestión y desorden: Tráfico interno y mala organización en entradas, salidas o pisos.
- Falta de orientación: Dificultad para ubicarse dentro del estacionamiento o encontrar salidas.
- Información limitada: No conocen disponibilidad, tarifas o condiciones antes de ingresar.
- Estrés y frustración: Sensaciones negativas cuando no encuentran espacio rápidamente. 

*Requisitos del producto*
- Rápida y eficiente, reduciendo el tiempo de búsqueda de espacios.
- Visual y clara, mostrando disponibilidad por zonas o pisos.
- Informativa, incluyendo datos como espacios libres, tarifas y horarios.
- Fácil de usar, con una interfaz intuitiva que ayude a la orientación.
- Con apoyo en tiempo real, guiando al usuario dentro del estacionamiento.

## 2.3. Needfinding

### 2.3.1. User Personas

**Primer Segmento Objetivo (Administradores o personal operativo de estacionamiento)**

*Figura 2 (User Persona 1)*
![User Persona 1](../assets/images/figures/02-user-persona-1.png)

**Segundo Segmento Objetivo (Conductores y usuarios finales)**

*Figura 3 (User Persona 2)*
![User Persona 2](../assets/images/figures/03-user-persona-2.png)

### 2.3.2. User Task Matrix

**Primer Segmento Objetivo (Administradores o personal operativo de estacionamiento)**

*Figura 4 (User Task Matrix 1)*
![User Task Matrix 1](../assets/images/figures/04-u-task-matrix-1.png)

**Segundo Segmento Objetivo (Conductores y usuarios finales)**

*Figura 5 (User Task Matrix 2)*
![User Task Matrix 2](../assets/images/figures/05-u-task-matrix-2.png)

### 2.3.3. User Journey Mapping

**Primer Segmento Objetivo (Administradores o personal operativo de estacionamiento)**

*Figura 6 (User Journey Map 1)*
![User Journey Map 1](../assets/images/figures/06-u-journey-map-1.png)

**Segundo Segmento Objetivo (Conductores y usuarios finales)**

*Figura 7 (User Journey Map 2)*
![User Journey Map 2](../assets/images/figures/07-u-journey-map-2.png)

### 2.3.4. Empathy Mapping

**Primer Segmento Objetivo (Administradores o personal operativo de estacionamiento)**

*Figura 8 (Empathy Map 1)*
![User Empathy Map 1](../assets/images/figures/08-empathy-map-1.png)

**Segundo Segmento Objetivo (Conductores y usuarios finales)**

*Figura 9 (Empathy Map 2)*
![User Empathy Map 2](../assets/images/figures/09-empathy-map-2.png)

### 2.3.5. Big Picture EventStorming

Se utilizó la guía Step-by-Step Guide de Philippe Bourgau, proporcionada en la rúbrica del Final Problem Statement, para llevar a cabo el proceso de Big Picture Event Storming, siguiendo sus etapas:

- Open
- Explore
- Close

**Miro Board Link:** [https://miro.com/welcomeonboard/V2xyaEY4TCtuVTdxSEYvWlJwdFNGZkkvNmJnSDc2dUhrWkQ4MjlvOFB2dVQzd3hadHFBVXpROVE4UGFDbVI3NXY1NDFuam5BMVg3R1hKZEswQWV3TThSN09OOXpNNklYZDlJV2R6Z2hjSFNhMzdnWWd5bFhjK2t6My9sb3FHWm9nbHpza3F6REdEcmNpNEFOMmJXWXBBPT0hdjE=?share_link_id=707342021580](https://miro.com/welcomeonboard/V2xyaEY4TCtuVTdxSEYvWlJwdFNGZkkvNmJnSDc2dUhrWkQ4MjlvOFB2dVQzd3hadHFBVXpROVE4UGFDbVI3NXY1NDFuam5BMVg3R1hKZEswQWV3TThSN09OOXpNNklYZDlJV2R6Z2hjSFNhMzdnWWd5bFhjK2t6My9sb3FHWm9nbHpza3F6REdEcmNpNEFOMmJXWXBBPT0hdjE=?share_link_id=707342021580)

*Figura 10 (Big Picture EventStorming)*
![Big Picture EventStorming](../assets/images/figures/10-big-picture-event-storming.jpg)

### 2.3.6. Ubiquitous Language

- **Parking Spot (Espacio de estacionamiento):** Espacio físico individual dentro de un estacionamiento destinado a la ubicación de un vehículo.
- **Vehicle (Vehículo):** Medio de transporte asociado a un Driver y utilizado para ocupar un Parking Spot.
- **Parking Zone (Zona de estacionamiento):** Área del estacionamiento que agrupa múltiples *Parking Spots* y puede estar asociada a uno o más tipos de usuario definidos por la administración.
- **User Profile (Perfil de usuario):** Clasificación asignada a un conductor que determina las zonas del estacionamiento que puede utilizar. Puede representar categorías como *Visitor*, *Taxi Driver* o *Authorized User*.
- **Occupancy Status (Estado de ocupación):** Estado actual de un *Parking Spot* o una *Parking Zone*, utilizado para determinar su disponibilidad. Puede ser *Available* u *Occupied*.
- **Zone Assignment (Asignación de zona):** Proceso mediante el cual se determina qué *Parking Zone* corresponde a un conductor según su *User Profile*.
- **Unauthorized Parking (Estacionamiento indebido):** Situación que ocurre cuando un vehículo utiliza un *Parking Spot* perteneciente a una *Parking Zone* que no corresponde a su *User Profile*.
- **Occupancy Monitoring (Monitoreo de ocupación):** Proceso mediante el cual el sistema obtiene y mantiene actualizada la información sobre la ocupación de los espacios y zonas del estacionamiento.
- **Availability (Disponibilidad):** Información que indica la existencia de espacios libres dentro de una *Parking Zone*.
- **Unauthorized Parking Alert (Alerta por estacionamiento indebido):** Notificación generada cuando se identifica un posible uso de una zona que no corresponde al perfil del conductor.
- **Dashboard (Panel de control):** Interfaz utilizada por administradores y personal operativo para consultar la ocupación, gestionar zonas, identificar incidencias y revisar información relacionada con el estacionamiento.
- **Occupancy Report (Reporte de ocupación):** Información histórica o resumida sobre la utilización de los espacios y zonas del estacionamiento, utilizada para apoyar decisiones operativas.
- **Parking Administrator (Administrador de estacionamiento):** Usuario encargado de gestionar la configuración, supervisión y organización de las zonas y usuarios del estacionamiento.
- **Driver (Conductor):** Usuario que accede al estacionamiento y consulta información de disponibilidad y zonas permitidas según su perfil.

## 2.4. Requirements specification

La especificación de requisitos de SpotGo se construye a partir de la problemática, las entrevistas, los User Personas, el Ubiquitous Language y las hipótesis definidas en los capítulos anteriores. Su propósito es traducir las necesidades de los conductores y del personal de estacionamiento en comportamientos verificables del producto.

Para este ciclo se ajusta el alcance del avance anterior hacia una solución mobile-first. El producto principal será una aplicación móvil con experiencias diferenciadas para los siguientes actores:

- **Driver:** consulta la disponibilidad por Parking Zone e identifica las zonas que puede utilizar según su User Profile.
- **Parking Administrator:** configura Parking Zones y perfiles, supervisa el Occupancy Status, atiende incidencias y consulta Occupancy Reports desde la aplicación móvil.
- **Developer:** implementa los servicios RESTful y las capacidades técnicas que permiten sincronizar la aplicación móvil, conservar información local y documentar los contratos de integración.

La solución también contempla una Landing Page estática como producto digital de apoyo para comunicar la propuesta de valor de SpotGo. La Landing Page no reemplaza la aplicación móvil ni se considera parte del flujo operativo del estacionamiento.

El alcance funcional se concentra en la organización por zonas, la clasificación de usuarios, la visualización actualizada de disponibilidad, el monitoreo de ocupación, las alertas por uso indebido y los reportes operativos. El mecanismo concreto para obtener los datos de ocupación se mantiene abierto hasta completar la investigación técnica correspondiente. Por ello, esta especificación no fija sensores por Parking Spot, cámaras, barreras ni otra tecnología específica.

De acuerdo con las decisiones de alcance ya establecidas, no se incluyen en esta versión los pagos digitales, las reservas, las suscripciones, la facturación electrónica, el Smart Routing, la navegación automática hacia un espacio, las integraciones municipales ni un panel web administrativo independiente.

### 2.4.1. User Stories

Las siguientes User Stories especifican los requisitos funcionales, técnicos y de investigación del alcance mobile-first. Cada historia se relaciona con una Epic, tiene una prioridad de negocio y contiene criterios de aceptación comprobables. La prioridad **High** identifica capacidades directamente vinculadas con los Business Goals; **Medium** corresponde a capacidades de soporte; y **Low** corresponde a documentación o mejoras posteriores.

Los criterios de aceptación se expresan con la estructura Gherkin **Given - When - Then**, se redactan en tiempo presente y tercera persona, y describen resultados observables sin fijar detalles innecesarios de interfaz. Las Technical Stories utilizan el rol Developer cuando la capacidad no tiene interacción directa con un usuario final. Las Spike Stories expresan una investigación que debe cerrarse con resultados documentados y evidencia suficiente para reducir la incertidumbre.

**Epics**

| Epic ID | Title | Description |
| --- | --- | --- |
| E1 | Driver Mobile Experience | Capacidades móviles que permiten al Driver consultar Availability e identificar las Parking Zones que puede utilizar según su User Profile. |
| E2 | Parking Organization and Profiles | Configuración de Parking Spots, Parking Zones, usuarios, vehículos y perfiles por parte del Parking Administrator. |
| E3 | Occupancy Monitoring and Operations | Monitoreo de Occupancy Status, dashboard operativo, alertas por Unauthorized Parking y Occupancy Reports. |
| E4 | Digital Presence and Mobile Quality | Landing Page estática, accesibilidad e internacionalización de los productos digitales de SpotGo. |
| E5 | Services and Technical Enablement | Servicios RESTful, autenticación, persistencia local, sincronización, documentación y validaciones técnicas necesarias para la aplicación móvil. |

**User Stories**

***US01 - Consult Availability by Zone***

| Campo | Especificación |
| --- | --- |
| Story ID | US01 |
| User | Driver |
| Priority | High |
| Epic | E1 - Driver Mobile Experience |
| Title | Consult Availability by Zone |
| Description | **As a** Driver,<br>**I want** to consult current Availability by Parking Zone,<br>**so that** I can identify where a Parking Spot may be available. |
| Acceptance Criteria | **Scenario 1: Zone with availability**<br>**Given** una Parking Zone contiene al menos un Parking Spot con Occupancy Status *Available*<br>**When** el Driver solicita la Availability actual<br>**Then** la aplicación informa la cantidad de Parking Spots disponibles y el momento de la última actualización.<br><br>**Scenario 2: Zone without availability**<br>**Given** todos los Parking Spots de una Parking Zone tienen Occupancy Status *Occupied*<br>**When** el Driver solicita la Availability actual<br>**Then** la aplicación informa que la zona no tiene Parking Spots disponibles. |

***US02 - Configure Parking Zones***

| Campo | Especificación |
| --- | --- |
| Story ID | US02 |
| User | Parking Administrator |
| Priority | High |
| Epic | E2 - Parking Organization and Profiles |
| Title | Configure Parking Zones |
| Description | **As a** Parking Administrator,<br>**I want** to create Parking Zones and associate them with User Profiles,<br>**so that** the parking facility can organize its Parking Spots according to its operating rules. |
| Acceptance Criteria | **Scenario 1: Valid zone configuration**<br>**Given** existen Parking Spots registrados y los datos de la zona son válidos<br>**When** el Parking Administrator crea una Parking Zone y asocia los Parking Spots seleccionados<br>**Then** el sistema guarda la relación entre la zona, sus espacios y los User Profiles autorizados.<br><br>**Scenario 2: Conflicting spot assignment**<br>**Given** un Parking Spot ya pertenece a otra Parking Zone<br>**When** el Parking Administrator intenta guardarlo en una nueva zona<br>**Then** el sistema identifica el conflicto y no guarda la nueva relación hasta que la asignación sea resuelta. |

***US03 - Register and Classify User and Vehicle***

| Campo | Especificación |
| --- | --- |
| Story ID | US03 |
| User | Parking Administrator |
| Priority | High |
| Epic | E2 - Parking Organization and Profiles |
| Title | Register and Classify User and Vehicle |
| Description | **As a** Parking Administrator,<br>**I want** to register a Driver and associate a vehicle with a User Profile,<br>**so that** the system can determine the Parking Zones that correspond to the driver. |
| Acceptance Criteria | **Scenario 1: Valid registration**<br>**Given** los datos del Driver, del vehículo y del User Profile son válidos<br>**When** el Parking Administrator registra la información<br>**Then** el sistema almacena la asociación entre el Driver, el vehículo y el User Profile seleccionado.<br><br>**Scenario 2: Invalid or duplicated data**<br>**Given** falta un dato obligatorio o el identificador del vehículo ya está registrado<br>**When** el Parking Administrator intenta guardar el registro<br>**Then** el sistema rechaza la operación y conserva sin cambios los registros existentes. |

***US04 - View Permitted Zones***

| Campo | Especificación |
| --- | --- |
| Story ID | US04 |
| User | Driver |
| Priority | High |
| Epic | E1 - Driver Mobile Experience |
| Title | View Permitted Zones |
| Description | **As a** Driver,<br>**I want** to know which Parking Zones are permitted for my User Profile,<br>**so that** I can use only the areas assigned to my category. |
| Acceptance Criteria | **Scenario 1: Profile with permitted zones**<br>**Given** el Driver tiene un User Profile activo y existen Parking Zones asociadas<br>**When** la aplicación consulta la información del perfil<br>**Then** el sistema devuelve las zonas permitidas junto con su Availability actual.<br><br>**Scenario 2: No permitted zone available**<br>**Given** el Driver no tiene una Parking Zone permitida con Availability<br>**When** la aplicación consulta las zonas correspondientes<br>**Then** el sistema informa que no hay disponibilidad en las zonas autorizadas y no incluye zonas no permitidas. |

***US05 - Monitor Occupancy by Zone***

| Campo | Especificación |
| --- | --- |
| Story ID | US05 |
| User | Parking Administrator |
| Priority | High |
| Epic | E3 - Occupancy Monitoring and Operations |
| Title | Monitor Occupancy by Zone |
| Description | **As a** Parking Administrator,<br>**I want** to monitor the Occupancy Status of Parking Spots grouped by Parking Zone,<br>**so that** I can supervise the current operation of the parking facility. |
| Acceptance Criteria | **Scenario 1: Current monitoring data**<br>**Given** existen estados de ocupación registrados para los Parking Spots<br>**When** el Parking Administrator solicita el monitoreo actual<br>**Then** el sistema agrupa la información por Parking Zone y calcula la cantidad de espacios *Available* y *Occupied*.<br><br>**Scenario 2: Occupancy change**<br>**Given** cambia el Occupancy Status de un Parking Spot<br>**When** el sistema procesa la actualización<br>**Then** recalcula la Availability de la Parking Zone relacionada y la información queda disponible para la siguiente consulta. |

***US06 - Generate Unauthorized Parking Alert***

| Campo | Especificación |
| --- | --- |
| Story ID | US06 |
| User | Parking Administrator |
| Priority | High |
| Epic | E3 - Occupancy Monitoring and Operations |
| Title | Generate Unauthorized Parking Alert |
| Description | **As a** Parking Administrator,<br>**I want** to receive an alert when a vehicle uses a non-permitted Parking Zone,<br>**so that** I can review and address possible parking infractions. |
| Acceptance Criteria | **Scenario 1: Unauthorized use detected**<br>**Given** el sistema conoce el User Profile del vehículo y la Parking Zone ocupada no está permitida para ese perfil<br>**When** se valida la relación entre el vehículo, la zona y el perfil<br>**Then** el sistema crea una Unauthorized Parking Alert con la zona, el Parking Spot, el perfil y el momento del evento.<br><br>**Scenario 2: Alert resolution**<br>**Given** existe una Unauthorized Parking Alert pendiente<br>**When** el Parking Administrator registra que la incidencia fue revisada<br>**Then** el sistema cambia el estado de la alerta a resuelta y conserva su historial. |

***US07 - Use the Operational Mobile Dashboard***

| Campo | Especificación |
| --- | --- |
| Story ID | US07 |
| User | Parking Administrator |
| Priority | High |
| Epic | E3 - Occupancy Monitoring and Operations |
| Title | Use the Operational Mobile Dashboard |
| Description | **As a** Parking Administrator,<br>**I want** to consult a centralized operational summary in the mobile application,<br>**so that** I can review occupancy, Availability and pending incidents in one place. |
| Acceptance Criteria | **Scenario 1: Current operational summary**<br>**Given** el Parking Administrator tiene acceso autorizado y existen datos operativos<br>**When** solicita el resumen actual<br>**Then** el sistema devuelve la cantidad total de Parking Spots, la Availability por Parking Zone y las Unauthorized Parking Alerts pendientes.<br><br>**Scenario 2: Zone detail**<br>**Given** el Parking Administrator solicita información de una Parking Zone específica<br>**When** el sistema procesa la consulta<br>**Then** devuelve únicamente los Parking Spots y estados relacionados con esa zona junto con su última actualización. |

***US08 - Generate Occupancy Reports***

| Campo | Especificación |
| --- | --- |
| Story ID | US08 |
| User | Parking Administrator |
| Priority | Medium |
| Epic | E3 - Occupancy Monitoring and Operations |
| Title | Generate Occupancy Reports |
| Description | **As a** Parking Administrator,<br>**I want** to consult Occupancy Reports grouped by period and Parking Zone,<br>**so that** I can identify usage patterns and support operational decisions. |
| Acceptance Criteria | **Scenario 1: Period with historical data**<br>**Given** existen registros de Occupancy Status para el periodo solicitado<br>**When** el Parking Administrator genera el Occupancy Report<br>**Then** el sistema agrupa los datos por Parking Zone y periodo e informa los patrones de utilización disponibles.<br><br>**Scenario 2: Period without data**<br>**Given** no existen registros para el periodo solicitado<br>**When** el Parking Administrator genera el Occupancy Report<br>**Then** el sistema informa que no hay datos disponibles y no infiere valores inexistentes. |

***US09 - Access Mobile Functions by Role***

| Campo | Especificación |
| --- | --- |
| Story ID | US09 |
| User | Driver or Parking Administrator |
| Priority | Medium |
| Epic | E5 - Services and Technical Enablement |
| Title | Access Mobile Functions by Role |
| Description | **As a** Driver or Parking Administrator,<br>**I want** to access SpotGo with my authorized account,<br>**so that** I can use only the capabilities related to my role. |
| Acceptance Criteria | **Scenario 1: Valid access**<br>**Given** la cuenta está activa y las credenciales son válidas<br>**When** el usuario solicita acceso a SpotGo<br>**Then** el sistema autentica al usuario y habilita las capacidades asociadas con su rol.<br><br>**Scenario 2: Invalid or expired access**<br>**Given** las credenciales son inválidas o la sesión ya no es válida<br>**When** el usuario solicita acceso a información protegida<br>**Then** el sistema rechaza la solicitud y no entrega datos de ocupación, perfiles o zonas restringidas. |

***US10 - Support Accessibility and Languages in the Mobile Application***

| Campo | Especificación |
| --- | --- |
| Story ID | US10 |
| User | Driver or Parking Administrator |
| Priority | Medium |
| Epic | E4 - Digital Presence and Mobile Quality |
| Title | Support Accessibility and Languages in the Mobile Application |
| Description | **As a** Driver or Parking Administrator,<br>**I want** the mobile application to support accessibility and Spanish/English language options,<br>**so that** I can use SpotGo according to my needs and language preference. |
| Acceptance Criteria | **Scenario 1: Language selection**<br>**Given** el usuario selecciona español o inglés como idioma de la aplicación<br>**When** la aplicación carga la información del producto<br>**Then** muestra los textos y estados del dominio en el idioma seleccionado, y utiliza español como fallback cuando no existe una traducción.<br><br>**Scenario 2: Assistive technology**<br>**Given** el usuario utiliza una tecnología de asistencia<br>**When** consulta el contenido y las acciones de la aplicación móvil<br>**Then** la aplicación expone nombres accesibles, estados comprensibles y un orden de navegación lógico. |

***US11 - Communicate the Value Proposition on the Landing Page***

| Campo | Especificación |
| --- | --- |
| Story ID | US11 |
| User | Visitor |
| Priority | Medium |
| Epic | E4 - Digital Presence and Mobile Quality |
| Title | Communicate the Value Proposition on the Landing Page |
| Description | **As a** Visitor,<br>**I want** to understand the problem, value proposition and main capabilities of SpotGo,<br>**so that** I can evaluate the product and access the mobile application. |
| Acceptance Criteria | **Scenario 1: Public content**<br>**Given** el Visitor accede a la Landing Page pública<br>**When** el contenido se carga<br>**Then** la página comunica el problema, la propuesta de valor y las capacidades principales de SpotGo sin requerir autenticación.<br><br>**Scenario 2: Mobile viewport**<br>**Given** el Visitor accede desde un dispositivo móvil<br>**When** consulta la Landing Page<br>**Then** el contenido permanece legible, se adapta al tamaño disponible y mantiene un acceso claro a la información de la aplicación móvil. |

***US12 - Navigate from the Landing Page to the Mobile Product***

| Campo | Especificación |
| --- | --- |
| Story ID | US12 |
| User | Visitor |
| Priority | Medium |
| Epic | E4 - Digital Presence and Mobile Quality |
| Title | Navigate from the Landing Page to the Mobile Product |
| Description | **As a** Visitor,<br>**I want** to navigate between the sections of the Landing Page and reach the mobile product destination,<br>**so that** I can continue from product information to the application. |
| Acceptance Criteria | **Scenario 1: Section navigation**<br>**Given** el Visitor solicita una sección disponible de la Landing Page<br>**When** se procesa la navegación<br>**Then** el sistema dirige al contenido correspondiente sin perder el contexto de la página.<br><br>**Scenario 2: Mobile product destination**<br>**Given** el Visitor solicita acceder al producto móvil<br>**When** se procesa el enlace de acceso<br>**Then** la Landing Page dirige al destino oficial de descarga o acceso de la aplicación móvil. |

***TS01 - Synchronize Mobile Data through RESTful Services***

| Campo | Especificación |
| --- | --- |
| Story ID | TS01 |
| User | Developer |
| Priority | High |
| Epic | E5 - Services and Technical Enablement |
| Title | Synchronize Mobile Data through RESTful Services |
| Description | **As a** Developer,<br>**I want** RESTful services to expose the configured zones, profiles and occupancy data,<br>**so that** the mobile application can synchronize the information required by each actor. |
| Acceptance Criteria | **Scenario 1: Authorized request**<br>**Given** la aplicación móvil envía una solicitud válida y autorizada de zonas o Availability<br>**When** el servicio procesa la solicitud<br>**Then** responde con la información actual y con un esquema consistente para el consumo móvil.<br><br>**Scenario 2: Invalid or unauthorized request**<br>**Given** la solicitud contiene datos inválidos o no cuenta con autorización<br>**When** el servicio la procesa<br>**Then** responde con un error identificable y no expone información protegida. |

***TS02 - Persist and Synchronize Data on the Mobile Device***

| Campo | Especificación |
| --- | --- |
| Story ID | TS02 |
| User | Developer |
| Priority | Medium |
| Epic | E5 - Services and Technical Enablement |
| Title | Persist and Synchronize Data on the Mobile Device |
| Description | **As a** Developer,<br>**I want** the mobile application to retain the last synchronized information locally,<br>**so that** users can consult the most recent known data during temporary connectivity interruptions. |
| Acceptance Criteria | **Scenario 1: Temporary loss of connectivity**<br>**Given** la aplicación tiene datos sincronizados previamente y no existe conexión temporalmente<br>**When** el usuario consulta la Availability o las zonas permitidas<br>**Then** la aplicación ofrece la última información conocida junto con su momento de actualización y la identifica como potencialmente desactualizada.<br><br>**Scenario 2: Connectivity restored**<br>**Given** la conexión con los servicios se restablece<br>**When** la aplicación ejecuta la sincronización<br>**Then** actualiza la información local con los datos más recientes sin duplicar registros ni conservar estados obsoletos cuando existe una versión nueva. |

***TS03 - Document the RESTful Service Contract***

| Campo | Especificación |
| --- | --- |
| Story ID | TS03 |
| User | Developer |
| Priority | Low |
| Epic | E5 - Services and Technical Enablement |
| Title | Document the RESTful Service Contract |
| Description | **As a** Developer,<br>**I want** the active RESTful services to have documented requests and responses,<br>**so that** the mobile application team can integrate them consistently. |
| Acceptance Criteria | **Scenario 1: Complete endpoint documentation**<br>**Given** existen endpoints activos del producto<br>**When** el Developer consulta la documentación<br>**Then** encuentra los verbos, parámetros, respuestas, errores y ejemplos correspondientes a cada endpoint.<br><br>**Scenario 2: Contract example**<br>**Given** el Developer ejecuta una solicitud válida con los datos de ejemplo<br>**When** el servicio procesa la solicitud<br>**Then** la respuesta obtenida respeta el contrato documentado. |

***SP01 - Investigate the Occupancy Monitoring Mechanism***

| Campo | Especificación |
| --- | --- |
| Story ID | SP01 |
| User | Developer |
| Priority | High |
| Epic | E5 - Services and Technical Enablement |
| Title | Investigate the Occupancy Monitoring Mechanism |
| Description | **As a** Developer,<br>**I want** to evaluate viable mechanisms for obtaining Occupancy Status data,<br>**so that** the team can select an approach compatible with the pilot without prematurely fixing a hardware solution. |
| Acceptance Criteria | **Scenario 1: Alternatives comparison**<br>**Given** están definidos los datos de ocupación que necesita SpotGo<br>**When** el equipo evalúa al menos dos alternativas viables<br>**Then** documenta la comparación de calidad de datos, costo, mantenimiento, conectividad, privacidad y esfuerzo de integración.<br><br>**Scenario 2: Spike closure**<br>**Given** la comparación técnica está completa<br>**When** el equipo cierra el spike<br>**Then** existe un informe con la recomendación, sus restricciones, riesgos y evidencia de una prueba de concepto, prueba técnica o flujo de datos de ejemplo. |

***SP02 - Investigate the Mobile Synchronization Strategy***

| Campo | Especificación |
| --- | --- |
| Story ID | SP02 |
| User | Developer |
| Priority | Medium |
| Epic | E5 - Services and Technical Enablement |
| Title | Investigate the Mobile Synchronization Strategy |
| Description | **As a** Developer,<br>**I want** to evaluate the local persistence and synchronization strategy for the mobile application,<br>**so that** SpotGo can respond predictably to temporary connectivity interruptions. |
| Acceptance Criteria | **Scenario 1: Strategy evaluation**<br>**Given** la aplicación debe consultar información en contextos de conectividad variable<br>**When** el equipo prueba las alternativas de persistencia y sincronización<br>**Then** documenta el comportamiento esperado ante pérdida, recuperación y actualización de la conexión.<br><br>**Scenario 2: Evidence and decision**<br>**Given** la prueba técnica concluye<br>**When** el equipo cierra el spike<br>**Then** conserva evidencia del prototipo o prueba, la decisión adoptada y las limitaciones que deben considerarse en la implementación. |

**Traceability with Lean UX**

| Lean UX item | Related requirements |
| --- | --- |
| FA01 / HS01 - Monitoreo de ocupación por zonas | US05, TS01, TS02, SP01 |
| FA02 / HS02 - Registro y clasificación de usuarios | US03, US09 |
| FA03 / HS03 - Asignación de zonas según tipo de usuario | US02, US04 |
| FA04 / HS04 - Sistema de alertas por uso indebido | US06, US07 |
| FA05 / HS05 - Panel de control para administradores | US07 |
| FA06 / HS06 - Visualización actualizada de disponibilidad | US01, US04, TS01 |
| FA07 / HS07 - Reportes de ocupación | US08, TS03 |

### 2.4.2. Impact Mapping

El Impact Mapping de SpotGo se actualiza para representar el alcance mobile-first y conectar los resultados esperados con los actores y requisitos priorizados. Los Business Goals son metas iniciales de validación; no representan resultados ya alcanzados. Se formulan con criterios SMART porque especifican una métrica, un valor objetivo, un contexto y un plazo.

Los actores se toman de los User Personas definidos previamente: **Carlos Ramirez**, de tipo *Guardian*, representa al Parking Administrator; y **Andres Salazar**, de tipo *Rational*, representa al Driver. Las relaciones del mapa siguen la secuencia Business Goal, Actor/Persona, Impact, Deliverable y User Story.

La línea base para BG02 y BG03 deberá levantarse antes de iniciar los pilotos, registrando el tiempo de búsqueda de los conductores y la cantidad de incidencias de estacionamiento indebido durante un periodo comparable. Así, los porcentajes planteados podrán verificarse con datos observables y no solo con percepciones.

| Business Goal | Actor / Persona | Impact | Deliverable | User Stories relacionadas |
| --- | --- | --- | --- | --- |
| **BG01:** Validar SpotGo en 3 estacionamientos piloto de alta afluencia durante los primeros 6 meses de operación. | Carlos Ramirez - Parking Administrator | Configura las Parking Zones y los User Profiles de acuerdo con las reglas de cada estacionamiento. | Módulo móvil para configurar Parking Zones y asociar perfiles. | **US02:** Como Parking Administrator, deseo configurar las Parking Zones y asociarlas con perfiles, para organizar la operación del estacionamiento.<br>**US03:** Como Parking Administrator, deseo registrar y clasificar vehículos, para determinar las zonas permitidas. |
| **BG01:** Validar SpotGo en 3 estacionamientos piloto de alta afluencia durante los primeros 6 meses de operación. | Andres Salazar - Driver | Consulta la Availability y utiliza la Parking Zone que corresponde a su User Profile. | Consulta móvil de Availability y zonas permitidas según el perfil. | **US01:** Como Driver, deseo consultar la Availability por Parking Zone, para identificar dónde puede existir un Parking Spot disponible.<br>**US04:** Como Driver, deseo conocer las zonas permitidas según mi perfil, para evitar utilizar áreas no autorizadas. |
| **BG02:** Reducir en 20% el tiempo promedio de búsqueda reportado por los conductores en los estacionamientos piloto al finalizar el sexto mes, frente a la línea base. | Andres Salazar - Driver | Consulta información actualizada antes de recorrer el estacionamiento y reduce recorridos innecesarios. | Vista móvil de Availability por zona y sincronización de datos de disponibilidad. | **US01:** Como Driver, deseo consultar la Availability por zona, para identificar una zona con posibilidad de espacio.<br>**US04:** Como Driver, deseo consultar mis zonas permitidas, para enfocar mi búsqueda en áreas que puedo utilizar.<br>**TS01:** Como Developer, deseo sincronizar Availability mediante servicios RESTful, para entregar datos consistentes a la aplicación móvil. |
| **BG03:** Reducir en 15% las incidencias de estacionamiento indebido en los estacionamientos piloto al finalizar el sexto mes, frente a la línea base. | Carlos Ramirez - Parking Administrator | Monitorea el Occupancy Status, atiende Unauthorized Parking Alerts y revisa patrones de uso. | Dashboard móvil, alertas por Unauthorized Parking y Occupancy Reports. | **US05:** Como Parking Administrator, deseo monitorear el Occupancy Status por zona, para supervisar la operación.<br>**US06:** Como Parking Administrator, deseo recibir alertas por uso indebido, para revisar las incidencias.<br>**US07:** Como Parking Administrator, deseo consultar un resumen operativo, para controlar ocupación y alertas.<br>**US08:** Como Parking Administrator, deseo consultar Occupancy Reports, para apoyar decisiones operativas. |

*Impact Map*
![Impact Map](../assets/diagrams/impact-map.svg)

La figura presenta la relación visual entre los tres Business Goals, los User Personas, los cambios de comportamiento esperados, los entregables y las historias que los habilitan. La versión anterior del mapa contenía elementos del alcance web que ya no forman parte de esta especificación; por ello se presenta una versión actualizada y coherente con las historias de esta sección.

### 2.4.3. Product Backlog

El Product Backlog ordena los requisitos por valor para el negocio y por contribución a los Business Goals. El orden no representa necesariamente la secuencia técnica de implementación. Por ese motivo, las historias de autenticación y soporte aparecen después de las capacidades que validan directamente la propuesta de valor. Las historias de la Landing Page se incluyen desde el Sprint 1, tal como solicita la rúbrica.

Los Story Points utilizan la escala de Fibonacci permitida por la rúbrica: 1, 2, 3, 5 y 8. Los Sprints propuestos son una primera distribución de trabajo y deberán confirmarse en el Sprint Planning con el equipo.

| # Orden | User Story Id | Título | Story Points | Sprint |
| --- | --- | --- | ---: | --- |
| 1 | US01 | Consult Availability by Zone | 5 | Sprint 1 |
| 2 | US02 | Configure Parking Zones | 5 | Sprint 1 |
| 3 | US03 | Register and Classify User and Vehicle | 3 | Sprint 1 |
| 4 | US04 | View Permitted Zones | 3 | Sprint 1 |
| 5 | US05 | Monitor Occupancy by Zone | 5 | Sprint 2 |
| 6 | US06 | Generate Unauthorized Parking Alert | 3 | Sprint 2 |
| 7 | US07 | Use the Operational Mobile Dashboard | 5 | Sprint 2 |
| 8 | US08 | Generate Occupancy Reports | 3 | Sprint 3 |
| 9 | US11 | Communicate the Value Proposition on the Landing Page | 3 | Sprint 1 |
| 10 | US12 | Navigate from the Landing Page to the Mobile Product | 2 | Sprint 1 |
| 11 | TS01 | Synchronize Mobile Data through RESTful Services | 5 | Sprint 1 |
| 12 | TS02 | Persist and Synchronize Data on the Mobile Device | 5 | Sprint 2 |
| 13 | SP01 | Investigate the Occupancy Monitoring Mechanism | 3 | Sprint 1 |
| 14 | SP02 | Investigate the Mobile Synchronization Strategy | 3 | Sprint 1 |
| 15 | US09 | Access Mobile Functions by Role | 3 | Sprint 2 |
| 16 | US10 | Support Accessibility and Languages in the Mobile Application | 3 | Sprint 3 |
| 17 | TS03 | Document the RESTful Service Contract | 2 | Sprint 3 |

La priorización pone al inicio las capacidades que permiten validar el valor principal de SpotGo: consultar disponibilidad, organizar zonas, clasificar usuarios y operar el monitoreo. Las Spike Stories permanecen en el Sprint 1 porque reducen incertidumbre antes de fijar la solución de Occupancy Monitoring y la estrategia de sincronización móvil.

**Evidencia del Product Backlog en Trello**

La rúbrica solicita una captura del tablero y una referencia al URL público del Product Backlog. El avance recibido no incluye ese tablero ni un enlace público verificable, por lo que no se inventa una URL. Debe incorporarse la evidencia real del equipo en los siguientes espacios:

- **Trello Board Link:**

- **Trello Board Evidence:**

La tabla anterior deja listo el contenido que debe reflejarse en la herramienta y permite comprobar la correspondencia entre el orden, los Story Points y los Sprints.

## 2.5. Strategic-Level Domain-Driven Design

### 2.5.1. EventStorming

#### *2.5.1.1. Candidate Context Discovery*

#### *2.5.1.2. Domain Message Flows Modeling*

#### *2.5.1.3. Bounded Context Canvases*

#### *2.5.2. Context Mapping*

#### *2.5.3. Software Architecture*

#### ***2.5.3.1. Software Architecture Context Level Diagrams***

#### ***2.5.3.2. Software Architecture Container Level Diagrams***

#### ***2.5.3.3. Software Architecture Deployment Diagrams***

## 2.6. Tactical-Level Domain-Driven Design
