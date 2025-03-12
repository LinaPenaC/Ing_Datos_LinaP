create database trasnporteEncomiendas;

use trasnporteEncomiendas;

create table ciudad(
codigoCiudad int auto_increment primary key,
nombreCiudad varchar(20) not null
);

create table camionero(
idCamionero int auto_increment primary key,
nombreCamionero varchar(20) not null,
telefonoCamionero varchar(20) not null,
direccionCamionero varchar(30) not null
);

create table paquete(
codigoPaquete int auto_increment primary key,
descripcionPaquete varchar(20) not null,
destinatarioPaquete varchar(20) not null,
direccionPaquete varchar(30) not null,
codigoCiudadFK int not null,
idCamioneroFK int not null,
foreign key (codigoCiudadFK) references ciudad(codigoCiudad) on delete cascade on update cascade,
foreign key (idCamioneroFK) references camionero(idCamionero) on delete cascade on update cascade
);

create table camion(
placa varchar(6) primary key,
modelo varchar(20) not null,
potencia varchar(20) not null,
tipoCamion varchar(30) not null
);

create table detalleConduce(
idDetalleConduce int auto_increment primary key,
placaFK varchar(6) not null,
idCamioneroFK int not null,
foreign key (placaFK) references camion(placa) on delete cascade on update cascade,
foreign key (idCamioneroFK) references camionero(idCamionero) on delete cascade on update cascade
);

describe paquete;
