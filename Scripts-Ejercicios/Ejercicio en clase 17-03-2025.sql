/*CONSULTAS*/
create database ejercicioEnClase;
use ejercicioEnClase;

create table Cliente(
codigoCliente int auto_increment primary key,
nombreCliente varchar(50) not null,
domicilio varchar(50) not null,
ciudad varchar(50) not null,
provincia varchar(50) not null,
telefonoCliente varchar(50) not null
); 

insert into Cliente values(' ','Lola','calle 13','Bogotá','usme', 30058735), 
(' ','Mariana','carrera 57','Bogotá','rafael uribe uribe', 37398735), (' ','Daniel','calle 89','Bogotá','Kenedy', 330389925), 
(' ','Sergio','carrera 45','Bogotá','Bosa', 306679927), (' ','Lina','calle 40 sur','Bogotá','Rafael Uribe Uribe', 3044685621);

/*Consulta general: Slect*/
select * from cliente;       

/*Consulta específica*/
select codigoCliente,nombreCliente from cliente;

/*Clausula where condicioes operadores logicos (or (o) and (y) negacion(not), 
aritmeticos (+ - * / mod ,comparazión (= <> < > <= >= ==)*/
select * from cliente where nombreCliente='Lola';
select domicilio from cliente where nombreCliente='Lola' or codigoCliente=5;
select * from cliente where nombreCliente<>'Lola';
select * from cliente where not nombreCliente='Lola';

/*Alias : me permite cambiar los nombres de los campos para verlos diferentes*/
/*select campo1 as 'nombre que quiero mostrar' from nombreTabla*/
select nombreCliente as 'Nombre Cliente', domicilio as 'Dirección', ciudad as 'Ciudad' from Cliente;
select provincia as 'Localidad', telefonoCliente as ' Telefono' from Cliente;
describe cliente; /*Consultar campos*/

/*Ordenar Consultas: order by asc desc*/
/*select (*o campos) from nombreTabla order by a campoOrdenar tipoOrden*/

select * from Cliente order by telefonoCliente asc;
select * from Cliente order by telefonoCliente desc;

select nombreCliente as 'Nombre Cliente', domicilio, ciudad, telefonoCliente 
from Cliente where nombreCliente='Lola' order by telefonoCliente asc;

/*Consultas agrupando: group by*/
/*select camposAgrupar from nombreTabla consdición group by campoAgrupar orden*/
select telefonoCliente as 'Telefono', domicilio,provincia,telefonoCliente,nombreCliente from Cliente where ciudad='Bogotá' group by ciudad asc;

/*like not like: select camposConsultar from nombrTbale condición like valorConsultar */
select * from Cliente where nombreCliente like '%a%'; /*Que contenga a*/
select * from Cliente where nombreCliente like 'L%'; /*Que empiece con L*/
select * from Cliente where nombreCliente like '%a'; /*Que termne con a*/
select * from Cliente where nombreCliente like '%na%'; /*Que contenga na*/

