workspace "SpotGo - Software Architecture" "Arquitectura de Software de SpotGo basada en C4 Model y DDD" {

    model {

        // =========================================================
        // ACTORES
        // =========================================================

        driver = person "Driver" "Conductor que consulta disponibilidad, registra vehículos, reserva y realiza pagos."

        staff = person "Staff" "Administra la operación del estacionamiento mediante sus vistas administrativas."

        superAdmin = person "SuperAdmin" "Crea y administra Tenants y provisiona las cuentas de Staff."


        // =========================================================
        // SISTEMAS EXTERNOS
        // =========================================================

        googleMaps = softwareSystem "Google Maps" "Servicio externo utilizado para abrir rutas hacia la Parking Zone seleccionada." {
            tags "External System"
        }

        googleAuthentication = softwareSystem "Google Authentication" "Servicio externo utilizado para validar la identidad de un Driver durante el registro o el inicio de sesión." {
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

            mobileApp = container "SpotGo Mobile App" "Aplicación móvil multiplataforma para Drivers y Staff." "Flutter / Kotlin (Android nativo)"

            webApp = container "SpotGo Web App" "Landing Page y aplicación web administrativa para Staff y SuperAdmin." "Angular"

            apiGateway = container "API Gateway" "Punto único de entrada que enruta las solicitudes hacia los microservicios." "Spring Boot / API Gateway"

            internalPaymentProvider = container "Internal Payment Provider" "Servicio interno de SpotGo que procesa pagos digitales, consultas de estado, reembolsos e idempotencia." "Java / Spring Boot / REST"


            // =====================================================
            // BC01 - IDENTITY & ACCESS MANAGEMENT
            // =====================================================

            identityService = container "Identity & Access Management" "Autentica usuarios, gestiona credenciales y sesiones y autoriza el acceso según roles." "Java / Spring Boot / REST" {
                identityAuthentication = component "Authentication Component" "Valida las credenciales de los usuarios." "Spring Security"
                identityGoogleAdapter = component "Google Authentication Adapter" "Integra Google Authentication sin almacenar la credencial externa completa." "Spring Boot / HTTPS"
                identitySession = component "Session Management Component" "Gestiona sesiones y tokens de acceso." "Spring Security / JWT"
                identityToken = component "Token Service Component" "Firma, valida, rota y revoca access tokens y refresh tokens." "Spring Security / JWT"
                identityAuthorization = component "Authorization Component" "Controla permisos y acceso según roles." "Spring Security"
                identityAccount = component "Account Component" "Gestiona el estado y ciclo de vida de las cuentas." "Java / Spring Boot"
                identityAudit = component "Audit Log Component" "Registra autenticaciones, autorizaciones, cambios de cuenta y acciones administrativas relevantes." "Spring Boot"
                identityEventPublisher = component "Identity Event Publisher" "Publica cambios de identidad, roles, suspensión y revocación sin exponer secretos ni tokens." "Spring Boot / Messaging"
            }

            identityDb = container "Identity & Access Management Database" "Base de datos exclusiva del contexto de Identity & Access Management." "PostgreSQL" {
                tags "Database"
            }


            // =====================================================
            // BC02 - PROFILES & VEHICLES MANAGEMENT
            // =====================================================

            profileService = container "Profiles & Vehicles Management" "Gestiona los datos de los Drivers, User Profiles y Vehicles asociados." "Java / Spring Boot / REST" {
                profileDriver = component "Driver Profile Component" "Gestiona la información del conductor." "Spring Boot"
                profileVehicle = component "Vehicle Component" "Registra y administra Vehicles asociados al Driver, incluida la placa registrada." "Spring Boot"
                profileRole = component "User Profile Component" "Gestiona User Profiles de tipo Driver y Staff; no gestiona Guests ni credenciales." "Spring Boot"
                profileStaffAssignment = component "Staff Assignment Component" "Gestiona la asignación de Staff a un Tenant mediante referencias externas." "Spring Boot"
                profileIdentityAdapter = component "Identity & Access Management Adapter" "Consulta y valida identidad, rol y estado de cuenta mediante el contrato de IAM." "Spring Boot / REST"
                profileEventPublisher = component "Profile Event Publisher" "Publica cambios validados de Driver, Vehicle y Staff Assignment." "Spring Boot / Messaging"
            }

            profileDb = container "Profiles & Vehicles Management Database" "Base de datos exclusiva del contexto de Profiles & Vehicles Management." "PostgreSQL" {
                tags "Database"
            }


            // =====================================================
            // BC03 - PARKING INFRASTRUCTURE
            // =====================================================

            parkingService = container "Parking Infrastructure" "Gestiona zonas, espacios, disponibilidad, reservas, asignaciones y reasignaciones." "Java / Spring Boot / REST" {
                parkingZone = component "Parking Zone Component" "Gestiona las zonas del estacionamiento y sus reglas." "Spring Boot"
                parkingSpot = component "Parking Spot Component" "Gestiona los espacios y su disponibilidad." "Spring Boot"
                parkingReservation = component "Reservation Component" "Gestiona el ciclo de vida de las reservas." "Spring Boot"
                parkingAllocation = component "Spot Allocation Component" "Asigna, reasigna y aplica un Temporary Lock de 10 minutos durante el proceso de pago." "Spring Boot"
                parkingAvailability = component "Availability Component" "Calcula la disponibilidad actual de las zonas y espacios." "Spring Boot"
                parkingGuest = component "Guest Parking Session Component" "Registra manualmente la placa, el ingreso, la salida y el pago físico de una Guest Parking Session; no crea una Reservation." "Spring Boot"
                parkingNavigation = component "Navigation Component" "Genera una ruta hacia la Parking Zone seleccionada mediante Google Maps." "Spring Boot"
                parkingIdentityAdapter = component "Identity & Access Management Adapter" "Valida el rol y el alcance del actor antes de ejecutar operaciones protegidas." "Spring Boot / REST"
                parkingProfileAdapter = component "Profiles & Vehicles Management Adapter" "Consulta Driver, Vehicle y User Profile sin acceder a la base de datos externa." "Spring Boot / REST"
                parkingPaymentAdapter = component "Payments & Billing Adapter" "Solicita pagos, cargos adicionales y reembolsos mediante contratos del contexto de pagos." "Spring Boot / REST / Messaging"
                parkingOccupancyAdapter = component "Occupancy & Monitoring Adapter" "Consulta el estado físico y recibe conflictos o fallas de ocupación." "Spring Boot / Messaging"
            }

            parkingDb = container "Parking Infrastructure Database" "Base de datos exclusiva del contexto de Parking Infrastructure." "PostgreSQL" {
                tags "Database"
            }


            // =====================================================
            // BC04 - PAYMENTS & BILLING
            // =====================================================

            paymentService = container "Payments & Billing" "Gestiona pagos digitales tokenizados, suscripciones, cobros por sobretiempo, reembolsos y facturación." "Java / Spring Boot / REST" {
                paymentProcessing = component "Payment Processing Component" "Procesa pagos digitales utilizando métodos tokenizados." "Spring Boot"
                paymentToken = component "Payment Token Component" "Gestiona tokens asociados a los métodos de pago." "Spring Boot"
                paymentSubscription = component "Subscription Component" "Gestiona planes Free, Plus Monthly y Plus Annual." "Spring Boot"
                paymentAdditionalCharge = component "Additional Charge Component" "Procesa cargos adicionales validados por Parking Infrastructure u Occupancy & Monitoring." "Spring Boot"
                paymentOvertime = component "Overtime Billing Component" "Calcula y procesa cobros adicionales por sobretiempo." "Spring Boot"
                paymentRefund = component "Refund Component" "Gestiona devoluciones de pagos." "Spring Boot"
                paymentInvoice = component "Invoice and Receipt Component" "Genera y consulta Electronic Receipt o Electronic Invoice según la información de facturación." "Spring Boot"
                paymentBalance = component "Pending Balance Component" "Gestiona saldos pendientes derivados de pagos fallidos." "Spring Boot"
                paymentRetry = component "Payment Retry Component" "Programa hasta 4 intentos en 10 minutos para Reservations y conciliaciones según la Retry Policy." "Spring Boot / Scheduler"
                paymentProviderAdapter = component "Internal Payment Provider Adapter" "Traduce el contrato de Payments & Billing al proveedor interno de pagos." "Spring Boot / REST"
                paymentEventPublisher = component "Payment Event Publisher" "Publica resultados de pagos, reembolsos, cargos, saldos y documentos." "Spring Boot / Messaging"
            }

            paymentDb = container "Payments & Billing Database" "Base de datos exclusiva del contexto de Payments & Billing. No almacena datos completos de tarjetas." "PostgreSQL" {
                tags "Database"
            }


            // =====================================================
            // BC05 - OCCUPANCY & MONITORING
            // =====================================================

            occupancyService = container "Occupancy & Monitoring" "Recibe datos IoT, controla la ocupación real, detecta conflictos y genera eventos de sobretiempo." "Java / Spring Boot / REST / IoT" {
                occupancySensor = component "Sensor Integration Component" "Recibe y normaliza lecturas físicas; los sensores no envían placa, driverId ni vehicleId." "Spring Boot / MQTT / HTTP"
                occupancyStatus = component "Occupancy Status Component" "Determina el estado de ocupación del Parking Spot." "Spring Boot"
                occupancyHealth = component "Sensor Health Component" "Controla el estado de conexión y disponibilidad de los sensores." "Spring Boot"
                occupancyConflict = component "Occupancy Conflict Component" "Detecta conflictos entre ocupación real y reservas." "Spring Boot"
                occupancyUnauthorized = component "Unauthorized Occupancy Component" "Genera alertas por ocupación sin una expectativa operativa válida." "Spring Boot"
                occupancyOvertime = component "Overtime Detection Component" "Detecta sobretiempo y solicita un cargo adicional solo con evidencia confiable." "Spring Boot"
                occupancyAlert = component "Occupancy Alert Component" "Genera eventos y alertas operativas." "Spring Boot"
                occupancyCapacity = component "Capacity Monitoring Component" "Calcula High Capacity cuando la ocupación supera el 95 por ciento." "Spring Boot"
                occupancyReport = component "Occupancy Report Component" "Genera reportes operativos para Staff." "Spring Boot"
                occupancyParkingAdapter = component "Parking Infrastructure Adapter" "Consume expectativas y publica estados, conflictos y fallas hacia Parking Infrastructure." "Spring Boot / Messaging"
                occupancyPaymentAdapter = component "Payments & Billing Adapter" "Publica AdditionalChargeRequested cuando existe evidencia suficiente." "Spring Boot / Messaging"
                occupancyFcmAdapter = component "FCM Notification Adapter" "Envía alertas y reportes operativos mediante Firebase Cloud Messaging." "Spring Boot / FCM"
            }

            occupancyDb = container "Occupancy & Monitoring Database" "Base de datos exclusiva del contexto de Occupancy & Monitoring." "PostgreSQL" {
                tags "Database"
            }


            // =====================================================
            // RELACIONES - ACTORES - FRONTENDS
            // =====================================================

            driver -> mobileApp "Utiliza la aplicación móvil"
            staff -> mobileApp "Utiliza las vistas operativas"
            staff -> webApp "Utiliza las vistas administrativas"
            superAdmin -> webApp "Provisiona Staff y administra Tenants"

            // =====================================================
            // FRONTENDS - API GATEWAY
            // =====================================================

            mobileApp -> apiGateway "Consume APIs" "HTTPS / REST"
            webApp -> apiGateway "Consume APIs" "HTTPS / REST"

            // =====================================================
            // API GATEWAY - BOUNDED CONTEXTS
            // =====================================================

            apiGateway -> identityService "Autenticación y autorización" "HTTPS / REST"
            apiGateway -> profileService "Perfiles y vehículos" "HTTPS / REST"
            apiGateway -> parkingService "Zonas, espacios y reservas" "HTTPS / REST"
            apiGateway -> paymentService "Pagos y facturación" "HTTPS / REST"
            apiGateway -> occupancyService "Disponibilidad y monitoreo" "HTTPS / REST"

            // =====================================================
            // BOUNDED CONTEXTS - SUS BASES DE DATOS
            // =====================================================

            identityService -> identityDb "Lee y escribe datos de identidad" "JDBC / SQL"
            profileService -> profileDb "Lee y escribe perfiles y vehículos" "JDBC / SQL"
            parkingService -> parkingDb "Lee y escribe zonas, espacios y reservas" "JDBC / SQL"
            paymentService -> paymentDb "Lee y escribe pagos y facturación" "JDBC / SQL"
            occupancyService -> occupancyDb "Lee y escribe estados y eventos de ocupación" "JDBC / SQL"
            paymentService -> internalPaymentProvider "Procesa pagos, consultas y reembolsos mediante el contrato interno" "HTTPS / REST"

            // =====================================================
            // COMUNICACIONES ENTRE BOUNDED CONTEXTS
            // =====================================================

            profileService -> identityService "Valida la referencia de identidad y el rol" "HTTPS / REST / Events"
            identityService -> profileService "Publica cambios de identidad, roles y provisión" "HTTPS / REST / Events"
            identityService -> googleAuthentication "Valida identidad externa" "HTTPS / REST"
            parkingService -> identityService "Valida identidad y autorización" "HTTPS / REST"
            parkingService -> profileService "Consulta perfiles y vehículos autorizados" "HTTPS / REST"
            profileService -> parkingService "Publica Driver y Vehicle validados" "HTTPS / REST / Events"
            parkingService -> paymentService "Solicita pagos, cargos y reembolsos" "HTTPS / REST / Async Events"
            paymentService -> parkingService "Publica resultados de pagos y reembolsos" "HTTPS / REST / Async Events"
            parkingService -> occupancyService "Publica Reservation, Reassignment y Parking Session expectations" "HTTPS / REST / Events"
            occupancyService -> parkingService "Notifica ocupación, fallas y conflictos" "HTTPS / REST / Events"
            occupancyService -> paymentService "Solicita cargos adicionales con evidencia" "HTTPS / REST / Events"

            // =====================================================
            // SENSORES
            // =====================================================

            parkingSensors -> occupancyService "Reporta ocupación y estado del sensor" "MQTT / HTTP"

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

            mobileApp -> googleMaps "Abre ruta hacia la Parking Zone seleccionada" "Google Maps SDK / Deep Link"

            // =====================================================
            // RELACIONES DE COMPONENTES - BC01
            // =====================================================

            apiGateway -> identityAuthentication "Expone registro e inicio de sesión"
            apiGateway -> identityAuthorization "Autoriza operaciones protegidas"
            identityAuthentication -> identityGoogleAdapter "Valida identidad externa"
            identityGoogleAdapter -> googleAuthentication "Solicita validación de identidad" "HTTPS"
            identityAuthentication -> identitySession "Crea y valida sesiones"
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
            apiGateway -> profileStaffAssignment "Expone asignación de Staff"
            profileDriver -> profileVehicle "Gestiona vehículos del Driver"
            profileDriver -> profileRole "Consulta User Profile"
            profileRole -> profileStaffAssignment "Gestiona asignación de Staff a Tenant"
            profileIdentityAdapter -> identityService "Consulta identidad y rol"
            profileDriver -> profileEventPublisher "Publica cambios del Driver"
            profileVehicle -> profileEventPublisher "Publica registro o baja del Vehicle"
            profileStaffAssignment -> profileEventPublisher "Publica cambios de asignación"
            profileEventPublisher -> parkingService "Publica datos validados de Driver y Vehicle"
            profileDriver -> profileDb "Persistencia"
            profileVehicle -> profileDb "Persistencia"
            profileRole -> profileDb "Persistencia"
            profileStaffAssignment -> profileDb "Persistencia"

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
            paymentProviderAdapter -> internalPaymentProvider "Procesa operación mediante contrato interno" "HTTPS / REST"
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
            occupancyUnauthorized -> occupancyAlert "Genera alerta para Staff"
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
            deploymentNode "Driver Device" "Dispositivo móvil del Driver" "Android / iOS" {
                containerInstance mobileApp
            }

            deploymentNode "Staff Device" "Dispositivo utilizado por Staff para las vistas móviles y administrativas" "Android / iOS / Web Browser" {
                containerInstance mobileApp
                containerInstance webApp
            }

            deploymentNode "SuperAdmin Device" "Dispositivo utilizado por SuperAdmin para provisionar Staff y administrar Tenants" "Web Browser" {
                containerInstance webApp
            }

            // -----------------------------------------------------
            // INFRAESTRUCTURA CLOUD
            // -----------------------------------------------------
            deploymentNode "Cloud Infrastructure" "Infraestructura de ejecución de SpotGo" "Cloud Platform" {

                deploymentNode "API Gateway Server" "Servidor del punto de entrada de las APIs" "Linux / Spring Boot" {
                    containerInstance apiGateway
                }

                deploymentNode "Application Server" "Servidor de microservicios SpotGo" "Linux / JVM" {
                    containerInstance identityService
                    containerInstance profileService
                    containerInstance parkingService
                    containerInstance paymentService
                    containerInstance internalPaymentProvider
                    containerInstance occupancyService
                }

                // -------------------------------------------------
                // INFRAESTRUCTURA DE BASE DE DATOS (Servidor Único)
                // -------------------------------------------------
                deploymentNode "Database Infrastructure" "Servidor de base de datos principal" "Ubuntu Linux" {
                    
                    deploymentNode "PostgreSQL Server" "Motor de base de datos relacional" "PostgreSQL 15+" {
                        containerInstance identityDb
                        containerInstance profileDb
                        containerInstance parkingDb
                        containerInstance paymentDb
                        containerInstance occupancyDb
                    }
                }
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
                softwareSystemInstance googleMaps
                softwareSystemInstance googleAuthentication
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
        // =========================================================

        component identityService "Identity_Components_Diagram" {
            include *
            autoLayout lr
            title "SpotGo - Components Diagram - Identity & Access Management"
            description "Componentes principales del contexto de Identity & Access Management."
        }

        // =========================================================
        // 4. COMPONENT DIAGRAM - PERFILES
        // =========================================================

        component profileService "Profile_Components_Diagram" {
            include *
            autoLayout lr
            title "SpotGo - Components Diagram - Profiles & Vehicles Management"
            description "Componentes principales del contexto de Profiles & Vehicles Management."
        }

        // =========================================================
        // 5. COMPONENT DIAGRAM - INFRAESTRUCTURA
        // =========================================================

        component parkingService "Parking_Components_Diagram" {
            include *
            autoLayout lr
            title "SpotGo - Components Diagram - Parking Infrastructure"
            description "Componentes principales del contexto Core de Parking Infrastructure."
        }

        // =========================================================
        // 6. COMPONENT DIAGRAM - PAGOS
        // =========================================================

        component paymentService "Payment_Components_Diagram" {
            include *
            autoLayout lr
            title "SpotGo - Components Diagram - Payments & Billing"
            description "Componentes principales del contexto de Payments & Billing."
        }

        // =========================================================
        // 7. COMPONENT DIAGRAM - OCUPACIÓN
        // =========================================================

        component occupancyService "Occupancy_Components_Diagram" {
            include *
            autoLayout lr
            title "SpotGo - Components Diagram - Occupancy & Monitoring"
            description "Componentes principales del contexto Core de Occupancy & Monitoring."
        }

        // =========================================================
        // 8. SOFTWARE ARCHITECTURE DEPLOYMENT DIAGRAM
        // =========================================================

        deployment spotgo "Production" "Deployment_Diagram" {
            include *
            autoLayout lr
            title "SpotGo - Software Architecture Deployment Diagram"
            description "Distribución física de los componentes de software de SpotGo sobre dispositivos, servidores, bases de datos, infraestructura IoT y servicios externos."
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
