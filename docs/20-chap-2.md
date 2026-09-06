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
| Canales de distribución | App móvil, panel web y servicios backend integrados. | App móvil, web y red física de estacionamientos. | Plataforma web, app e integraciones con dispositivos. | Web, app, APIs y sistemas integrados en vehículos. |

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
| Duración:|  |
| Nombre completo: |  |
| Edad: |  |
| Distrito: |  |
| Resumen: |  |

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

### 2.3.2. User Task Matrix

### 2.3.3. User Journey Mapping

### 2.3.4. Empathy Mapping

### 2.3.5. Big Picture EventStorming

### 2.3.6. Ubiquitous Language

## 2.4. Requirements specification

### 2.4.1. User Stories

### 2.4.2. Impact Mapping

### 2.4.3. Product Backlog

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
