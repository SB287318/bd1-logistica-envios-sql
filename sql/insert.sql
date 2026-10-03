use OBLIGATORIO_BD1_287318
set dateformat dmy
go

-------------------------------
-- 1. TIPO_DE_VEHICULO
-------------------------------
insert into TIPO_DE_VEHICULO (codigoTipoVehiculo, descripcion)
values 
('CAM01', 'Camión de carga pesada'),
('FUR02', 'Furgón de reparto urbano'),
('MOT03', 'Motocicleta de mensajería');
go

-------------------------------
-- 2. VEHICULO
-------------------------------
insert into VEHICULO (matricula, descripcion, marca, modelo, añoFabricacion, capacidadCarga, consumoCombustible, codigoTipoVehiculo)
values
('SBA123', 'Camión Volvo FH16', 'Volvo', 'FH16', 2018, 18000, 32.5, 'CAM01'),
('SBB456', 'Camión Scania R500', 'Scania', 'R500', 2020, 20000, 30.2, 'CAM01'),
('SBC789', 'Furgón Mercedes Sprinter', 'Mercedes', 'Sprinter', 2021, 3500, 12.8, 'FUR02'),
('SBD321', 'Moto Honda Cargo', 'Honda', 'Cargo 125', 2019, 200, 3.5, 'MOT03'),
('SBE654', 'Furgón Renault Master', 'Renault', 'Master', 2017, 4000, 14.1, 'FUR02');
go

-------------------------------
-- 3. CHOFER
-------------------------------
insert into CHOFER (numeroFuncionario, cedulaChofer, nombre, apellido, fechaNacimiento, numeroLicencia, teléfono)
values
(1, '45678231', 'Juan', 'Pérez', '12/03/1985', 'LIC12345', '091234567'),
(2, '48765012', 'María', 'López', '08/07/1990', 'LIC67890', '098765432'),
(3, '51234987', 'Carlos', 'Gómez', '20/01/1982', 'LIC54321', '094556677'),
(4, '49988765', 'Lucía', 'Fernández', '30/09/1995', 'LIC11223', '099334455'),
(5, '47899012', 'Sergio', 'Rodríguez', '22/11/1988', 'LIC44556', '097889900'),
(6, '52211888', 'Laura', 'Silva', '03/04/1992', 'LIC77889', '092345678'); -- No tiene envíos
go

-------------------------------
-- 4. HABILITACION
-------------------------------
insert into HABILITACION (descripcion)
values 
('Carga Pesada'),
('Carga Liviana'),
('Material Peligroso');
go

-------------------------------
-- 5. CHOFER_TIENE_HABI
-------------------------------
insert into CHOFER_TIENE_HABI (numeroFuncionario, numeroHabilitacion)
values
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3),
(6, 2);
go

-------------------------------
-- 6. CLIENTE
-------------------------------
insert into CLIENTE (numeroCliente, razonSocial, dirección, teléfono, país)
values
(1, 'TransLog SA', 'Av. Italia 1023', '24001234', 'Uruguay'),
(2, 'AgroCampos SRL', 'Ruta 5 Km 52', '23456789', 'Uruguay'),
(3, 'TechExpress Ltda', 'Bvar. Artigas 2300', '24112233', 'Uruguay'),
(4, 'Farmacia Central', '18 de Julio 1200', '29009900', 'Uruguay'),
(5, 'OfiPlus SA', 'Colonia 1555', '29001122', 'Uruguay'); -- Sin envíos
go

-------------------------------
-- 7. ENVIO (ajustado para que el vehículo 1 tenga más envíos)
-------------------------------
insert into ENVIO (numeroEnvio, fechaHoraSalida, fechaHoraFinalEstimada, fechaHoraFinalReal, numeroVehiculo)
values
(100, '05/10/2024 08:00', '05/10/2024 18:00', '05/10/2024 17:45', 1), -- Volvo FH16
(101, '10/10/2024 09:00', '10/10/2024 15:00', '10/10/2024 14:50', 3), -- Sprinter
(102, '12/10/2024 07:30', '12/10/2024 19:30', '12/10/2024 20:10', 2), -- Scania
(103, '18/10/2024 10:00', '18/10/2024 16:00', '18/10/2024 15:30', 3), -- Sprinter
(104, '22/10/2024 06:30', '22/10/2024 18:00', null, 1), -- Volvo FH16
(105, '25/10/2024 09:15', '25/10/2024 12:15', '25/10/2024 12:20', 4), -- Moto Honda
(106, '28/10/2024 11:00', '28/10/2024 17:00', null, 5), -- Renault Master
(107, '30/10/2024 08:30', '30/10/2024 14:30', null, 2) -- Scania
go

