

create database DataVerse;
use DataVerse;

/*Creación Tablas */
create table Sensores(
 id_sensor int auto_increment primary key,
 tipoSen int not null,
 ubicacion varchar(20),
 fecha_instalacion date
);

create table Registros_Sensores(
id_registro int auto_increment primary key,
id_sensorFK int not null,
valor double not null,
fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
foreign key (id_sensorFK) references sensores(id_sensor)
);


create table Transporte(
id_transporte int auto_increment primary key,
tipo varchar(30) not null,
capacidad int not null
);


create table Usuarios(
id_usuario int auto_increment primary key,
nombre varchar(20),
email varchar(30),
id_transporteFK int not null,
foreign key (id_transporteFK) references Transporte(id_transporte)
);

create table detallesSensor(
 id_detSen int auto_increment primary key,
 id_usuarioFK int not null,
 id_sensorFK int not null,
 foreign key (id_usuarioFK) references Usuario(id_usuario),
 foreign key (id_sensorFK) references Sensores(id_sensor)
);


create table Consumo_Energetico(
id_registro int auto_increment primary key,
zona VARCHAR(10) NOT NULL,
consumo_kw decimal(10,2) not null,
fecha date not null
);

create table DetallesTansporteConsu(
idTransporteConsu int auto_increment primary key,
id_transporteFK int not null,
id_consumoFK int not null,
foreign key (id_transporteFK) references Transporte(id_transporte),
foreign key (id_consumoFK) references Consumo_Energetico(id_registro)
);


create table Seguridad(
id_evento int auto_increment primary key,
tipo_evento int not null,
descripcion varchar(50) null,
fecha_hora datetime not null,
ubicacion varchar(20)
);

create table seguridadDet(
 idSeguridadDet int auto_increment primary key,
 id_usuarioFK int not null,
 id_seguridadFK not null,
 foreign key (id_usuarioFK) references Usuarios(id_usuario),
 foreign key (id_seguridadFK) references Seguridad(id_evento)
 );

#Modifique la tabla Usuario y cree un campo teléfono.
alter table Usuarios add telefono int;

#Inserción registros
describe seguridad;
insert into Transporte values ('','Carro', 4),('','Bus', 100),('','Moto', 2),('','Bici', 1),('','Avion', 100);
insert into Usuarios values ('','Luna','luna@gmail.com',1,30458889), ('','Lina','lina@gmail.com',2,30459099),
('','Luis','luis@gmail.com',1,30450009),('','Luciano','luciano@gmail.com',3,36650009),('','Lumier','lumier@gmail.com',4,34450009);
insert into sensores values ('',1,'calle 13','2024-04-15'), ('',2,'calle 40','2023-04-15'), ('',3,'calle 22','2024-07-15'),
 ('',1,'calle 40','2023-06-18'), ('',2,'calle 20','2025-01-15');
insert into Registros_Sensores values ('',1,45677,''),('',2,4500,''),('',3,89677,''),('',4,458888,''),('',5,2677,''),('',1,45997,'');
insert into Consumo_Energetico values ('','A',1987.78, '2024-02-15'), ('','B',144444.78, '2024-04-17'),
('','C',20000.78, '2024-04-13'),('','D',999987.78, '2024-05-15'),('','E',40987.78, '2024-06-11');
insert into seguridad values ('',2,null,'2024-04-13',null),('',1,null,'2022-04-15',null),
('',1,null,'2023-04-17',null),('',3,null,'2022-04-16',null),('',4,null,'2024-06-14',null);


#Crear detalles sensores y detalles seguridad

/*Actualiza los registros de Consumo_Energetico para incrementar en un 10% el consumo en una
zona específica*/

select * from Registros_Sensores;


#Encuentra todos los registros de sensores donde el valor sea mayor a 50 y el tipo de sensor sea 
#'temperatura'. Excluye valores NULL en valor.
select r.*, s.*  from Registros_Sensores r inner join sensores s on r.id_sensorFK = s.id_sensor where r.valor > 50 and s.tipoSen = 1;

/*Actualiza los registros de Consumo_Energetico para incrementar en un 10% el consumo en una
zona específica*/
update Consumo_Energetico set Consumo_Energetico.consumo_kw = Consumo_Energetico.consumo_kw*0.1 where zona = 'A';

/*Muestra la cantidad de eventos de seguridad por tipo de evento. Incluye solo los tipos de
eventos que han ocurrido más de 5 veces*/
select id_evento, count(tipo_evento) as Cantidad_eventos from Seguridad group by tipo_evento order by cantidad_eventos desc;


/*Muestra el consumo energético diario promedio por zona, redondeado a 2 decimales y con alias
Promedio_Consumo.
*/
select zona, avg(consumo_kw), year(fecha) as Promedio_Consumo from Consumo_Energetico group by zona;

/*Encuentra las zonas donde el consumo energético promedio es mayor a 2000 kW.*/
select zona from Consumo_Energetico where consumo_kw > 20000;

select u.id_usuario, c.zona from 

/*Encuentra los usuarios que usan transporte público en una zona donde el consumo energético
ha sido alto en la última semana.*/
select u.id_usuario, c.consumo_kw from Usuarios u inner join transporte T on id_transporteFK = id_transporte inner join detallestrasnporteCon d on 
d.id_trasnporteFK = t.idtrasnporte inner join 



