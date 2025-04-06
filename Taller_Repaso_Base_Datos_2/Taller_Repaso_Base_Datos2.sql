create database biblioteca_OnlineBD;
use biblioteca_OnlineBD;
 
create table Cliente(
idCliente int auto_increment primary key,
nombreCliente varchar(30) not null
);

create table Pedido(
idPedido int auto_increment primary key,
fechaPedido date not null,
idClienteFK int not null,
foreign key (idClienteFK) references Cliente(idCliente)
);

create table Libro(
idLibro int auto_increment primary key,
tituloLibro varchar(30) not null,
stock int not null,
precio double not null
);

create table DetallesPedidos(
idDetallePedido int auto_increment primary key,
idPedidoFK int not null,
idLibroFK int not null,
foreign key (idPedidoFK) references Pedido(idPedido),
foreign key (idLibroFK) references Libro(idLibro)
);

insert into cliente values ('','Juan Peña'),('','Juana Peñalosa'),('','Juanita Barreto'),
('','Julio Díaz'),('','Gilberto Rueda');

insert into Libro values ('','Mil años si ti',40,20000),('','100 años de soledad',20,50000),('','Una educación',25,4000),
('','Como agua para chocolate',15,57000), ('','Drácula',10,35000), ('','Un beso bajo la lluvia',5,17000);

insert into pedido values ('','2024-12-02',1),('','2023-14-03',2),('','2024-10-02',3),
('','2022-08-03',4),('','2023-12-02',5),('','2024-12-03',1);

insert into DetallesPedidos values ('',1,1),('',1,2),('',1,3),('',2,2),('',2,3),('',3,4),
('',4,5),('',5,4);

/*Actualizar el stock de los libros una vez que se realice un pedido.*/
DELIMITER //
create trigger ActualizarStock
after insert on detallesPedidos
for each row
begin
	update Libro
    set stock= stock - 1
    where idLibro=new.idLibroFK;
end//
DELIMITER ;
insert into DetallesPedidos values ('',6,1);

/*listar los pedidos hechos por un cliente específico y obtener detalles de los libros comprados.*/
DELIMITER //
CREATE PROCEDURE PedidosPorCliente(in p_idCliente int)
BEGIN
-- instrucciones de SQL 
	Select idCliente, nombreCliente, l.*, p.* from Cliente c left join Pedido p on c.idCliente = p.idClienteFK left join 
    DetallesPedidos on DetallesPedidos.idPedidoFK = p.idPedido inner join Libro l on l.idLibro = DetallesPedidos.idLibroFK
    where c.idCliente = p_idCliente group by c.idCliente, l.idLibro, p.idPedido;
END // 
DELIMITER ;
call PedidosPorCliente(1);

/*Consultar el cliente que ha realizado el mayor número de pedidos*/
select nombreCliente, count(p.idPedido) as CantidadPedidos from Cliente c inner join Pedido p 
on c.idCliente = p.idClienteFK group by c.nombreCliente order by CantidadPedidos desc limit 1;

/*Crear un procedimiento almacenado que permita registrar un nuevo pedido, actualizando la 
tabla de pedidos y reduciendo el stock del libro correspondiente.*/
DELIMITER //
CREATE PROCEDURE RegistrarPedido(in p_fecha date, in p_idCliente int , in p_idLibro int)
BEGIN
-- instrucciones de SQL 
	declare nuevo_idPedido int;
    insert into pedido values ('',p_fecha, p_idCliente);
    -- Obtener el id del nuevo pedido generado
    SET nuevo_idPedido = LAST_INSERT_ID();
    insert detallesPedidos values ('',nuevo_idPedido, p_idLibro);
    select * from Pedido;
END // 
DELIMITER ;
call RegistrarPedido('2025-03-14', 3,3);
 
/*Selecciona los libros cuyo precio sea mayor a $20.000*/
select tituloLibro from libro where precio > 20000;

/*Selecciona los pedidos realizados después del 1 de octubre de 2024*/
select * from pedido where fechaPedido > '2024-10-1';
 
/*Selecciona todos los libros ordenados por su precio de mayor a menor*/
select * from Libro order by precio desc;

/*Obtén el total de clientes registrados en la tabla clientes. 
Obtén el total de unidades vendidas en la tabla pedidos*/
select count(*) from Cliente;
select count(*) from DetallesPedidos;

/*Muestra el número de pedidos realizados por cada cliente.*/
select c.nombreCliente, count(p.idPedido) as Numero_Pedidos from cliente c join
pedido p on c.idCliente = p.idClienteFK group by c.idCliente;

/*Muestra el nombre del cliente, el título del libro y la cantidad de cada pedido*/
select c.nombreCliente, l.tituloLibro, count(dp.idDetallePedido) as CantidadLibros from Cliente c join pedido p on
c.idCliente = p.idClienteFK join detallesPedidos dp on p.idPedido = dp.idPedidoFK join Libro l on 
l.idLibro = dp.idLibroFK group by c.idCliente, l.tituloLibro;

/*Muestra los títulos de los libros y la cantidad total vendida de cada uno.*/
select l.tituloLibro, count(dp.idDetallePedido) as Cantidad_Vendida from Libro l left join DetallesPedidos dp 
on l.idLibro = dp.idLibroFK group by l.tituloLibro;
