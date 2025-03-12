create database companiaSeguros;
use companiaSeguros;

create table compania(
nit varchar(20) primary key,
nombre varchar(20) not null,
fechaFundacion timestamp default current_timestamp,
representanteLegal varchar(30) not null
);

create table seguro(
idSeguro int auto_increment primary key,
nitFK varchar(20) not null,
placaFK varchar(6) not null,
fechaInicio timestamp default current_timestamp,
fechaExp date not null,
costoSeguro decimal(10,2) not null,
estado enum('Activo' , 'Pendiente', 'Inactivo') default 'Activo',
foreign key (nitFK) references compania(nit) on delete cascade on update cascade,
foreign key (placaFK) references automovil(placa) on delete cascade on update cascade
);

create table automovil(
placa varchar(6) primary key,
modelo varchar(50) not null,
marca varchar(20) not null,
tipoAutomovil varchar(30) not null,
serialChasis varchar(30) not null,
cilindraje int not null
);

create table accidente(
codigoAccidente int auto_increment primary key,
placaFK varchar(6) not null,
heridos int not null,
fechaAccidente timestamp default current_timestamp,
lugarAccidente varchar(50) null,
automotoresAccidente int not null,
fatalidades int not null,
foreign key (placaFK) references automovil(placa) on delete cascade on update cascade
);

describe seguro;