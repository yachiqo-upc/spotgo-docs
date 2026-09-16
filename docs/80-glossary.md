# Glosario

Este glosario fija los nombres canónicos utilizados en la documentación de SpotGo. Las definiciones se presentan en español y los nombres del negocio se mantienen en inglés. La primera sección corresponde al Ubiquitous Language; la segunda reúne términos técnicos que no forman parte del lenguaje del dominio.

**Domain terms**

- **Additional Charge (Cargo adicional):** Importe generado cuando un Driver excede el periodo de su Reservation y supera el tiempo de tolerancia configurado.
- **Availability (Disponibilidad):** Información que indica la existencia de Parking Spots libres dentro de una Parking Zone.
- **Check-in / Check-out (Ingreso / Salida):** Eventos que marcan, respectivamente, el inicio y el final de la estadía de un vehículo en el estacionamiento.
- **Digital Payment (Pago digital):** Transacción económica realizada desde la aplicación móvil por un Driver registrado para pagar una Reservation, una estadía o un servicio contratado.
- **Digital Parking Map (Mapa digital del estacionamiento):** Representación de la infraestructura del estacionamiento que identifica sus Parking Spots, Parking Zones, accesos y destinos de navegación.
- **Driver (Conductor):** Usuario con una cuenta propia creada mediante la aplicación móvil, con credenciales propias o una cuenta externa autorizada. Administra su User Profile y sus Vehicles, consulta Availability y crea Reservations.
- **Electronic Billing (Facturación electrónica):** Capacidad del negocio que determina y genera el Electronic Receipt o Electronic Invoice aplicable a una operación elegible de un Driver.
- **Electronic Invoice (Factura electrónica):** Documento fiscal digital generado para una operación que requiere información tributaria empresarial, como un RUC, y que conserva su relación con el Digital Payment y la operación correspondiente.
- **Electronic Receipt (Comprobante de pago electrónico):** Documento fiscal digital generado para una operación elegible de un Driver cuando proporciona un DNI, y que conserva su relación con el Digital Payment y la operación correspondiente.
- **Floor Plan (Plano):** Representación o archivo que describe la distribución física del estacionamiento y constituye la fuente autorizada para configurar el Digital Parking Map.
- **Guest (Invitado):** Persona sin cuenta que llega directamente al estacionamiento. No crea una Reservation ni un Vehicle persistente en SpotGo y paga físicamente el tiempo utilizado al finalizar su estadía.
- **Guest Parking Session (Sesión de estacionamiento de invitado):** Registro creado manualmente por un Parking Administrator cuando un Guest ingresa al estacionamiento. Conserva la placa, el Parking Spot asignado, las horas de ingreso y salida, el monto calculado y la confirmación operativa del pago físico.
- **High Capacity (Alta capacidad):** Estado operativo que se activa cuando la ocupación total supera el 95 % de los Parking Spots operativos disponibles y requiere una alerta para el Parking Administrator.
- **Nearby Parking Zones (Parking Zones cercanas):** Parking Zones registradas en SpotGo que la aplicación muestra alrededor de la ubicación del Driver junto con sus datos operativos, como Availability, horarios y precios.
- **Occupancy Monitoring (Monitoreo de ocupación):** Proceso mediante el cual SpotGo obtiene y mantiene actualizada, en un máximo de 5 segundos, la información sobre la ocupación de los espacios y zonas.
- **Occupancy Report (Reporte de ocupación):** Información histórica o resumida sobre la utilización de los Parking Spots y Parking Zones, utilizada para apoyar decisiones operativas.
- **Occupancy Sensor (Sensor de ocupación):** Dispositivo instalado en un Parking Spot para detectar si el espacio está disponible u ocupado y comunicar el cambio de estado al sistema.
- **Occupancy Status (Estado de ocupación):** Estado físico actual de un Parking Spot. Puede ser *Available*, *Occupied* o *Unavailable*; *Reserved* pertenece a Reservation Status y no reemplaza el estado físico del espacio.
- **Outstanding Balance (Saldo pendiente):** Importe que no pudo cobrarse mediante el Payment Token y que debe regularizarse antes de crear nuevas Reservations.
- **Parking Administrator (Administrador de estacionamiento):** Usuario cuya cuenta es creada por un SuperAdmin y que gestiona la configuración, supervisión y organización de las zonas y usuarios de un Tenant.
- **Parking Session (Sesión de estacionamiento):** Registro de la ocupación real de un Parking Spot. En una Reservation de un Driver se relaciona con la Reservation y el espacio asignado; en un Guest se utiliza Guest Parking Session.
- **Parking Spot (Espacio de estacionamiento):** Espacio físico individual dentro de un estacionamiento destinado a la ubicación de un solo vehículo.
- **Parking Zone (Zona de estacionamiento):** Área del estacionamiento que agrupa múltiples Parking Spots y puede asociarse con uno o más tipos de usuario definidos por la administración.
- **Payment Token (Token de pago):** Referencia segura administrada por el servicio interno de pagos que permite reutilizar un método autorizado sin almacenar los datos completos de la tarjeta.
- **Receipt (Comprobante):** Documento o confirmación asociada con una operación de SpotGo. Puede ser un Virtual Receipt, Electronic Receipt o Electronic Invoice, según la finalidad y la información tributaria disponible.
- **Reservation (Reserva):** Registro mediante el cual un Driver registrado obtiene el uso de un Parking Spot dentro de una Parking Zone en una fecha, hora de inicio y duración determinadas, después de la aprobación del Digital Payment correspondiente.
- **Reservation Status (Estado de reserva):** Estado comercial y operativo de una Reservation. Puede ser *Reserved*, *Active*, *Completed*, *Cancelled*, *No-show* u *Overstayed*.
- **Sensor Health (Salud del sensor):** Estado operativo de un Occupancy Sensor. Cuando el sensor no comunica datos confiables, el Occupancy Status correspondiente es *Unavailable*.
- **Staff (Personal operativo):** Perfil operativo que un Parking Administrator puede asignar a un Driver para determinar el acceso a zonas restringidas y funciones operativas.
- **Subscription (Suscripción):** Plan de acceso periódico de SpotGo. Puede ser *Free*, *Plus Monthly* o *Plus Annual*, con beneficios, descuentos y condiciones de renovación definidos para cada plan.
- **SuperAdmin (Administrador de plataforma):** Usuario encargado de registrar Tenants, crear las cuentas iniciales de los Parking Administrators y administrar la configuración de los clientes B2B.
- **Tenant (Cliente B2B):** Estacionamiento o entidad operativa registrada en SpotGo, con su propia configuración de zonas, perfiles, usuarios y facturación del servicio.
- **Unauthorized Parking (Estacionamiento indebido):** Ocupación no validada que el Parking Administrator confirma como uso no autorizado después de revisar la operación y las condiciones del estacionamiento.
- **Unauthorized Parking Alert (Alerta por estacionamiento indebido):** Alerta operativa generada cuando un Parking Spot presenta Unvalidated Occupancy. Requiere revisión y clasificación por parte del Parking Administrator.
- **Unvalidated Occupancy (Ocupación no validada):** Situación en la que un Parking Spot aparece *Occupied* sin una Reservation o Guest Parking Session activa que autorice su uso.
- **User Profile (Perfil de usuario):** Clasificación asignada a un Driver que determina las Parking Zones que puede utilizar. Puede representar el perfil estándar de Driver o el perfil operativo de Staff.
- **Vehicle (Vehículo):** Medio de transporte asociado con un Driver y utilizado para ocupar un Parking Spot. Un Driver puede registrar varios Vehicles y seleccionarlos en sus Reservations; el Vehicle no almacena la placa como dato permanente.
- **Virtual Receipt (Comprobante virtual):** Confirmación digital, no necesariamente fiscal, de una Reservation o Digital Payment que contiene la información necesaria para identificar la operación y el espacio asignado.
- **Zone Assignment (Asignación de zona):** Proceso mediante el cual se determina qué Parking Zone corresponde a un Driver según su User Profile.

