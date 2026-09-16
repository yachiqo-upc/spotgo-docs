workspace "SpotGo - Software Architecture" "Arquitectura de Software de SpotGo basada en C4 Model y DDD" {

    model {

        // =========================================================
        // ACTORES
        // =========================================================

        driver = person "Driver" "Conductor que consulta disponibilidad, registra vehículos, reserva y realiza pagos."

        parkingAdmin = person "Parking Administrator" "Administra la infraestructura, perfiles, reservas y operación del estacionamiento."

        superAdmin = person "SuperAdmin" "Administra Tenants y la configuración inicial de los estacionamientos."


        // =========================================================
        // SISTEMAS EXTERNOS
        // =========================================================

        googleMaps = softwareSystem "Google Maps" "Servicio externo utilizado para abrir rutas de navegación." {
            tags "External System"
        }

        notificationProvider = softwareSystem "Firebase Cloud Messaging" "Servicio externo de Google utilizado para enviar notificaciones push a los usuarios." {
            tags "External System"
        }

        parkingSensors = softwareSystem "Sensores Físicos IoT" "Sensores físicos que reportan únicamente ocupación y estado del sensor." {
            tags "External System"
        }


        // =========================================================
        // SISTEMA SPOTGO
        // =========================================================

        spotgo = softwareSystem "SpotGo" "Sistema de gestión de estacionamientos." {

            // =====================================================
            // FRONTENDS
            // =====================================================

            mobileApp = container "SpotGo Mobile App" "Aplicación móvil para Drivers y Parking Administrators." "Flutter / Kotlin"

            webApp = container "SpotGo Web App" "Landing Page y aplicación web administrativa." "Angular / Vue.js"

            apiGateway = container "API Gateway" "Punto único de entrada que enruta las solicitudes hacia los microservicios." "Spring Boot / API Gateway"


            // =====================================================
            // BC01 - GESTIÓN DE IDENTIDAD Y ACCESO
            // =====================================================

            identityService = container "Gestión de Identidad y Acceso" "Autentica usuarios, gestiona credenciales y sesiones y autoriza el acceso según roles." "Java / Spring Boot / REST" {
                identityAuthentication = component "Authentication Component" "Valida las credenciales de los usuarios." "Spring Security"
                identitySession = component "Session Management Component" "Gestiona sesiones y tokens de acceso." "Spring Security / JWT"
                identityAuthorization = component "Authorization Component" "Controla permisos y acceso según roles." "Spring Security"
                identityAccount = component "Account Component" "Gestiona el estado y ciclo de vida de las cuentas." "Java / Spring Boot"
                identityAudit = component "Audit Log Component" "Registra la bitácora de modificaciones (usuario, acción, fecha, datos) realizadas por los administradores." "Spring Boot"
            }

            identityDb = container "Identity Database" "Base de datos exclusiva del contexto de Identidad y Acceso." "PostgreSQL" {
                tags "Database"
            }


            // =====================================================
            // BC02 - GESTIÓN DE PERFILES Y VEHÍCULOS
            // =====================================================

            profileService = container "Gestión de Perfiles y Vehículos" "Gestiona los datos de los conductores, perfiles de usuario y vehículos asociados." "Java / Spring Boot / REST" {
                profileDriver = component "Driver Profile Component" "Gestiona la información del conductor." "Spring Boot"
                profileVehicle = component "Vehicle Component" "Registra y administra vehículos asociados al conductor." "Spring Boot"
                profileRole = component "User Profile Component" "Gestiona perfiles como Visitor y Staff." "Spring Boot"
                profileTenant = component "Tenant Component" "Gestiona la relación entre estacionamientos y configuración B2B." "Spring Boot"
            }

            profileDb = container "Profile & Vehicle Database" "Base de datos exclusiva del contexto de Perfiles y Vehículos." "PostgreSQL" {
                tags "Database"
            }


            // =====================================================
            // BC03 - INFRAESTRUCTURA DE ESTACIONAMIENTO
            // =====================================================

            parkingService = container "Infraestructura de Estacionamiento" "Gestiona zonas, espacios, disponibilidad, reservas, asignaciones y reasignaciones." "Java / Spring Boot / REST" {
                parkingZone = component "Parking Zone Component" "Gestiona las zonas del estacionamiento y sus reglas." "Spring Boot"
                parkingSpot = component "Parking Spot Component" "Gestiona los espacios y su disponibilidad." "Spring Boot"
                parkingReservation = component "Reservation Component" "Gestiona el ciclo de vida de las reservas." "Spring Boot"
                parkingAllocation = component "Spot Allocation Component" "Asigna, reasigna y aplica el bloqueo temporal de espacios durante el proceso de pago." "Spring Boot"
                parkingAvailability = component "Availability Component" "Calcula la disponibilidad actual de las zonas y espacios." "Spring Boot"
                parkingGuest = component "Guest Reservation Component" "Crea reservas con ingreso manual de placa tras validación de pago físico externo." "Spring Boot"
                parkingNavigation = component "Navigation Component" "Proporciona el destino del espacio asignado para la navegación." "Spring Boot"
            }

            parkingDb = container "Parking Infrastructure Database" "Base de datos exclusiva del contexto de Infraestructura de Estacionamiento." "PostgreSQL" {
                tags "Database"
            }


            // =====================================================
            // BC04 - PAGOS Y FACTURACIÓN
            // =====================================================

            paymentService = container "Pagos y Facturación" "Gestiona pagos digitales tokenizados, suscripciones, cobros por sobretiempo, reembolsos y facturación." "Java / Spring Boot / REST" {
                paymentProcessing = component "Payment Processing Component" "Procesa pagos digitales utilizando métodos tokenizados." "Spring Boot"
                paymentToken = component "Payment Token Component" "Gestiona tokens asociados a los métodos de pago." "Spring Boot"
                paymentSubscription = component "Subscription Component" "Gestiona planes Free, Plus Monthly y Plus Annual." "Spring Boot"
                paymentOvertime = component "Overtime Billing Component" "Calcula y procesa cobros adicionales por sobretiempo." "Spring Boot"
                paymentRefund = component "Refund Component" "Gestiona devoluciones de pagos." "Spring Boot"
                paymentInvoice = component "Invoice Component" "Genera y consulta comprobantes electrónicos tributarios B2C y la facturación B2B del Tenant." "Spring Boot"
                paymentBalance = component "Pending Balance Component" "Gestiona saldos pendientes derivados de pagos fallidos." "Spring Boot"
            }

            paymentDb = container "Payment & Billing Database" "Base de datos exclusiva del contexto de Pagos y Facturación. No almacena datos completos de tarjetas." "PostgreSQL" {
                tags "Database"
            }


            // =====================================================
            // BC05 - OCUPACIÓN Y MONITOREO
            // =====================================================

            occupancyService = container "Ocupación y Monitoreo" "Recibe datos IoT, controla la ocupación real, detecta conflictos y genera eventos de sobretiempo." "Java / Spring Boot / REST / IoT" {
                occupancySensor = component "Sensor Integration Component" "Recibe datos provenientes de los sensores físicos." "Spring Boot / MQTT / HTTP"
                occupancyStatus = component "Occupancy Status Component" "Determina el estado de ocupación del Parking Spot." "Spring Boot"
                occupancyHealth = component "Sensor Health Component" "Controla el estado de conexión y disponibilidad de los sensores." "Spring Boot"
                occupancyConflict = component "Occupancy Conflict Component" "Detecta conflictos entre ocupación real y reservas." "Spring Boot"
                occupancyOvertime = component "Overtime Detection Component" "Detecta situaciones de sobretiempo." "Spring Boot"
                occupancyAlert = component "Occupancy Alert Component" "Genera eventos y alertas operativas." "Spring Boot"
            }

            occupancyDb = container "Occupancy Database" "Base de datos exclusiva del contexto de Ocupación y Monitoreo." "PostgreSQL" {
                tags "Database"
            }


            // =====================================================
            // RELACIONES - ACTORES - FRONTENDS
            // =====================================================

            driver -> mobileApp "Utiliza"
            parkingAdmin -> mobileApp "Utiliza"
            parkingAdmin -> webApp "Utiliza"
            superAdmin -> webApp "Utiliza"

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

            // =====================================================
            // COMUNICACIONES ENTRE BOUNDED CONTEXTS
            // =====================================================

            parkingService -> identityService "Valida identidad y permisos" "HTTPS / REST"
            parkingService -> profileService "Consulta perfiles y vehículos autorizados" "HTTPS / REST"
            parkingService -> paymentService "Solicita cobros y reembolsos" "HTTPS / REST / Async Events"
            occupancyService -> parkingService "Notifica ocupación, fallas y conflictos" "HTTPS / REST / Events"
            occupancyService -> paymentService "Notifica sobretiempo para cobro adicional" "HTTPS / REST / Events"

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

            mobileApp -> googleMaps "Abre ruta hacia el estacionamiento o espacio asignado" "Google Maps SDK / Deep Link"

            // =====================================================
            // RELACIONES DE COMPONENTES - BC01
            // =====================================================

            identityAuthentication -> identitySession "Crea y valida sesiones"
            identitySession -> identityAuthorization "Aplica permisos"
            identityAuthentication -> identityAccount "Consulta cuenta"
            identityAccount -> identityDb "Persistencia"
            identityAuthentication -> identityDb "Consulta credenciales"
            identitySession -> identityDb "Persistencia de sesiones"
            identityAuthorization -> identityDb "Consulta roles"
            identityAuthorization -> identityAudit "Registra acciones administrativas"

            // =====================================================
            // RELACIONES DE COMPONENTES - BC02
            // =====================================================

            profileDriver -> profileVehicle "Gestiona vehículos del conductor"
            profileDriver -> profileRole "Consulta perfil"
            profileDriver -> profileTenant "Consulta Tenant"
            profileDriver -> profileDb "Persistencia"
            profileVehicle -> profileDb "Persistencia"
            profileRole -> profileDb "Persistencia"
            profileTenant -> profileDb "Persistencia"

            // =====================================================
            // RELACIONES DE COMPONENTES - BC03
            // =====================================================

            parkingZone -> parkingSpot "Contiene espacios"
            parkingSpot -> parkingAvailability "Proporciona disponibilidad"
            parkingReservation -> parkingAllocation "Solicita asignación"
            parkingAllocation -> parkingAvailability "Consulta disponibilidad"
            parkingAllocation -> parkingSpot "Asigna espacio"
            parkingReservation -> parkingZone "Valida zona"
            parkingReservation -> parkingSpot "Reserva espacio"
            parkingGuest -> parkingReservation "Crea reserva"
            parkingNavigation -> parkingAllocation "Obtiene espacio asignado"
            parkingReservation -> parkingDb "Persistencia"
            parkingZone -> parkingDb "Persistencia"
            parkingSpot -> parkingDb "Persistencia"
            parkingAllocation -> parkingDb "Persistencia"

            // =====================================================
            // RELACIONES DE COMPONENTES - BC04
            // =====================================================

            paymentProcessing -> paymentToken "Utiliza token de pago"
            paymentProcessing -> paymentSubscription "Aplica beneficios"
            paymentProcessing -> paymentInvoice "Genera comprobante"
            paymentProcessing -> paymentBalance "Gestiona resultado"
            paymentOvertime -> paymentSubscription "Aplica descuento de suscripción"
            paymentOvertime -> paymentInvoice "Registra cobro"
            paymentRefund -> paymentProcessing "Revierte operación"
            paymentProcessing -> paymentDb "Persistencia"
            paymentToken -> paymentDb "Persistencia"
            paymentSubscription -> paymentDb "Persistencia"
            paymentOvertime -> paymentDb "Persistencia"
            paymentRefund -> paymentDb "Persistencia"
            paymentInvoice -> paymentDb "Persistencia"
            paymentBalance -> paymentDb "Persistencia"

            // =====================================================
            // RELACIONES DE COMPONENTES - BC05
            // =====================================================

            occupancySensor -> occupancyStatus "Actualiza ocupación"
            occupancySensor -> occupancyHealth "Actualiza salud del sensor"
            occupancyStatus -> occupancyConflict "Compara con reservas"
            occupancyConflict -> occupancyAlert "Genera alerta"
            occupancyStatus -> occupancyOvertime "Evalúa sobretiempo"
            occupancyOvertime -> occupancyAlert "Genera evento"
            occupancySensor -> occupancyDb "Persistencia"
            occupancyStatus -> occupancyDb "Persistencia"
            occupancyHealth -> occupancyDb "Persistencia"
            occupancyConflict -> occupancyDb "Persistencia"
            occupancyOvertime -> occupancyDb "Persistencia"

            // =====================================================
            // RELACIONES DE COMPONENTES - OTROS BOUNDED CONTEXTS
            // =====================================================

            parkingReservation -> profileDriver "Consulta conductor"
            parkingReservation -> profileVehicle "Valida vehículo"
            parkingReservation -> paymentProcessing "Solicita pago"
            parkingAllocation -> occupancyStatus "Consulta estado de ocupación"
            occupancyConflict -> parkingReservation "Notifica conflicto"
            occupancyConflict -> parkingAllocation "Solicita reasignación"
            occupancyOvertime -> paymentOvertime "Solicita cobro adicional"
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

            deploymentNode "Administrator Device" "Dispositivo utilizado por el Parking Administrator" "Web Browser" {
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
            title "SpotGo - Components Diagram - Gestión de Identidad y Acceso"
            description "Componentes principales del contexto de Gestión de Identidad y Acceso."
        }

        // =========================================================
        // 4. COMPONENT DIAGRAM - PERFILES
        // =========================================================

        component profileService "Profile_Components_Diagram" {
            include *
            autoLayout lr
            title "SpotGo - Components Diagram - Gestión de Perfiles y Vehículos"
            description "Componentes principales del contexto de Gestión de Perfiles y Vehículos."
        }

        // =========================================================
        // 5. COMPONENT DIAGRAM - INFRAESTRUCTURA
        // =========================================================

        component parkingService "Parking_Components_Diagram" {
            include *
            autoLayout lr
            title "SpotGo - Components Diagram - Infraestructura de Estacionamiento"
            description "Componentes principales del contexto Core de Infraestructura de Estacionamiento."
        }

        // =========================================================
        // 6. COMPONENT DIAGRAM - PAGOS
        // =========================================================

        component paymentService "Payment_Components_Diagram" {
            include *
            autoLayout lr
            title "SpotGo - Components Diagram - Pagos y Facturación"
            description "Componentes principales del contexto de Pagos y Facturación."
        }

        // =========================================================
        // 7. COMPONENT DIAGRAM - OCUPACIÓN
        // =========================================================

        component occupancyService "Occupancy_Components_Diagram" {
            include *
            autoLayout lr
            title "SpotGo - Components Diagram - Ocupación y Monitoreo"
            description "Componentes principales del contexto Core de Ocupación y Monitoreo."
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