# SpotGo Documentation

<img src="assets/images/others/spotgo-logo.png" alt="SpotGo" width="250">

> Documentación académica de SpotGo, una solución digital propuesta para organizar y gestionar estacionamientos de alta afluencia.

> Este repositorio contiene el informe, los modelos de dominio y los diagramas de la solución. No incluye una aplicación ejecutable ni requiere instalación de dependencias para consultar la documentación.

## ¿Qué es SpotGo?

SpotGo busca reducir el tiempo que los conductores dedican a encontrar estacionamiento y facilitar la gestión operativa de los espacios disponibles. La propuesta contempla:

- Consulta de disponibilidad y estacionamientos en un mapa integrado con MapLibre y mapas base de OpenStreetMap; Google Maps abre la navegación externa.
- Registro de vehículos y creación de reservas para conductores registrados.
- Procesamiento de pagos digitales, suscripciones, comprobantes virtuales y facturación electrónica.
- Registro de sesiones de visitantes por parte del administrador del estacionamiento para conductores sin cuenta. El pago se confirma físicamente mediante efectivo o POS, fuera de SpotGo.
- Monitoreo de la ocupación física mediante sensores, sin identificar vehículos ni leer placas automáticamente.
- Notificaciones operativas y de negocio mediante Firebase Cloud Messaging.

## Arquitectura, tecnologías y despliegue

La documentación describe un monolito modular orientado al dominio, organizado en cinco bounded contexts. SpotGo utiliza una sola instancia de backend y una sola instancia PostgreSQL, con separación lógica de responsabilidades y datos por contexto. La solución incluye las siguientes tecnologías, integraciones y plataformas de despliegue:

- Una aplicación Android nativa con Kotlin y Jetpack Compose para Driver.
- Una aplicación multiplataforma con Flutter y Dart para Parking Admin.
- Una aplicación web con Angular, TypeScript y Angular Material para SuperAdmin.
- Monolito modular de backend desarrollado con Java 25 LTS y Spring Boot, empaquetado con Docker y desplegado como un único Web Service en Render.
- Una instancia PostgreSQL en Neon, con separación lógica de los datos según los cinco bounded contexts.
- Los clientes consumen la API REST del backend sobre HTTPS; los módulos colaboran mediante contratos internos y eventos de dominio.
- Mapa integrado con MapLibre y OpenStreetMap, navegación externa con Google Maps e integración opcional con Firebase Cloud Messaging.
- Comunicación con sensores físicos IoT mediante MQTT/HTTP para reportar la ocupación.
- Landing Page publicada en GitHub Pages y SpotGo Administration Web App desplegada como Static Site en Render.
- SpotGo Driver Android App y SpotGo Parking Admin Flutter App distribuidas mediante Firebase App Distribution.

## Equipo

Proyecto desarrollado por el equipo **Yachiqo** para el curso **Aplicaciones para Dispositivos Móviles (1ACC0238)** de la Universidad Peruana de Ciencias Aplicadas (UPC).

## Licencia

Este proyecto se distribuye bajo la [licencia MIT](LICENSE).