insert into ENVIO (numeroEnvio, fechaHoraSalida, fechaHoraFinalEstimada, fechaHoraFinalReal, numeroVehiculo)
values
(108, '03/11/2024 07:00', '03/11/2024 15:00', '03/11/2024 14:45', 1), -- Volvo FH16 (nuevo)
(109, '07/11/2024 09:30', '07/11/2024 17:00', '07/11/2024 16:55', 1); -- Volvo FH16 (nuevo)
go

-------------------------------
-- 8. CHOFER_ASIGNADO_ENV
-------------------------------
insert into CHOFER_ASIGNADO_ENV (numeroFuncionario, numeroHabilitacion, numeroEnvio)
values
(1, 1, 100),
(2, 1, 102),
(3, 2, 101),
(3, 2, 103),
(4, 2, 105),
(5, 3, 106);
go

insert into CHOFER_ASIGNADO_ENV (numeroFuncionario, numeroHabilitacion, numeroEnvio)
values
(1, 1, 108),
(1, 1, 109);
go

-------------------------------
-- 9. PAQUETE
-------------------------------
insert into PAQUETE (idPaquete, peso, volumen, descripción, numeroCliente, numeroEnvio, orden)
values
(1, 200.50, 1.5, 'Paquete de fertilizantes', 2, 100, 1),
(2, 50.00, 0.8, 'Cajas de medicamentos', 4, 101, 1),
(3, 10.00, 0.2, 'Componentes electrónicos', 3, 102, 1),
(4, 18.00, 0.3, 'Accesorios de oficina', 3, 103, 2),
(5, 320.00, 2.0, 'Alimentos balanceados', 2, 104, 1),
(6, 15.00, 0.1, 'Documentos urgentes', 1, 105, 1),
(7, 45.00, 0.5, 'Repuestos mecánicos', 1, 106, 2),
(8, 12.50, 0.2, 'Equipos médicos pequeños', 4, 107, 1);
go

-------------------------------
-- 10. INSUMO 
-------------------------------
insert into INSUMO (codigoInsumo, descripcion, stock, proveedor)
values
('INS01', 'Caja de cartón', 100, 'EcoPack'),
('INS02', 'Etiqueta adhesiva', 100, 'PrintCo'),
('INS03', 'Cinta de embalaje', 100, 'SecureTape'),
('INS04', 'Bolsa plástica', 100, 'PlastiUr'),
('INS05', 'Palet de madera', 100, 'ForestPack'),
('INS06', 'Funda aislante', 100, 'TermoSafe'),
('INS07', 'Caja metálica', 100, 'MetalBox'),
('INS08', 'Burbuja protectora', 100, 'SafeWrap'),
('INS09', 'Lona impermeable', 100, 'CoverAll'),
('INS10', 'Etiqueta RFID', 100, 'SmartTrack');
go

-------------------------------
-- 11. PAQ_REQUIERE_INS
-------------------------------
insert into PAQ_REQUIERE_INS (idPaquete, codigoInsumo)
values
(1, 'INS05'),
(1, 'INS03'),
(2, 'INS01'),
(2, 'INS02'),
(3, 'INS08'),
(3, 'INS10'),
(4, 'INS01'),
(5, 'INS09'),
(6, 'INS02'),
(7, 'INS07'),
(8, 'INS04');
go

-------------------------------
-- 12. INS1_COMPATIBLE_INS2
-------------------------------
insert into INS1_COMPATIBLE_INS2 (codigoInsumo1, codigoInsumo2)
values
('INS01', 'INS02'),
('INS03', 'INS04'),
('INS05', 'INS09'),
('INS07', 'INS08');
go

-------------------------------
-- 13. EVENTO
-------------------------------
insert into EVENTO (numeroLinea, numeroEnvio, fechaHora, descripcion)
values
(1, 100, '05/10/2024 08:05', 'Salida del depósito central'),
(2, 100, '05/10/2024 17:40', 'Entrega completada'),
(1, 102, '12/10/2024 07:40', 'Salida hacia destino'),
(2, 102, '12/10/2024 20:10', 'Demora por tráfico'),
(1, 105, '25/10/2024 09:20', 'Recolecta de documentos'),
(2, 105, '25/10/2024 12:20', 'Entrega realizada'),
(1, 106, '28/10/2024 11:05', 'Salida en moto'),
(1, 107, '30/10/2024 08:40', 'Entrega en curso');
go