**Technical terms and abbreviations**

- **Accessibility (a11y):** Prácticas y criterios técnicos que permiten utilizar los productos digitales mediante distintas capacidades, dispositivos y tecnologías de asistencia.
- **Dashboard:** Interfaz de consulta y operación que reúne información de ocupación, zonas, incidencias y reportes para el personal autorizado.
- **en_US:** Locale de English utilizado como idioma predeterminado en los productos, mensajes, interfaces y documentación de SpotGo.
- **es_419:** Locale de Latin American Spanish ofrecido como alternativa de idioma.
- **External Navigation Link:** Enlace que abre la aplicación de Google Maps con una Parking Zone como destino para que dicha aplicación calcule la ruta.
- **Firebase Cloud Messaging:** Servicio externo de notificaciones push. El backend decide el evento que se comunica y Firebase Cloud Messaging entrega el mensaje al dispositivo registrado.
- **Figma:** Herramienta utilizada para elaborar wireframes, mockups y prototipos de las interfaces.
- **Google Authentication:** Mecanismo externo que permite a un Driver crear una cuenta o iniciar sesión mediante una cuenta de Google. No crea cuentas de Parking Administrator ni de SuperAdmin.
- **Google Maps API:** API utilizada para mostrar el mapa integrado dentro de SpotGo. SpotGo proporciona las ubicaciones y detalles de sus Parking Zones; la aplicación de Google Maps calcula la ruta externa hacia la zona seleccionada.
- **Google Maps application:** Aplicación externa que abre la ruta desde la ubicación del Driver hasta la Parking Zone seleccionada.
- **Internationalization (i18n):** Capacidad de preparar un producto para soportar varios idiomas y locales, incluidos en_US y es_419.
- **OpenAPI/Swagger:** Especificación y herramientas utilizadas para documentar, consultar y verificar el contrato de los Web Services RESTful.
- **RESTful API:** Servicio web que expone recursos y operaciones mediante convenciones REST para que la aplicación móvil sincronice información con el backend.
- **UXPressia:** Herramienta utilizada para elaborar User Personas, Empathy Maps, User Journey Maps e Impact Maps.
- **WCAG 2.2:** Estándar del W3C con criterios verificables para evaluar la accesibilidad del contenido web y de los productos digitales.
