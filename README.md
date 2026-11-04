# SpotGo Documentation

<img src="assets/images/others/spotgo-logo.png" alt="SpotGo" width="250">

> Documentación académica de SpotGo, una solución digital propuesta para organizar y gestionar estacionamientos de alta afluencia.

> Este repositorio contiene el informe, los modelos de dominio y los diagramas de la solución. No incluye una aplicación ejecutable ni requiere instalación de dependencias para consultar la documentación.

## ¿Qué es SpotGo?

SpotGo busca reducir el tiempo que los conductores dedican a encontrar estacionamiento y facilitar la gestión operativa de los espacios disponibles. La propuesta contempla:

- Consulta de disponibilidad y de estacionamientos mediante un mapa integrado con Google Maps.
- Registro de vehículos y creación de reservas para conductores registrados.
- Procesamiento de pagos digitales, suscripciones, comprobantes virtuales y facturación electrónica.
- Registro de sesiones de visitantes por parte del administrador del estacionamiento para conductores sin cuenta. El pago se confirma físicamente mediante efectivo o POS, fuera de SpotGo.
- Monitoreo de la ocupación física mediante sensores, sin identificar vehículos ni leer placas automáticamente.
- Notificaciones operativas y de negocio mediante Firebase Cloud Messaging.

## Arquitectura, tecnologías y despliegue

La documentación describe una arquitectura distribuida orientada al dominio, organizada en cinco bounded contexts. La solución incluye las siguientes tecnologías, integraciones y plataformas de despliegue:

- Una aplicación Android nativa con Kotlin y Jetpack Compose para Driver.
- Una aplicación multiplataforma con Flutter y Dart para Parking Admin.
- Una aplicación web con Angular, TypeScript y Angular Material para SuperAdmin.
- Backend desarrollado con Java 25 LTS y Spring Boot, empaquetado con Docker y desplegado como Web Service en Render.
- Cinco bases de datos PostgreSQL independientes por bounded context, alojadas en una sola instancia física de PostgreSQL Server.
- Comunicación mediante APIs REST sobre HTTPS y eventos asíncronos.
- Integración con Google Maps API y Firebase Cloud Messaging.
- Comunicación con sensores físicos IoT mediante MQTT/HTTP para reportar la ocupación.
- Landing Page publicada en GitHub Pages y SpotGo Administration Web App desplegada como Static Site en Render.
- SpotGo Driver Android App y SpotGo Parking Admin Flutter App distribuidas mediante Firebase App Distribution.

## Equipo

Proyecto desarrollado por el equipo **Yachiqo** para el curso **Aplicaciones para Dispositivos Móviles (1ACC0238)** de la Universidad Peruana de Ciencias Aplicadas (UPC).

## Licencia

Este proyecto se distribuye bajo la [licencia MIT](LICENSE).
