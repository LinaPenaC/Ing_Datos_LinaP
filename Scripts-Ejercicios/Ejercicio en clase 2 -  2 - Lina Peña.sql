/*Lenguaje de manipulación*/
/*Inserción: creación de registros- registrar crear fila en la tablas insertar uno o varios registro */
create database TiendaMascota;
/*Habilitar la base de datos*/
use TiendaMascota;
/*Creacion de tablas*/
create table Mascota(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);
create table Cliente(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int
);
create table Producto(
codigoProducto int primary key,
nombreProducto varchar (15),
marca varchar (15),
precio float,
cedulaClienteFK int
);
create table Vacuna(
codigoVacuna int primary key,
nombreVacuna varchar (15),
dosisVacuna int (10),
enfermedad varchar (15)
);
create table Mascota_Vacuna(
codigoVacunaFK int,
idMascotaFK int,
enfermedad varchar (15)
);
/*crear las relaciones*/
alter table Cliente
add constraint FClienteMascota
foreign key (idMascotaFK)
references Mascota(idMascota);

alter table Producto
add constraint FKProductoCliente
foreign key (cedulaClienteFK)
references Cliente(cedulaCliente);

alter table Mascota_Vacuna
add constraint FKMV
foreign key (idMascotaFK)
references Mascota(idMascota );

alter table Mascota_Vacuna
add constraint FKVM
foreign key (codigoVacunaFK)
references Vacuna(codigoVacuna);

/* nombreTabla (VAN LOS CAMPOR COMO LOS CREE EN LA TABLA)  values(valor1, valor2, 'valor3').
*/
describe Mascota;

insert into mascota (idMascota, nombreMascota,generoMascota,razaMascota,cantidad) values(1,'Rush','Macho','criollo',1);
insert into mascota values(2,'Macarena','Hembra','Criollo',1);

/*consulta general sintaxis: select* from nombrTabala*/

select * from mascota;
insert into mascota values(3,'Lola','F','Pomeranea',1), (4,'Jose','M','Shitzu',3);
insert into mascota values(5,'Libi','F','Pudul',1), (6,'Lalo','M','Shitzu',3),(7,'Lola','F','Pomeranea',1), 
(8,'Jose','M','Shitzu',3),(9,'Lola','F','Pomeranea',1), (10,'Jose','M','Shitzu',3);

insert into Cliente values(101,'Lola','Camacho','calle 13',3220992, 1);
insert into Cliente values(102,'Nina','Colmen','calle 14',3220977, 2),(103,'Luis','Peraz','calle 15',3299992, 3),
(104,'Lucho','Perez','calle 15',2299992, 4),(105,'Luna','Peña','calle 40',3049992, 5),(106,'Juan','Nuñez','calle 78',329999009, 6),
(107,'Juana','Corral','calle 45',3119982,7);

insert into Producto values(1,'Shampoo','Suavitel','45000',101),(2,'Shampoo','Suavitel','45000',102),(3,'Jabón','Suavitel','27000',103);


