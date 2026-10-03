create database OBLIGATORIO_BD1_287318
use OBLIGATORIO_BD1_287318
set dateformat dmy


create table TIPO_DE_VEHICULO(
	codigoTipoVehiculo varchar(5) not null check (codigoTipoVehiculo like '[A-Z][A-Z][A-Z][0-9][0-9]'),
	descripcion varchar(30) not null,
	primary key(codigoTipoVehiculo),
);

create table VEHICULO(
	numeroVehiculo int not null identity(1,1), 
	matricula varchar(6) UNIQUE,
	descripcion varchar(30) not null,
	marca varchar(20) not null,
	modelo varchar(20) not null,
	añoFabricacion int,
	capacidadCarga int,
	consumoCombustible dec(10,2), 
	codigoTipoVehiculo varchar(5),
	primary key(numeroVehiculo),
	foreign key(codigoTipoVehiculo) references TIPO_DE_VEHICULO(codigoTipoVehiculo),
);

create table CHOFER(
	numeroFuncionario int not null,
	cedulaChofer varchar(8) UNIQUE,
	nombre varchar(20),
	apellido varchar(20),
	fechaNacimiento Date,
	numeroLicencia varchar(20),
	teléfono varchar(10),
	primary key(numeroFuncionario),
);

create table HABILITACION(
	numeroHabilitacion int not null identity(1,1), 
	descripcion varchar(20),
	primary key(numeroHabilitacion),
);

create table CHOFER_TIENE_HABI(
	numeroFuncionario int not null,
	numeroHabilitacion int not null,
	primary key(numeroFuncionario, numeroHabilitacion),
	foreign key(numeroFuncionario) references CHOFER(numeroFuncionario),
	foreign key(numeroHabilitacion) references HABILITACION(numeroHabilitacion),
);

create table ENVIO(
	numeroEnvio int not null,
	fechaHoraSalida datetime,
	fechaHoraFinalEstimada datetime,
	fechaHoraFinalReal datetime,
	numeroVehiculo int not null,
	primary key(numeroEnvio),
	foreign key(numeroVehiculo) references VEHICULO(numeroVehiculo),
);

create table CHOFER_ASIGNADO_ENV(
	numeroFuncionario int not null,
	numeroHabilitacion int not null,
	numeroEnvio int not null,
	primary key(numeroFuncionario, numeroHabilitacion, numeroEnvio),
	foreign key(numeroFuncionario) references CHOFER(numeroFuncionario),
	foreign key(numeroHabilitacion) references HABILITACION(numeroHabilitacion),
	foreign key(numeroEnvio) references ENVIO(numeroEnvio),
);

create table CLIENTE(
	numeroCliente int not null,
	razonSocial varchar(40) not null,
	dirección varchar(20),
	teléfono varchar(10),
	país varchar(20),
	primary key(numeroCliente),
);

create table PAQUETE(
	idPaquete int not null,
	peso dec(10,2),
	volumen dec(10,2),
	descripción varchar(60) not null,
	numeroCliente int not null,
	numeroEnvio int not null,
	orden int,
	primary key(idPaquete),
	foreign key(numeroCliente) references CLIENTE(numeroCliente),
	foreign key(numeroEnvio) references ENVIO(numeroEnvio),
);

create table INSUMO(
	codigoInsumo varchar(5) not null,
	descripcion varchar(20),
	stock int check(stock>=0),
	proveedor varchar(20),
	primary key(codigoInsumo),
);

create table PAQ_REQUIERE_INS(
	idPaquete int not null,
	codigoInsumo varchar(5) not null,
	primary key(idPaquete, codigoInsumo),
	foreign key (idPaquete) references PAQUETE(idPaquete),
	foreign key (codigoInsumo) references INSUMO(codigoInsumo),
);

create table INS1_COMPATIBLE_INS2(
	codigoInsumo1 varchar(5) not null,
	codigoInsumo2 varchar(5) not null,
	check(codigoInsumo1 != codigoInsumo2),
	primary key(codigoInsumo1, codigoInsumo2),
	foreign key (codigoInsumo1) references INSUMO(codigoInsumo),
	foreign key (codigoInsumo2) references INSUMO(codigoInsumo),
);

create table EVENTO(
	numeroLinea int not null,
	numeroEnvio int not null,
	fechaHora datetime,
	descripcion varchar(40),
	primary key(numeroLinea, numeroEnvio),
	foreign key(numeroEnvio) references ENVIO(numeroEnvio),
);
