workspace "SpotGo - Software Architecture" "Arquitectura de Software de SpotGo basada en C4 Model y DDD" {

    model {

        // =========================================================
        // ACTORES
        // =========================================================

        driver = person "Driver" "Conductor que consulta disponibilidad, registra vehículos, reserva y realiza pagos."

        parkingAdmin = person "Parking Admin" "Administra la operación del estacionamiento mediante sus vistas administrativas."

        superAdmin = person "SuperAdmin" "Crea y administra Tenants y provisiona las cuentas de Parking Admin."


        // =========================================================
        // SISTEMAS EXTERNOS
        // =========================================================

        googleIdentity = softwareSystem "Google Identity / Google Sign-In" "Proveedor externo de identidad que autentica al usuario y emite un ID token; SpotGo valida ese token y administra su propia sesión y roles." {
            tags "External System"
        }

        googleMaps = softwareSystem "Google Maps" "Servicio externo utilizado para abrir rutas hacia la Parking Zone seleccionada." {
            tags "External System"
        }

        notificationProvider = softwareSystem "Firebase Cloud Messaging" "Servicio externo de Google utilizado para enviar notificaciones push a los usuarios." {
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

            driverApp = container "SpotGo Driver Android App" "Aplicación Android nativa exclusiva para Driver, desarrollada con Kotlin y Jetpack Compose. Permite iniciar sesión y crear una cuenta." "Kotlin / Jetpack Compose"

            parkingAdminApp = container "SpotGo Parking Admin Flutter App" "Aplicación móvil multiplataforma exclusiva para Parking Admin, desarrollada con Flutter y Dart. Permite iniciar sesión con una cuenta provisionada y no ofrece registro público." "Flutter / Dart"


            landingPage = container "SpotGo Landing Page" "Sitio estático que presenta la propuesta de valor y dirige a cada perfil al canal de SpotGo que le corresponde; alojado en GitHub Pages." "HTML / CSS / Vanilla JS"

            webApp = container "SpotGo Administration Web App" "Aplicación web exclusiva para SuperAdmin, desarrollada con Angular, TypeScript y Angular Material." "Angular / TypeScript / Angular Material"

            backend = container "SpotGo Backend" "Única aplicación de backend de SpotGo, implementada como un monolito modular con cinco bounded contexts." "Java 25 LTS / Spring Boot / Docker" {
                group "Backend API" {
                    apiGateway = component "API Gateway" "Punto de entrada REST del Backend que dirige las solicitudes a los módulos internos." "Spring Boot"
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
                    identityAudit = component "Audit Log Component" "Registra autenticaciones, autorizaciones, cambios de cuenta y acciones administrativas relevantes." "Spring Boot"
                    identityEventPublisher = component "Identity Event Publisher" "Publica cambios de identidad, roles, suspensión y revocación sin exponer secretos ni tokens." "Spring Boot / Domain Events"
                }

                // =====================================================
                // BC02 - PROFILES & VEHICLES MANAGEMENT
                // =====================================================

                group "Profiles & Vehicles Management" {
                    profileService = component "Profiles & Vehicles Management Module" "Módulo de Profiles & Vehicles Management dentro del monolito modular de SpotGo." "Java / Spring Boot"
                    profileDriver = component "Driver Profile Component" "Gestiona la información del conductor." "Spring Boot"
                    profileVehicle = component "Vehicle Component" "Registra y administra Vehicles asociados al Driver, incluida la placa registrada." "Spring Boot"
                    profileRole = component "User Profile Component" "Gestiona User Profiles de tipo Driver y Parking Admin; no gestiona Guests ni credenciales." "Spring Boot"
                    profileParkingAdminAssignment = component "Parking Admin Assignment Component" "Gestiona la asignación de Parking Admin a un Tenant mediante referencias externas." "Spring Boot"
                    profileIdentityAdapter = component "Identity & Access Management Adapter (Profiles)" "Consulta y valida identidad, rol y estado de cuenta mediante el contrato de IAM." "Spring Boot / Internal Contract"
                    profileEventPublisher = component "Profile Event Publisher" "Publica cambios validados de Driver, Vehicle y Parking Admin Assignment." "Spring Boot / Domain Events"
                }

                // =====================================================
                // BC03 - PARKING INFRASTRUCTURE
                // =====================================================

                group "Parking Infrastructure" {
                    parkingService = component "Parking Infrastructure Module" "Módulo de Parking Infrastructure dentro del monolito modular de SpotGo." "Java / Spring Boot"
                    parkingZone = component "Parking Zone Component" "Gestiona las zonas del estacionamiento y sus reglas." "Spring Boot"
                    parkingSpot = component "Parking Spot Component" "Gestiona los espacios y su disponibilidad." "Spring Boot"
                    parkingReservation = component "Reservation Component" "Gestiona el ciclo de vida de las reservas." "Spring Boot"
                    parkingAllocation = component "Spot Allocation Component" "Asigna, reasigna y aplica un Temporary Lock de 10 minutos durante el proceso de pago." "Spring Boot"
                    parkingAvailability = component "Availability Component" "Calcula la disponibilidad actual de las zonas y espacios." "Spring Boot"
                    parkingGuest = component "Guest Parking Session Component" "Registra manualmente la placa, el ingreso, la salida y el pago físico de una Guest Parking Session; no crea una Reservation." "Spring Boot"
                    parkingNavigation = component "Navigation Component" "Genera una ruta hacia la Parking Zone seleccionada mediante Google Maps." "Spring Boot"
                    parkingIdentityAdapter = component "Identity & Access Management Adapter (Parking)" "Valida el rol y el alcance del actor antes de ejecutar operaciones protegidas." "Spring Boot / Internal Contract"
                    parkingProfileAdapter = component "Profiles & Vehicles Management Adapter" "Consulta Driver, Vehicle y User Profile mediante el contrato interno, sin acceder directamente a las tablas de otro bounded context." "Spring Boot / Internal Contract"
                    parkingPaymentAdapter = component "Payments & Billing Adapter (Parking Infrastructure)" "Solicita pagos, cargos adicionales y reembolsos mediante contratos del contexto de pagos." "Spring Boot / Internal Contract / Domain Events"
                    parkingOccupancyAdapter = component "Occupancy & Monitoring Adapter" "Consulta el estado físico y recibe conflictos o fallas de ocupación." "Spring Boot / Domain Events"
                }

                // =====================================================
                // BC04 - PAYMENTS & BILLING
                // =====================================================

                group "Payments & Billing" {
                    paymentService = component "Payments & Billing Module" "Módulo de Payments & Billing dentro del monolito modular de SpotGo." "Java / Spring Boot"
                    internalPaymentSystem = component "Internal Payment System" "Sistema interno de SpotGo que procesa pagos digitales, consultas de estado y reembolsos con idempotencia dentro del Backend." "Spring Boot"
                    paymentProcessing = component "Payment Processing Component" "Procesa pagos digitales utilizando métodos tokenizados." "Spring Boot"
                    paymentToken = component "Payment Token Component" "Gestiona tokens asociados a los métodos de pago." "Spring Boot"
                    paymentSubscription = component "Subscription Component" "Gestiona planes Free, Plus Monthly y Plus Annual." "Spring Boot"
                    paymentAdditionalCharge = component "Additional Charge Component" "Procesa cargos adicionales validados por Parking Infrastructure u Occupancy & Monitoring." "Spring Boot"
                    paymentOvertime = component "Overtime Billing Component" "Calcula y procesa cobros adicionales por sobretiempo." "Spring Boot"
                    paymentRefund = component "Refund Component" "Gestiona devoluciones de pagos." "Spring Boot"
                    paymentInvoice = component "Invoice and Receipt Component" "Genera y consulta Electronic Receipt o Electronic Invoice según la información de facturación." "Spring Boot"
                    paymentBalance = component "Pending Balance Component" "Gestiona saldos pendientes derivados de pagos fallidos." "Spring Boot"
                    paymentRetry = component "Payment Retry Component" "Programa hasta 4 intentos en 10 minutos para Reservations y conciliaciones según la Retry Policy." "Spring Boot / Scheduler"
                    paymentProviderAdapter = component "Internal Payment System Adapter" "Traduce el contrato de Payments & Billing al sistema de pagos internos." "Spring Boot / Internal Contract"
                    paymentEventPublisher = component "Payment Event Publisher" "Publica resultados de pagos, reembolsos, cargos, saldos y documentos." "Spring Boot / Domain Events"
                }

                // =====================================================
                // BC05 - OCCUPANCY & MONITORING
                // =====================================================

                group "Occupancy & Monitoring" {
                    occupancyService = component "Occupancy & Monitoring Module" "Módulo de Occupancy & Monitoring dentro del monolito modular de SpotGo." "Java / Spring Boot"
                    occupancySensor = component "Sensor Integration Component" "Recibe y normaliza lecturas físicas; los sensores no envían placa, driverId ni vehicleId." "Spring Boot / MQTT / HTTP"
                    occupancyStatus = component "Occupancy Status Component" "Determina el estado de ocupación del Parking Spot." "Spring Boot"
                    occupancyHealth = component "Sensor Health Component" "Controla el estado de conexión y disponibilidad de los sensores." "Spring Boot"
                    occupancyConflict = component "Occupancy Conflict Component" "Detecta conflictos entre ocupación real y reservas." "Spring Boot"
                    occupancyUnauthorized = component "Unauthorized Occupancy Component" "Genera alertas por ocupación sin una expectativa operativa válida." "Spring Boot"
                    occupancyOvertime = component "Overtime Detection Component" "Detecta sobretiempo y solicita un cargo adicional solo con evidencia confiable." "Spring Boot"
                    occupancyAlert = component "Occupancy Alert Component" "Genera eventos y alertas operativas." "Spring Boot"
                    occupancyCapacity = component "Capacity Monitoring Component" "Calcula High Capacity cuando la ocupación supera el 95 por ciento." "Spring Boot"
                    occupancyReport = component "Occupancy Report Component" "Genera reportes operativos para Parking Admin." "Spring Boot"
                    occupancyParkingAdapter = component "Parking Infrastructure Adapter" "Consume expectativas y publica estados, conflictos y fallas hacia Parking Infrastructure." "Spring Boot / Domain Events"
                    occupancyPaymentAdapter = component "Payments & Billing Adapter (Occupancy & Monitoring)" "Publica AdditionalChargeRequested cuando existe evidencia suficiente." "Spring Boot / Domain Events"
                    occupancyFcmAdapter = component "FCM Notification Adapter" "Envía alertas y reportes operativos mediante Firebase Cloud Messaging." "Spring Boot / FCM"
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
                    occupancyDb = component "Occupancy & Monitoring Data" "Partición lógica de datos de ocupación dentro de la instancia PostgreSQL compartida." "PostgreSQL"
                }
            }

            // =====================================================
            // RELACIONES - ACTORES - FRONTENDS
            // =====================================================

            driver -> driverApp "Utiliza la aplicación Android nativa"
            driver -> landingPage "Consulta la propuesta de valor" "HTTPS"
            parkingAdmin -> parkingAdminApp "Utiliza la aplicación Flutter multiplataforma"
            parkingAdmin -> landingPage "Consulta la propuesta de valor" "HTTPS"
            superAdmin -> webApp "Provisiona Parking Admin y administra Tenants"

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
            apiGateway -> paymentService "Pagos y facturación" "Invocación interna"
            apiGateway -> occupancyService "Disponibilidad y monitoreo" "Invocación interna"

            // =====================================================
            // MODULOS Y PARTICIONES LOGICAS DE DATOS
            // =====================================================

            identityService -> identityDb "Lee y escribe datos de identidad" "JDBC / SQL"
            profileService -> profileDb "Lee y escribe perfiles y vehículos" "JDBC / SQL"
            parkingService -> parkingDb "Lee y escribe zonas, espacios y reservas" "JDBC / SQL"
            paymentService -> paymentDb "Lee y escribe pagos y facturación" "JDBC / SQL"
            occupancyService -> occupancyDb "Lee y escribe estados y eventos de ocupación" "JDBC / SQL"
            paymentService -> internalPaymentSystem "Coordina el procesamiento interno de pagos" "Llamada interna"

            // =====================================================
            // COMUNICACIONES ENTRE BOUNDED CONTEXTS
            // =====================================================

            profileService -> identityService "Valida la referencia de identidad y el rol" "Contrato interno"
            identityService -> profileService "Publica cambios de identidad, roles y provisión" "Evento de dominio"
            parkingService -> identityService "Valida identidad y autorización" "Contrato interno"
            parkingService -> profileService "Consulta perfiles y vehículos autorizados" "Contrato interno"
            profileService -> parkingService "Publica Driver y Vehicle validados" "Evento de dominio"
            parkingService -> paymentService "Solicita pagos, cargos y reembolsos" "Contrato interno / eventos de dominio"
            paymentService -> parkingService "Publica resultados de pagos y reembolsos" "Eventos de dominio"
            parkingService -> occupancyService "Publica Reservation, Reassignment y Parking Session expectations" "Eventos de dominio"
            occupancyService -> parkingService "Notifica ocupación, fallas y conflictos" "Eventos de dominio"
            occupancyService -> paymentService "Solicita cargos adicionales con evidencia" "Contrato interno / eventos de dominio"

            // =====================================================
            // SENSORES
            // =====================================================

            parkingSensors -> occupancyService "Entrega lecturas al módulo Occupancy & Monitoring" "MQTT / HTTP"

            // =====================================================
            // NOTIFICACIONES
            // =====================================================

            identityService -> notificationProvider "Envía notificaciones de cuenta y acceso" "HTTPS / FCM"
            parkingService -> notificationProvider "Envía alertas de reservas y reasignaciones" "HTTPS / FCM"
            paymentService -> notificationProvider "Envía confirmaciones, fallos, reembolsos y saldos pendientes" "HTTPS / FCM"
            occupancyService -> notificationProvider "Envía alertas de ocupación y sobretiempo" "HTTPS / FCM"

            // =====================================================
            // GOOGLE MAPS
            // =====================================================

            driverApp -> googleMaps "Abre ruta hacia la Parking Zone seleccionada" "Google Maps SDK / Deep Link"
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
            identityAccount -> identityEventPublisher "Publica cambios de cuenta"
            identityAuthorization -> identityEventPublisher "Publica cambios de rol y acceso"
            identityEventPublisher -> profileRole "Sincroniza rol y provisión de perfil"

            // =====================================================
            // RELACIONES DE COMPONENTES - BC02
            // =====================================================

            apiGateway -> profileDriver "Expone gestión de Driver"
            apiGateway -> profileVehicle "Expone gestión de Vehicle"
            apiGateway -> profileRole "Expone gestión de User Profile"
            apiGateway -> profileParkingAdminAssignment "Expone asignación de Parking Admin"
            profileDriver -> profileVehicle "Gestiona vehículos del Driver"
            profileDriver -> profileRole "Consulta User Profile"
            profileRole -> profileParkingAdminAssignment "Gestiona asignación de Parking Admin a Tenant"
            profileIdentityAdapter -> identityService "Consulta identidad y rol"
            profileDriver -> profileEventPublisher "Publica cambios del Driver"
            profileVehicle -> profileEventPublisher "Publica registro o baja del Vehicle"
            profileParkingAdminAssignment -> profileEventPublisher "Publica cambios de asignación"
            profileEventPublisher -> parkingService "Publica datos validados de Driver y Vehicle"
            profileDriver -> profileDb "Persistencia"
            profileVehicle -> profileDb "Persistencia"
            profileRole -> profileDb "Persistencia"
            profileParkingAdminAssignment -> profileDb "Persistencia"

            // =====================================================
            // RELACIONES DE COMPONENTES - BC03
            // =====================================================

            apiGateway -> parkingZone "Expone gestión de Parking Zones"
            apiGateway -> parkingReservation "Expone gestión de Reservations"
            apiGateway -> parkingGuest "Expone gestión de Guest Parking Sessions"
            parkingZone -> parkingSpot "Contiene espacios"
            parkingSpot -> parkingAvailability "Proporciona disponibilidad"
            parkingReservation -> parkingAllocation "Solicita asignación"
            parkingAllocation -> parkingAvailability "Consulta disponibilidad"
            parkingAllocation -> parkingSpot "Asigna espacio"
            parkingReservation -> parkingZone "Valida zona"
            parkingReservation -> parkingSpot "Reserva espacio"
            parkingGuest -> parkingAvailability "Selecciona un spot disponible"
            parkingGuest -> parkingSpot "Asigna el spot al Guest"
            parkingNavigation -> parkingZone "Obtiene la Parking Zone seleccionada"
            parkingNavigation -> googleMaps "Abre ruta hacia la Parking Zone" "Google Maps SDK / Deep Link"
            parkingIdentityAdapter -> identityService "Valida rol y alcance"
            parkingProfileAdapter -> profileService "Consulta Driver, Vehicle y User Profile"
            parkingPaymentAdapter -> paymentService "Solicita pago o reembolso"
            parkingOccupancyAdapter -> occupancyService "Consulta ocupación y recibe conflictos"
            parkingReservation -> parkingDb "Persistencia"
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
            paymentProcessing -> paymentEventPublisher "Publica resultado económico"
            paymentRetry -> paymentProcessing "Coordina intentos y conciliaciones"
            paymentRetry -> paymentProviderAdapter "Reintenta errores transitorios"
            paymentProviderAdapter -> internalPaymentSystem "Procesa operación mediante contrato interno" "HTTPS / REST"
            paymentAdditionalCharge -> paymentProcessing "Solicita procesamiento del cargo"
            paymentOvertime -> paymentSubscription "Aplica descuento de suscripción"
            paymentOvertime -> paymentAdditionalCharge "Calcula cargo adicional"
            paymentRefund -> paymentProviderAdapter "Solicita devolución"
            paymentRefund -> paymentEventPublisher "Publica resultado del reembolso"
            paymentBalance -> paymentEventPublisher "Publica cambios de saldo"
            paymentInvoice -> paymentEventPublisher "Publica documento emitido"
            paymentEventPublisher -> parkingService "Publica aprobación, rechazo o reembolso"
            paymentEventPublisher -> occupancyService "Publica resultado de cargo adicional"
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
            parkingSensors -> occupancySensor "Envía lecturas sin identidad del vehículo" "MQTT / HTTP"
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
            occupancyOvertime -> occupancyPaymentAdapter "Solicita cargo con evidencia"
            occupancyParkingAdapter -> parkingService "Publica estados, conflictos y fallas"
            occupancyPaymentAdapter -> paymentService "Publica AdditionalChargeRequested"
            occupancyAlert -> occupancyFcmAdapter "Envía notificación"
            occupancyFcmAdapter -> notificationProvider "Envía alerta mediante FCM" "HTTPS / FCM"
            parkingService -> occupancyParkingAdapter "Entrega Reservation, Reassignment y Parking Session expectations"
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
            occupancyConflict -> occupancyParkingAdapter "Notifica conflicto"
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

            deploymentNode "SuperAdmin Device" "Navegador utilizado por SuperAdmin para provisionar Parking Admin y administrar Tenants" "Web Browser" {
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
                deploymentNode "IoT Sensor Network" "Red de sensores físicos instalados en los Parking Spots" "MQTT / HTTP" {
                    softwareSystemInstance parkingSensors
                }
            }

            // -----------------------------------------------------
            // SERVICIOS EXTERNOS
            // -----------------------------------------------------
            deploymentNode "External Services" "Servicios externos utilizados por SpotGo" "Internet" {
                softwareSystemInstance googleIdentity
                softwareSystemInstance googleMaps
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

        component backend "Profile_Components_Diagram" {
            include "element.group==Profiles & Vehicles Management" "element.group==Backend API" identityService parkingService spotgoDatabase driverApp parkingAdminApp webApp googleIdentity notificationProvider
            autoLayout lr
            title "SpotGo - Components Diagram - Profiles & Vehicles Management"
            description "Módulo de Profiles & Vehicles Management dentro del monolito modular y su partición lógica de datos."
        }

        // 5. COMPONENT DIAGRAM - INFRAESTRUCTURA

        component backend "Parking_Components_Diagram" {
            include "element.group==Parking Infrastructure" "element.group==Backend API" identityService profileService paymentService occupancyService spotgoDatabase driverApp parkingAdminApp webApp googleMaps notificationProvider
            autoLayout lr
            title "SpotGo - Components Diagram - Parking Infrastructure"
            description "Módulo de Parking Infrastructure dentro del monolito modular y su partición lógica de datos."
        }

        // 6. COMPONENT DIAGRAM - PAGOS

        component backend "Payment_Components_Diagram" {
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
