/*1. Crear BD create Crear estructuras BD tablas vistas procedimientos almacenados*/
/*Craer BD*/
Create database viajesURosario;
Create database tienda;

/*Habilitar o usar base de datos*/
use tienda;

/*Crear tablas: create table nombreTabla*/
create table cliente(
idCliente int AUTO_INCREMENT PRIMARY KEY,
documentCliente int NOT NULL,
nombreCliente varchar(50) NOT NULL,
emailCliente varchar(50) NOT NULL,
telefonoCliente varchar(50) NOT NULL,
direccionCliente text,
fechaRegistro timestamp default current_timestamp
);

create table pedido(
idPedido int AUTO_INCREMENT PRIMARY KEY,
idClienteFK int NOT NULL,
idProductoFK int not null,
fechaPedido date NOT NULL,
totalPedido decimal(10,2) NOT NULL, /*10 digitos y dos decimales*/
estado enum('Pendiente', 'Enviado', 'Entregado', 'Cancelado') default 'Pendiente',
fechaRegistro timestamp default current_timestamp,
foreign key(idProductoFK) references Producto(idProducto) on delete cascade on update cascade
);

create table producto(
idProducto int AUTO_INCREMENT PRIMARY KEY,
codigoProduto varchar(50) NOT NULL,
nombreProducto varchar(50) NOT NULL,
precioProducto decimal (10,2) NOT NULL,
stock int default 0,
fechaCreacion timestamp default current_timestamp
);

insert into Cliente values(' ',202,'Juan', 'juan@gmail.com','3005678456','calle 13',' ');
insert into Cliente values(' ',203,'Juana', 'juana@gmail.com','3235678456','calle 13',' '),
(' ',204,'Juanita', 'juanita@gmail.com','3005678446','calle 14',' '),(' ',205,'Juanes', 'juanes@gmail.com','3008878456','calle 13',' '),
(' ',206,'Julian', 'julian@gmail.com','3005676786','calle 12',' ');describe Cliente;

describe producto;

insert into Producto values(' ', '0000', 'jabón', 3000,8,' ' ),(' ', '0606', 'papa', 3099,2,' ' ),(' ', '07770', 'dulce', 3097,3,' ' ),
(' ', '2200', 'shampoo', 25666,6,' ' ),(' ', '5600', 'rastrillo', 78820,9,' ' );

/*Modificar estructuras alter table*/

/*agregar una columna un campo alter table nombreTabla add column nombreCampo*/
alter table producto add column descripcionProducto varchar(50) not null;

/*modificar tipo de dato  nombreTabla modify column nombrecampo*/
alter table producto modify column precioProducto decimal(12,2);

/* renombrar una tabla alter table nombreTabla rename to nuevoNombre*/
alter table producto rename to product;

/* eliminar tablas drop table nombreTabla*/
drop table pedido;

/*eliminar base de datos* drop database NombreBD*/
drop database viajesurosario;

/*Eliminar registros de una tabla truncate table NombreTabla*/
truncate table pedido;

/*Cliente pedido*/
alter table pedido add constraint FKclientPed
foreign key (idClienteFK) references cliente (idCliente);

