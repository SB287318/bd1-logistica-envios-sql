USE OBLIGATORIO_BD1_287318
SET DATEFORMAT DMY

SELECT * FROM TIPO_DE_VEHICULO
SELECT * FROM VEHICULO
SELECT * FROM CHOFER
SELECT * FROM HABILITACION
SELECT * FROM CHOFER_TIENE_HABI
SELECT * FROM CHOFER_ASIGNADO_ENV
SELECT * FROM CLIENTE
SELECT * FROM ENVIO
SELECT * FROM PAQUETE
SELECT * FROM INSUMO
SELECT * FROM PAQ_REQUIERE_INS
SELECT * FROM INS1_COMPATIBLE_INS2
SELECT * FROM EVENTO


--5.1 Listar cada cliente con la cantidad total de envíos que ha realizado.

SELECT C.numeroCliente, C.razonSocial, COUNT(numeroEnvio) CANT_ENVIOS
FROM CLIENTE C 
JOIN PAQUETE P ON C.numeroCliente=P.numeroCliente
GROUP BY C.numeroCliente, C.razonSocial


--5.2 Mostrar todos los clientes y la cantidad de envíos.

SELECT C.numeroCliente, C.razonSocial, COUNT(numeroEnvio) CANT_ENVIOS
FROM CLIENTE C 
LEFT JOIN PAQUETE P ON C.numeroCliente=P.numeroCliente
GROUP BY C.numeroCliente, C.razonSocial 

--5.3 Calcular el peso promedio de los paquetes transportados por cada vehículo.

SELECT E.numeroVehiculo, AVG(P.PESO) AS PESO_PROMEDIO
FROM PAQUETE P
JOIN ENVIO E ON P.numeroEnvio=E.numeroEnvio
GROUP BY E.numeroVehiculo

--5.4 Listar los choferes que existen en la empresa pero que nunca participaron en ningún envío.

SELECT numeroFuncionario, nombre, apellido 
FROM CHOFER
WHERE numeroFuncionario NOT IN
	(SELECT numeroFuncionario
	FROM CHOFER_ASIGNADO_ENV)

--5.5 Obtener el vehículo con mayor cantidad de envíos realizados.

SELECT numeroVehiculo, COUNT(numeroEnvio) CANT_ENVIOS
FROM ENVIO
GROUP BY numeroVehiculo
HAVING COUNT(numeroEnvio) >= ALL
 (SELECT COUNT(numeroEnvio)
 FROM ENVIO
 GROUP BY numeroVehiculo)

--5.6 Listar cada insumo junto con la descripción de los insumos que son compatibles con él.

SELECT I.codigoInsumo, I.Descripcion, II.codigoInsumo2, I2.Descripcion
FROM INSUMO I
LEFT JOIN INS1_COMPATIBLE_INS2 II ON I.codigoInsumo=II.codigoInsumo1
LEFT JOIN INSUMO I2 ON II.codigoInsumo2=I2.codigoInsumo

--5.7 Modificar la tabla de Insumos para agregar el stock disponible e inicializar este con el valor
--100 para todos los insumos existentes

ALTER TABLE INSUMO
ADD stockDisponible INT CHECK(stockDisponible >= 0)

UPDATE INSUMO
SET stockDisponible = 100