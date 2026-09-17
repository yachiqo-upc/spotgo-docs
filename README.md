# SpotGo Documentation

<img src="assets/images/others/spotgo-logo.png" alt="SpotGo" width="250">

> Documentación académica de SpotGo, una solución móvil propuesta para organizar y gestionar estacionamientos de alta afluencia.

> Este repositorio contiene el informe, los modelos de dominio y los diagramas de la solución. No incluye una aplicación ejecutable ni requiere instalación de dependencias para consultar la documentación.

## ¿Qué es SpotGo?

SpotGo busca reducir el tiempo que los conductores dedican a encontrar estacionamiento y facilitar la gestión operativa de los espacios disponibles. La propuesta contempla:

- Consulta de disponibilidad y de `Parking Zones` mediante un mapa integrado con Google Maps.
- Registro de `Vehicles` y creación de `Reservations` para `Drivers` registrados.
- Procesamiento de pagos digitales, suscripciones, comprobantes virtuales y facturación electrónica.
- Registro de `Guest Parking Sessions` por parte del `Staff` para `Guests` sin cuenta. El pago se confirma físicamente mediante efectivo o POS, fuera de SpotGo.
- Monitoreo de la ocupación física mediante sensores, sin identificar vehículos ni leer placas automáticamente.
- Notificaciones operativas y de negocio mediante Firebase Cloud Messaging.

## Arquitectura y tecnologías propuestas

La documentación plantea una arquitectura distribuida orientada al dominio, organizada en cinco bounded contexts. Entre las tecnologías e integraciones consideradas se encuentran:

- Aplicación móvil multiplataforma con Flutter e integraciones nativas para Android mediante Kotlin.
- Servicios backend en Java con Spring Boot.
- Bases de datos PostgreSQL independientes por bounded context.
- Comunicación mediante APIs REST sobre HTTPS y eventos asíncronos.
- Integración con Google Maps API, Google Authentication y Firebase Cloud Messaging.
- Comunicación con sensores físicos IoT mediante MQTT/HTTP para reportar la ocupación.

## Equipo

Proyecto desarrollado por el equipo **Yachiqo** para el curso **Aplicaciones para Dispositivos Móviles** de la Universidad Peruana de Ciencias Aplicadas (UPC).

## Licencia

Este proyecto se distribuye bajo la [licencia MIT](LICENSE).
