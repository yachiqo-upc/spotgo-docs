workspace "SpotGo - Software Architecture" "Arquitectura de Software de SpotGo basada en C4 Model y DDD" {

    model {

        // =========================================================
        // ACTORES
        // =========================================================

        driver = person "Driver" "Conductor que consulta disponibilidad, registra vehículos, reserva y realiza pagos."

        parkingAdmin = person "Parking Admin" "Administra la operación del estacionamiento mediante sus vistas administrativas."

        superAdmin = person "SuperAdmin" "Crea y administra Tenants y provisiona las cuentas de Parking Admin y de otros SuperAdmins."


        // =========================================================
        // SISTEMAS EXTERNOS
        // =========================================================

        googleIdentity = softwareSystem "Google Identity / Google Sign-In" "Proveedor externo de identidad que autentica al usuario y emite un ID token; SpotGo valida ese token y administra su propia sesión y roles." {
            tags "External System"
        }

        googleMaps = softwareSystem "Google Maps" "Aplicación externa que calcula rutas hacia la Parking Zone seleccionada." {
            tags "External System"
        }

        openStreetMapTiles = softwareSystem "OpenStreetMap Tile Service" "Servicio externo de mosaicos raster en https://tile.openstreetmap.org/{z}/{x}/{y}.png, consultado bajo demanda por Driver y renderizado con MapLibre." {
            tags "External System"
        }

        notificationProvider = softwareSystem "Firebase Cloud Messaging" "Servicio externo de Google utilizado para enviar notificaciones push a los usuarios." {
            tags "External System"
        }

        resendEmail = softwareSystem "Resend Email API" "Proveedor externo de correo para códigos de restablecimiento y configuración inicial de cuentas." {
            tags "External System"
        }

        parkingSensors = softwareSystem "Sensores Físicos IoT" "Sensores físicos que reportan únicamente ocupación y estado de salud; no identifican la placa ni el vehículo." {
            tags "External System"
        }


        // =========================================================
        // SISTEMA SPOTGO
        // =========================================================

        spotgo = softwareSystem "SpotGo" "Sistema de gestión de estacionamientos." {

            // =====================================================
            // FRONTENDS
            // =====================================================

            driverApp = container "SpotGo Driver Android App" "Aplicación Android nativa exclusiva para Driver, desarrollada con Kotlin y Jetpack Compose. Integra el mapa con MapLibre y permite iniciar sesión y crear una cuenta." "Kotlin / Jetpack Compose / MapLibre"

            parkingAdminApp = container "SpotGo Parking Admin Flutter App" "Aplicación móvil multiplataforma exclusiva para Parking Admin, desarrollada con Flutter y Dart. Permite iniciar sesión con una cuenta provisionada y no ofrece registro público." "Flutter / Dart"


            landingPage = container "SpotGo Landing Page" "Sitio estático que presenta la propuesta de valor y dirige a cada perfil al canal de SpotGo que le corresponde; alojado en GitHub Pages." "HTML / CSS / Vanilla JS"

            webApp = container "SpotGo Administration Web App" "Aplicación web exclusiva para SuperAdmin, desarrollada con Angular, TypeScript y Angular Material." "Angular / TypeScript / Angular Material"

            backend = container "SpotGo Backend" "Única aplicación de backend de SpotGo, implementada como un monolito modular con cinco bounded contexts." "Java 25 LTS / Spring Boot / Docker" {
                group "Backend API" {
                    apiGateway = component "API Gateway" "Punto de entrada REST del Backend que dirige las solicitudes a los módulos internos." "Spring Boot"
                    domainEventDispatcher = component "Domain Event Publisher" "Emite eventos tipados dentro del monolito; los listeners los procesan después de confirmar la transacción." "Spring ApplicationEventPublisher"
                    pushNotificationService = component "Push Notification Service" "Registra Firebase Installation IDs (FID) y procesa eventos internos después del commit; el envío FCM queda deshabilitado hasta configurar backend y cliente." "Spring Boot / Firebase Admin SDK (optional)"
                }

                // =====================================================
                // BC01 - IDENTITY & ACCESS MANAGEMENT
                // =====================================================

                group "Identity & Access Management" {
                    identityService = component "Identity & Access Management Module" "Módulo de Identity & Access Management dentro del monolito modular de SpotGo." "Java / Spring Boot"
                    identityAuthentication = component "Authentication Component" "Autentica con correo y contraseña o con una identidad Google validada, conservando las cuentas y roles de SpotGo." "Spring Security"
                    identityGoogleAdapter = component "Google Identity Adapter" "Verifica la firma, el emisor, la audiencia y la expiración del ID token de Google y devuelve la identidad validada a Authentication Component." "Java / Google ID Token Verification"
                    identitySession = component "Session Management Component" "Gestiona sesiones y tokens de acceso." "Spring Security / JWT"
                    identityToken = component "Token Service Component" "Firma, valida, rota y revoca access tokens y refresh tokens." "Spring Security / JWT"
                    identityAuthorization = component "Authorization Component" "Controla permisos y acceso según roles." "Spring Security"
                    identityAccount = component "Account Component" "Gestiona el estado y ciclo de vida de las cuentas." "Java / Spring Boot"
                    identityAccountAdministration = component "Account and Role Administration Component" "SUPER_ADMIN provisiona Parking Admins para Tenants existentes, asigna roles y estados, y envía un código de configuración de un solo uso." "Spring Boot / JPA"
                    identityInvitationEmail = component "Account Invitation Email Adapter" "Envía códigos de configuración de cuenta y recuperación de contraseña; requiere RESEND_API_KEY y APP_PASSWORD_RESET_FROM_EMAIL." "Spring Boot / Resend REST API"
                    identityAudit = component "Audit Log Component" "Registra autenticaciones, autorizaciones, cambios de cuenta y acciones administrativas relevantes." "Spring Boot"
                }

                // =====================================================
                // BC02 - PROFILES & VEHICLES MANAGEMENT
                // =====================================================

                group "Profiles & Vehicles Management" {
                    profileService = component "Profiles & Vehicles Management Module" "Módulo de Profiles & Vehicles Management dentro del monolito modular de SpotGo." "Java / Spring Boot"
                    profileDriver = component "Profile Management Component" "Crea y actualiza el perfil personal asociado a la Account autenticada." "Spring Boot / JPA"
                    profileVehicle = component "Vehicle Component" "Registra y administra vehículos asociados al Profile Driver; desactivar conserva la fila." "Spring Boot / JPA"
                    profileClassification = component "Driver Classification Component" "Asigna TAXI, EMPLOYEE o PRIVATE por Profile y Tenant; el valor efectivo es PRIVATE si aún no hay asignación." "Spring Boot / JPA"
                }

                // =====================================================
                // BC03 - PARKING INFRASTRUCTURE
                // =====================================================

                group "Parking Infrastructure" {
                    parkingService = component "Parking Infrastructure Module" "Módulo de Parking Infrastructure dentro del monolito modular de SpotGo." "Java / Spring Boot"
                    parkingTenant = component "Tenant Component" "Gestiona al Tenant como empresa cliente y como su único estacionamiento físico, incluidos dirección, coordenadas y rules JSONB." "Spring Boot"
                    parkingTenantOnboarding = component "Tenant Onboarding Component" "SUPER_ADMIN crea un Tenant y su primer Parking Admin, perfil e invitación dentro de una transacción atómica." "Spring Boot / Transaction Management"
                    parkingZone = component "Parking Zone Component" "Gestiona las zonas, sus Parking Spots y los Profile Types permitidos por zona; sus nombres pueden representar pisos o áreas interiores y exteriores." "Spring Boot / JPA / JSONB"
                    parkingSpot = component "Parking Spot Component" "Gestiona los espacios y su disponibilidad." "Spring Boot"
                    parkingReservation = component "Reservation Component" "Gestiona el ciclo de vida de las reservas." "Spring Boot"
                    parkingReservationChange = component "Reservation Change Component" "Registra reprogramaciones y extensiones, su pago simulado y los reembolsos relacionados." "Spring Boot / JPA"
                    parkingFavorites = component "Favorites Component" "Persiste los estacionamientos favoritos de cada perfil Driver." "Spring Boot / JPA"
                    parkingAllocation = component "Spot Allocation Component" "Asigna, reasigna y aplica un Temporary Lock de 10 minutos durante el proceso de pago." "Spring Boot"
                    parkingReassignment = component "Reservation Reassignment Component" "Ante un conflicto de ocupación elegible, busca y reasigna la siguiente reserva confirmada a un Parking Spot activo, disponible y compatible." "Spring Boot / Spring Application Events"
                    parkingAvailability = component "Availability Component" "Calcula la disponibilidad actual de las zonas y espacios." "Spring Boot"
                    parkingGuest = component "Guest Parking Session Component" "Registra manualmente la placa, el ingreso, la salida y el pago físico de una Guest Parking Session; no crea una Reservation." "Spring Boot"
                    parkingSession = component "Parking Session Component" "Registra el ingreso y la salida de un Driver que utiliza una Reservation confirmada." "Spring Boot"
                    parkingIdentityAdapter = component "Identity & Access Management Adapter (Parking)" "Valida el rol y el alcance del actor antes de ejecutar operaciones protegidas." "Spring Boot / Internal Contract"
                    parkingProfileAdapter = component "Profiles & Vehicles Management Adapter" "Consulta Driver, Vehicle y User Profile mediante el contrato interno, sin acceder directamente a las tablas de otro bounded context." "Spring Boot / Internal Contract"
                    parkingPaymentAdapter = component "Payments & Billing Adapter (Parking Infrastructure)" "Solicita pagos, cargos adicionales y reembolsos mediante el contrato interno del contexto de pagos." "Spring Boot / Internal Contract"
                    parkingOccupancyAdapter = component "Occupancy & Monitoring Adapter" "Consulta la ocupación física confiable mediante un contrato interno." "Spring Boot / Internal Contract"
                }

                // =====================================================
                // BC04 - PAYMENTS & BILLING
                // =====================================================

                group "Payments & Billing" {
                    paymentService = component "Payments & Billing Module" "Módulo de Payments & Billing dentro del monolito modular de SpotGo." "Java / Spring Boot"
                    paymentProcessing = component "Payment Processing Component" "Procesa pagos digitales utilizando métodos tokenizados." "Spring Boot"
                    paymentToken = component "Payment Token Component" "Gestiona tokens asociados a los métodos de pago." "Spring Boot"
                    paymentSubscription = component "Subscription Component" "Gestiona periodos pagados DRIVER y TENANT. DRIVER paga S/15 al mes con 10% o S/160 al año con 15% de descuento solo sobre el precio final de reservas. TENANT paga S/30 por uso de la app más S/1 por Parking Spot registrado. Agregar un spot durante un periodo activo genera un cobro prorrateado inmediato con el token predeterminado; el spot se activa después de aprobar el pago y el snapshot de la suscripción se actualiza. No hay renovación mensual automática." "Spring Boot"
                    paymentAdditionalCharge = component "Additional Charge Component" "Procesa cargos adicionales validados por Parking Infrastructure u Occupancy & Monitoring." "Spring Boot"
                    paymentOvertime = component "Overtime Billing Component" "Calcula y procesa cobros adicionales por sobretiempo." "Spring Boot"
                    paymentRefund = component "Refund Component" "Gestiona devoluciones de pagos." "Spring Boot"
                    paymentInvoice = component "Billing Document Component" "Registra o anula documentos de facturación asociados a pagos; no los emite ante SUNAT." "Spring Boot"
                    paymentBalance = component "Pending Balance Component" "Gestiona saldos pendientes derivados de pagos fallidos." "Spring Boot"
                    paymentRetry = component "Payment Retry and Reconciliation Component" "Permite reintentos manuales después del tiempo de espera y consulta operaciones cuyo resultado quedó desconocido." "Spring Boot"
                    paymentProviderAdapter = component "Simulated Payment Provider" "Valida referencias sintéticas. Devuelve cargos y reembolsos pendientes y sus resultados al conciliar, sin procesador externo ni movimiento de dinero." "Spring Boot / Internal Adapter"
                    paymentOutcomeListener = component "Simulated Payment Outcome Listener" "Después del commit, resuelve de forma asíncrona resultados simulados de cargos y reembolsos mediante eventos Spring locales." "Spring Boot / Transactional Event Listener"
                }

                // =====================================================
                // BC05 - OCCUPANCY & MONITORING
                // =====================================================

                group "Occupancy & Monitoring" {
                    occupancyService = component "Occupancy & Monitoring Module" "Módulo de Occupancy & Monitoring dentro del monolito modular de SpotGo." "Java / Spring Boot"
                    occupancySensor = component "Sensor Integration Component" "Recibe lecturas reales por REST/HTTPS, comprueba frescura e idempotencia y no acepta placa, driverId ni vehicleId; MQTT requiere un gateway externo." "Spring Boot / REST"
                    occupancyStatus = component "Occupancy Status Component" "Determina el estado de ocupación del Parking Spot." "Spring Boot"
                    occupancyHealth = component "Sensor Health Component" "Controla el estado de conexión y disponibilidad de los sensores." "Spring Boot"
                    occupancyConflict = component "Occupancy Conflict Component" "Detecta conflictos entre ocupación real y reservas." "Spring Boot"
                    occupancyUnauthorized = component "Unauthorized Occupancy Component" "Genera alertas por ocupación sin una expectativa operativa válida." "Spring Boot"
                    occupancyOvertime = component "Overtime Detection Component" "Detecta sobretiempo y solicita un cargo adicional solo con evidencia confiable." "Spring Boot"
                    occupancyAlert = component "Occupancy Alert Component" "Persiste, notifica y permite reconocer alertas; su cierre conserva la clasificación del incidente y la acción registrada por Parking Admin." "Spring Boot / PostgreSQL"
                    occupancyCapacity = component "Capacity Monitoring Component" "Persiste una alerta CRITICAL al superar el 95 por ciento de ocupación y la resuelve al regresar al umbral." "Spring Boot / PostgreSQL"
                    occupancyReport = component "Occupancy Report Component" "Genera reportes operativos para Parking Admin." "Spring Boot"
                    occupancyBillingGateway = component "Payments & Billing Subscription Gateway" "Consulta por contrato interno el límite de sensores y los Parking Spots cubiertos por la suscripción." "Spring Boot / Internal Contract"
                }

            }
            spotgoDatabase = container "SpotGo PostgreSQL Database" "Instancia única de PostgreSQL administrada por Neon; contiene la separación lógica de datos de los cinco bounded contexts." "PostgreSQL" {
                tags "Database"
                group "Identity & Access Management" {
                    identityDb = component "Identity & Access Management Data" "Partición lógica de datos de IAM dentro de la instancia PostgreSQL compartida." "PostgreSQL"
                }
                group "Profiles & Vehicles Management" {
                    profileDb = component "Profiles & Vehicles Management Data" "Partición lógica de datos de perfiles y vehículos dentro de la instancia PostgreSQL compartida." "PostgreSQL"
                }
                group "Parking Infrastructure" {
                    parkingDb = component "Parking Infrastructure Data" "Partición lógica de datos de estacionamientos dentro de la instancia PostgreSQL compartida." "PostgreSQL"
                }
                group "Payments & Billing" {
                    paymentDb = component "Payments & Billing Data" "Partición lógica de datos de pagos y facturación dentro de la instancia PostgreSQL compartida." "PostgreSQL"
                }
                group "Occupancy & Monitoring" {
                    occupancyDb = component "Occupancy & Monitoring Data" "Partición lógica de sensores, lecturas, conflictos, alertas operativas, capacity alerts, snapshots e informes." "PostgreSQL"
                }
            }

            // =====================================================
            // RELACIONES - ACTORES - FRONTENDS
            // =====================================================

            driver -> driverApp "Utiliza la aplicación Android nativa"
            driver -> landingPage "Consulta la propuesta de valor" "HTTPS"
            parkingAdmin -> parkingAdminApp "Utiliza la aplicación Flutter multiplataforma"
            parkingAdmin -> landingPage "Consulta la propuesta de valor" "HTTPS"
            superAdmin -> webApp "Crea cuentas de Parking Admin y otros SuperAdmins, y administra Tenants"

            // =====================================================
            // FRONTENDS - API GATEWAY
            // =====================================================

            driverApp -> apiGateway "Consume APIs" "HTTPS / REST"
            parkingAdminApp -> apiGateway "Consume APIs" "HTTPS / REST"
            webApp -> apiGateway "Consume APIs" "HTTPS / REST"

            // =====================================================
            // API GATEWAY - BOUNDED CONTEXTS
            // =====================================================

            apiGateway -> identityService "Autenticación y autorización" "Invocación interna"
            apiGateway -> profileService "Perfiles y vehículos" "Invocación interna"
            apiGateway -> parkingService "Zonas, espacios y reservas" "Invocación interna"
            apiGateway -> parkingTenantOnboarding "Crea un Tenant con su primer Parking Admin" "Invocación interna"
            apiGateway -> paymentService "Pagos y facturación" "Invocación interna"
            apiGateway -> occupancyService "Disponibilidad y monitoreo" "Invocación interna"
            apiGateway -> pushNotificationService "Registra, consulta y elimina Firebase Installation IDs" "Invocación interna"
            apiGateway -> identityAccountAdministration "Administra cuentas y roles" "Invocación interna"

            // =====================================================
            // MODULOS Y PARTICIONES LOGICAS DE DATOS
            // =====================================================

            identityService -> identityDb "Lee y escribe datos de identidad" "JDBC / SQL"
            profileService -> profileDb "Lee y escribe perfiles y vehículos" "JDBC / SQL"
            parkingService -> parkingDb "Lee y escribe zonas, espacios y reservas" "JDBC / SQL"
            paymentService -> paymentDb "Lee y escribe pagos y facturación" "JDBC / SQL"
            occupancyService -> occupancyDb "Lee y escribe estados y eventos de ocupación" "JDBC / SQL"
            pushNotificationService -> identityDb "Lee cuentas y persiste Firebase Installation IDs" "JPA / SQL"

            // =====================================================
            // COMUNICACIONES ENTRE BOUNDED CONTEXTS
            // =====================================================

            profileService -> identityService "Valida la Account, su rol único y su estado" "Contrato interno"
            identityService -> domainEventDispatcher "Publica registro de Account y cambios de estado o rol" "Evento Spring después del commit"
            profileService -> domainEventDispatcher "Publica cambios de Profile, Vehicle y clasificación" "Evento Spring después del commit"
            parkingService -> identityService "Valida identidad y autorización" "Contrato interno"
            parkingTenantOnboarding -> identityAccountAdministration "Provisiona la cuenta, el rol, el perfil y la invitación inicial" "Contrato interno dentro de la misma transacción"
            identityAccountAdministration -> identityInvitationEmail "Envía el código de configuración de cuenta" "Invocación HTTP"
            parkingService -> profileService "Consulta perfiles y vehículos autorizados" "Contrato interno"
            parkingService -> paymentService "Solicita pagos, cargos y reembolsos" "Contrato interno"
            parkingService -> occupancyService "Consulta ocupación física confiable" "Contrato interno"
            paymentService -> parkingService "Consulta Tenant y Parking Spots para el snapshot de facturación" "Repositorios JPA compartidos"
            occupancyService -> parkingService "Consulta zonas, espacios, reservas y sesiones" "Repositorios JPA compartidos"
            occupancyService -> paymentService "Consulta los límites de sensores de la suscripción" "Contrato interno"

            parkingService -> domainEventDispatcher "Publica reservas y cambios de Parking Sessions" "Evento Spring después del commit"
            domainEventDispatcher -> parkingReassignment "Entrega monitoring.alert.opened para conflictos elegibles" "Spring Application Events after commit"
            parkingReassignment -> domainEventDispatcher "Publica parking.reservation.reassigned" "Spring Application Events after commit"
            paymentService -> domainEventDispatcher "Publica resultados de pagos y cambios de suscripción" "Evento Spring después del commit"
            domainEventDispatcher -> paymentOutcomeListener "Entrega estados pendientes para conciliación simulada" "Spring Application Events after commit"
            paymentOutcomeListener -> paymentProcessing "Aplica el resultado de cargo o reembolso" "Invocación interna asíncrona"
            occupancyService -> domainEventDispatcher "Publica alertas de sensores y conflictos" "Evento Spring después del commit"
            domainEventDispatcher -> pushNotificationService "Entrega eventos a listeners internos" "Spring Application Events"

            // =====================================================
            // SENSORES
            // =====================================================

            parkingSensors -> occupancyService "Entrega lecturas por HTTPS / REST; un gateway externo puede convertir MQTT a HTTP" "HTTPS / REST"

            // =====================================================
            // NOTIFICACIONES
            // =====================================================

            pushNotificationService -> notificationProvider "Envía notificaciones a dispositivos registrados" "HTTPS / Firebase Cloud Messaging"
            identityInvitationEmail -> resendEmail "Envía códigos de configuración y recuperación" "HTTPS / REST"

            // =====================================================
            // MAP TILES AND EXTERNAL NAVIGATION
            // =====================================================

            driverApp -> openStreetMapTiles "Solicita mosaicos cartográficos para renderizar el mapa integrado" "HTTPS / XYZ raster tiles"
            driverApp -> googleMaps "Abre navegación externa hacia la Parking Zone seleccionada" "Android Intent / Deep Link"
            landingPage -> driverApp "Dirige a Driver al acceso móvil" "HTTPS / App Link"
            landingPage -> parkingAdminApp "Dirige a Parking Admin al acceso móvil" "HTTPS / App Link"

            // =====================================================
            // GOOGLE SIGN-IN
            // =====================================================

            driverApp -> googleIdentity "Inicia sesión con Google y obtiene un ID token" "HTTPS / OpenID Connect"
            parkingAdminApp -> googleIdentity "Inicia sesión con Google y obtiene un ID token" "HTTPS / OpenID Connect"
            webApp -> googleIdentity "Inicia sesión con Google y obtiene un ID token" "HTTPS / OpenID Connect"
            identityService -> googleIdentity "Obtiene claves públicas para verificar los ID tokens de Google" "HTTPS / JWKS"

            // =====================================================
            // RELACIONES DE COMPONENTES - BC01
            // =====================================================

            apiGateway -> identityAuthentication "Expone registro e inicio de sesión"
            apiGateway -> identityAuthorization "Autoriza operaciones protegidas"
            identityAuthentication -> identitySession "Crea y valida sesiones"
            identityAuthentication -> identityGoogleAdapter "Solicita la validación del ID token de Google"
            identityGoogleAdapter -> googleIdentity "Obtiene claves públicas para verificar la firma de los ID tokens" "HTTPS / JWKS"
            identitySession -> identityToken "Emite, rota y revoca tokens"
            identitySession -> identityAuthorization "Aplica permisos"
            identityAuthentication -> identityAccount "Consulta cuenta"
            identityAccount -> identityDb "Persistencia"
            identityAuthentication -> identityDb "Consulta credenciales"
            identitySession -> identityDb "Persistencia de sesiones"
            identityToken -> identityDb "Persistencia de tokens y expiración"
            identityAuthorization -> identityDb "Consulta roles"
            identityAuthorization -> identityAudit "Registra autorización y acciones relevantes"
            identityAccount -> identityAudit "Registra cambios de cuenta"
            identityAccountAdministration -> identityAccount "Crea y cambia estados de cuentas"
            identityAccountAdministration -> identityAuthorization "Asigna roles y Tenant scope"
            identityAccountAdministration -> identityInvitationEmail "Solicita la invitación de un solo uso"
            identityAccountAdministration -> profileService "Crea el perfil de Parking Admin"
            identityAccount -> domainEventDispatcher "Publica registro y cambios de estado de Account"
            identityAuthorization -> domainEventDispatcher "Publica cambios de Role Assignment"

            // =====================================================
            // RELACIONES DE COMPONENTES - BC02
            // =====================================================

            apiGateway -> profileDriver "Expone gestión de Driver"
            apiGateway -> profileVehicle "Expone gestión de Vehicle"
            apiGateway -> profileClassification "Expone clasificación del Driver por Tenant"
            profileDriver -> profileVehicle "Gestiona vehículos del Driver"
            profileDriver -> identityAccount "Valida la Account dentro del monolito"
            profileClassification -> identityAccount "Consulta Account y Role Assignment dentro del monolito"
            profileClassification -> parkingTenant "Valida el Tenant dentro del monolito"
            profileDriver -> domainEventDispatcher "Publica cambios del Profile"
            profileVehicle -> domainEventDispatcher "Publica registro, actualización o baja del Vehicle"
            profileClassification -> domainEventDispatcher "Publica asignaciones de clasificación por Tenant"
            profileDriver -> profileDb "Persistencia"
            profileVehicle -> profileDb "Persistencia"
            profileClassification -> profileDb "Persistencia"

            // =====================================================
            // RELACIONES DE COMPONENTES - BC03
            // =====================================================

            apiGateway -> parkingTenant "Expone la gestión de la empresa y las reglas del estacionamiento"
            apiGateway -> parkingTenantOnboarding "Expone el alta atómica de Tenant y administrador inicial"
            parkingTenantOnboarding -> parkingTenant "Crea el Tenant"
            parkingTenantOnboarding -> identityAccountAdministration "Provisiona cuenta, rol, perfil e invitación"
            apiGateway -> parkingZone "Expone gestión de Parking Zones"
            apiGateway -> parkingReservation "Expone gestión de Reservations"
            apiGateway -> parkingReservationChange "Expone reprogramación, extensión e historial de cambios"
            apiGateway -> parkingFavorites "Expone gestión de favoritos del Driver"
            apiGateway -> parkingGuest "Expone gestión de Guest Parking Sessions"
            apiGateway -> parkingSession "Expone el ingreso y salida de Parking Sessions"
            parkingTenant -> parkingZone "Organiza las zonas del estacionamiento que representa"
            parkingZone -> parkingSpot "Contiene espacios"
            parkingReservation -> profileClassification "Comprueba la clasificación permitida antes de reservar"
            parkingSpot -> parkingAvailability "Proporciona disponibilidad"
            parkingReservation -> parkingAllocation "Solicita asignación"
            parkingAllocation -> parkingAvailability "Consulta disponibilidad"
            parkingAllocation -> parkingSpot "Asigna espacio"
            parkingReservation -> parkingTenant "Aplica las reglas del estacionamiento guardadas en rules JSONB"
            parkingReservation -> parkingZone "Valida zona"
            parkingReservation -> parkingSpot "Reserva espacio"
            parkingReservation -> domainEventDispatcher "Publica creación, confirmación y cancelación de Reservation"
            parkingSession -> domainEventDispatcher "Publica inicio y cierre de Parking Session"
            parkingGuest -> parkingAvailability "Selecciona un spot disponible"
            parkingGuest -> parkingSpot "Asigna el spot al Guest"
            parkingReservationChange -> parkingReservation "Registra cambios asociados a Reservation"
            parkingReservationChange -> parkingPaymentAdapter "Solicita pago simulado o reembolso"
            parkingIdentityAdapter -> identityService "Valida rol y alcance"
            parkingProfileAdapter -> profileService "Consulta Driver, Vehicle y User Profile"
            parkingPaymentAdapter -> paymentService "Solicita pago o reembolso"
            parkingOccupancyAdapter -> occupancyService "Consulta ocupación física confiable"
            parkingReservation -> parkingDb "Persistencia"
            parkingReservationChange -> parkingDb "Persiste reservation_changes"
            parkingFavorites -> parkingDb "Persiste favorite_tenants"
            parkingTenant -> parkingDb "Persiste la empresa y rules JSONB"
            parkingZone -> parkingDb "Persistencia"
            parkingSpot -> parkingDb "Persistencia"
            parkingAllocation -> parkingDb "Persistencia"
            parkingAvailability -> parkingDb "Persistencia"
            parkingGuest -> parkingDb "Persistencia de Guest Parking Session"

            // =====================================================
            // RELACIONES DE COMPONENTES - BC04
            // =====================================================

            apiGateway -> paymentProcessing "Expone pagos digitales"
            apiGateway -> paymentToken "Expone gestión de Payment Tokens"
            apiGateway -> paymentSubscription "Expone gestión de Subscriptions"
            apiGateway -> paymentRefund "Expone reembolsos autorizados"
            paymentProcessing -> paymentToken "Utiliza Payment Token"
            paymentProcessing -> paymentSubscription "Aplica beneficios"
            paymentProcessing -> paymentInvoice "Genera comprobante"
            paymentProcessing -> paymentBalance "Gestiona resultado"
            paymentProcessing -> paymentProviderAdapter "Envía operación con idempotencia"
            paymentProcessing -> domainEventDispatcher "Publica resultados de pagos y suscripciones"
            domainEventDispatcher -> paymentOutcomeListener "Entrega resultados pendientes después del commit"
            paymentOutcomeListener -> paymentProcessing "Concilia el resultado simulado"
            paymentRetry -> paymentProcessing "Coordina intentos y conciliaciones"
            paymentRetry -> paymentProviderAdapter "Reintenta errores transitorios"
            paymentAdditionalCharge -> paymentProcessing "Solicita procesamiento del cargo"
            paymentOvertime -> paymentSubscription "Mantiene multas y sobretiempo separados del descuento de reserva"
            paymentOvertime -> paymentAdditionalCharge "Calcula cargo adicional"
            paymentRefund -> paymentProviderAdapter "Solicita devolución"
            paymentProcessing -> paymentDb "Persistencia"
            paymentToken -> paymentDb "Persistencia"
            paymentSubscription -> paymentDb "Persistencia"
            paymentAdditionalCharge -> paymentDb "Persistencia"
            paymentOvertime -> paymentDb "Persistencia"
            paymentRefund -> paymentDb "Persistencia"
            paymentInvoice -> paymentDb "Persistencia"
            paymentBalance -> paymentDb "Persistencia"
            paymentRetry -> paymentDb "Persiste intentos y conciliaciones"

            // =====================================================
            // RELACIONES DE COMPONENTES - BC05
            // =====================================================

            apiGateway -> occupancyReport "Expone reportes operativos"
            apiGateway -> occupancyAlert "Expone gestión de alertas"
            occupancyService -> occupancyBillingGateway "Consulta cobertura de suscripción y límite de sensores"
            occupancyBillingGateway -> paymentService "Consulta plan y spots incluidos"
            parkingSensors -> occupancySensor "Envía lecturas sin identidad del vehículo; el backend recibe HTTPS / REST" "HTTPS / REST via external IoT gateway"
            occupancySensor -> occupancyStatus "Actualiza ocupación"
            occupancySensor -> occupancyHealth "Actualiza salud del sensor"
            occupancyStatus -> occupancyConflict "Compara con reservas"
            occupancyConflict -> occupancyUnauthorized "Clasifica ocupación no autorizada"
            occupancyConflict -> occupancyAlert "Genera alerta"
            occupancyStatus -> occupancyOvertime "Evalúa sobretiempo"
            occupancyStatus -> occupancyCapacity "Calcula High Capacity"
            occupancyStatus -> occupancyReport "Proporciona datos para reportes"
            occupancyUnauthorized -> occupancyAlert "Genera alerta para Parking Admin"
            occupancyOvertime -> occupancyAlert "Genera señal operativa"
            occupancyAlert -> domainEventDispatcher "Publica alertas nuevas de sensores y conflictos"
            occupancySensor -> occupancyDb "Persistencia"
            occupancyStatus -> occupancyDb "Persistencia"
            occupancyHealth -> occupancyDb "Persistencia"
            occupancyConflict -> occupancyDb "Persistencia"
            occupancyUnauthorized -> occupancyDb "Persistencia"
            occupancyOvertime -> occupancyDb "Persistencia"
            occupancyCapacity -> occupancyDb "Persistencia"
            occupancyReport -> occupancyDb "Persistencia"

            // =====================================================
            // RELACIONES DE COMPONENTES - OTROS BOUNDED CONTEXTS
            // =====================================================

            parkingReservation -> parkingIdentityAdapter "Valida autorización"
            parkingReservation -> parkingProfileAdapter "Consulta Driver y Vehicle"
            parkingReservation -> parkingPaymentAdapter "Solicita pago"
            parkingAllocation -> parkingOccupancyAdapter "Consulta estado de ocupación"
            occupancyConflict -> parkingAllocation "Solicita reasignación"
        }

        // =========================================================
        // DEPLOYMENT ENVIRONMENT
        // =========================================================

        production = deploymentEnvironment "Production" {

            // -----------------------------------------------------
            // DISPOSITIVOS CLIENTE
            // -----------------------------------------------------
            deploymentNode "Driver Device" "Dispositivo Android que ejecuta la aplicación nativa de Driver" "Android" {
                containerInstance driverApp
            }

            deploymentNode "Parking Admin Device" "Dispositivo móvil que ejecuta la aplicación multiplataforma de Parking Admin" "Android / iOS" {
                containerInstance parkingAdminApp
            }

            deploymentNode "SuperAdmin Device" "Navegador utilizado por SuperAdmin para provisionar cuentas Parking Admin y SuperAdmin, y administrar Tenants" "Web Browser" {
            }

            // -----------------------------------------------------
            // SERVICIOS DE RENDER
            // -----------------------------------------------------
            deploymentNode "Render Cloud Platform" "Plataforma de alojamiento del Backend Web Service y de la aplicación web administrativa estática" "Render" {

                deploymentNode "Backend Web Service" "Instancia única del monolito modular de SpotGo" "Docker / Java 25 LTS / Spring Boot" {
                    containerInstance backend
                }

                deploymentNode "SpotGo Administration Web App Static Site" "Aplicación administrativa exclusiva de SuperAdmin" "Angular / TypeScript / Angular Material" {
                    containerInstance webApp
                }
            }

            // -----------------------------------------------------
            // BASE DE DATOS EN NEON
            // -----------------------------------------------------
            deploymentNode "Neon Database Infrastructure" "Instancia PostgreSQL única administrada en Neon" "Neon / PostgreSQL" {
                containerInstance spotgoDatabase
            }

            deploymentNode "GitHub Pages" "Hosting independiente de la Landing Page estática" "Static Web Hosting / HTTPS" {
                containerInstance landingPage
            }

            // -----------------------------------------------------
            // INFRAESTRUCTURA DEL ESTACIONAMIENTO
            // -----------------------------------------------------
            deploymentNode "Parking Infrastructure" "Infraestructura física del estacionamiento" "IoT Environment" {
                deploymentNode "IoT Sensor Network" "Sensores físicos que publican lecturas hacia el Backend por HTTPS / REST. Un despliegue MQTT requiere un gateway externo que convierta el protocolo." "HTTPS / REST; MQTT via external gateway" {
                    softwareSystemInstance parkingSensors
                }
            }

            // -----------------------------------------------------
            // SERVICIOS EXTERNOS
            // -----------------------------------------------------
            deploymentNode "External Services" "Servicios externos utilizados por SpotGo" "Internet" {
                softwareSystemInstance googleIdentity
                softwareSystemInstance googleMaps
                softwareSystemInstance openStreetMapTiles
                softwareSystemInstance notificationProvider
            }
        }
    }


    // =============================================================
    // VIEWS
    // =============================================================

    views {

        // =========================================================
        // 1. SOFTWARE ARCHITECTURE CONTEXT LEVEL DIAGRAM
        // =========================================================

        systemContext spotgo "Context_Level_Diagram" {
            include *
            autoLayout lr
            title "SpotGo - Software Architecture Context Level Diagram"
            description "Nivel 1 - Contexto del sistema SpotGo."
        }

        // =========================================================
        // 2. SOFTWARE ARCHITECTURE CONTAINER LEVEL DIAGRAM
        // =========================================================

        container spotgo "Container_Level_Diagram" {
            include *
            autoLayout lr
            title "SpotGo - Software Architecture Container Level Diagram"
            description "Nivel 2 - Contenedores, tecnologías y comunicaciones principales de SpotGo."
        }

        // =========================================================
        // 3. COMPONENT DIAGRAM - IDENTIDAD

        component backend "Identity_Components_Diagram" {
            include "element.group==Identity & Access Management" "element.group==Backend API" profileService spotgoDatabase driverApp parkingAdminApp webApp googleIdentity notificationProvider
            autoLayout lr
            title "SpotGo - Components Diagram - Identity & Access Management"
            description "Módulo de Identity & Access Management dentro del monolito modular y su partición lógica de datos."
        }

        // 4. COMPONENT DIAGRAM - PERFILES

        component backend "Profiles_Components_Diagram" {
            include "element.group==Profiles & Vehicles Management" "element.group==Backend API" identityService parkingService spotgoDatabase driverApp parkingAdminApp webApp googleIdentity notificationProvider
            autoLayout lr
            title "SpotGo - Components Diagram - Profiles & Vehicles Management"
            description "Módulo de Profiles & Vehicles Management dentro del monolito modular y su partición lógica de datos."
        }

        // 5. COMPONENT DIAGRAM - INFRAESTRUCTURA

        component backend "Parking_Components_Diagram" {
            include "element.group==Parking Infrastructure" "element.group==Backend API" identityService profileService paymentService occupancyService spotgoDatabase driverApp parkingAdminApp webApp googleMaps openStreetMapTiles notificationProvider
            autoLayout lr
            title "SpotGo - Components Diagram - Parking Infrastructure"
            description "Módulo de Parking Infrastructure dentro del monolito modular y su partición lógica de datos."
        }

        // 6. COMPONENT DIAGRAM - PAGOS

        component backend "Payments_Components_Diagram" {
            include "element.group==Payments & Billing" "element.group==Backend API" parkingService occupancyService spotgoDatabase driverApp parkingAdminApp webApp notificationProvider
            autoLayout lr
            title "SpotGo - Components Diagram - Payments & Billing"
            description "Módulo de Payments & Billing dentro del monolito modular y su partición lógica de datos."
        }

        // 7. COMPONENT DIAGRAM - OCUPACIÓN

        component backend "Occupancy_Components_Diagram" {
            include "element.group==Occupancy & Monitoring" "element.group==Backend API" parkingService paymentService spotgoDatabase driverApp parkingAdminApp webApp parkingSensors notificationProvider
            autoLayout lr
            title "SpotGo - Components Diagram - Occupancy & Monitoring"
            description "Módulo de Occupancy & Monitoring dentro del monolito modular y su partición lógica de datos."
        }

        // 8. SOFTWARE ARCHITECTURE DEPLOYMENT DIAGRAM
        // =========================================================

        deployment spotgo "Production" "Deployment_Diagram" {
            include *
            autoLayout lr
            title "SpotGo - Software Architecture Deployment Diagram"
            description "Despliegue de una única instancia del Backend modular en Render y una instancia PostgreSQL en Neon, junto con clientes, infraestructura IoT y servicios externos."
        }


        // =========================================================
        // STYLES
        // =========================================================

        styles {
            element "Person" {
                shape person
                background #08427b
                color #ffffff
            }
            element "Software System" {
                shape roundedbox
                background #1168bd
                color #ffffff
            }
            element "External System" {
                background #999999
                color #ffffff
            }
            element "Container" {
                shape roundedbox
                background #438dd5
                color #ffffff
            }
            element "Component" {
                shape roundedbox
                background #85bbf0
                color #000000
            }
            element "Database" {
                shape cylinder
                background #2e8b57
                color #ffffff
            }
            element "Deployment Node" {
                shape roundedbox
                color #000000
                stroke #888888
            }
        }
    }
}
