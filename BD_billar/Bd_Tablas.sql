--Nombre de la base de datos bd_billar
--Fecha de creación de la base de datos 28.03.2021
--Fecha de entrega 04.05.2021
--Número de equipo Equipo #6

--CREACION DE LA BASE DE DATOS

CREATE DATABASE [bd_billar]
GO
USE bd_billar;
GO
--CREACION TABLAS DE LA BD
CREATE TABLE [dbo].[Rol](
	[Id_Rol] [int] IDENTITY(1,1),
	[Nom_puesto] [varchar](25) NOT NULL,
	[Descrp_rol] [varchar](50) NOT NULL,
	CONSTRAINT pk_rol PRIMARY KEY (Id_Rol)
);

GO
CREATE TABLE [dbo].[Empleado](
	[Id_empleado] [int] IDENTITY(1,1),
	[Nom_empleado] [varchar](25) NOT NULL,
	[apepatEmpleado] [varchar](25) NOT NULL,
	[apematEmpleado] [varchar](25) NOT NULL,
	[telefonoEmpleado] [varchar](25) NOT NULL,
	[direccionEmpleado] [varchar](25) NOT NULL,
	[Id_Rol] [int] NOT NULL CONSTRAINT fk_empleado_rol FOREIGN KEY (Id_Rol) REFERENCES Rol
	CONSTRAINT pk_empleado PRIMARY KEY (Id_empleado)
);
GO

CREATE TABLE [dbo].[Usuario](
	[Id_Usuario] [int] IDENTITY(1,1) NOT NULL,
	[nombre_Usuario] [varchar](25) NOT NULL,
	[Contrasena_Usuario] [varchar](10) NOT NULL,
	[Id_Empleado] [int] NOT NULL,
	CONSTRAINT pk_usuario PRIMARY KEY (Id_Usuario),
	CONSTRAINT fk_usuario_empleado FOREIGN KEY (Id_empleado) REFERENCES Empleado
);

GO
CREATE TABLE [dbo].[Marca](
	[Id_Marca] [int] IDENTITY(1,1),
	[Nom_marca] [varchar](25) NOT NULL,
	CONSTRAINT pk_marca PRIMARY KEY (Id_Marca)
);
GO
CREATE TABLE [dbo].[UnidadMedida](
	[Id_Umed] [int] IDENTITY(1,1),
	[Descripcion_Umed] [varchar](50) NOT NULL,
	[Abreviatura_Umed] [varchar](5) NOT NULL,
	CONSTRAINT pk_umed PRIMARY KEY (Id_Umed)
);
GO

CREATE TABLE [dbo].[Producto](
	[Id_Prod] [int] IDENTITY(1,1),
	[Nom_producto] [varchar](25) NOT NULL,
	[Id_Umed] [int] CONSTRAINT fk_producto_Umed FOREIGN KEY (Id_Umed) REFERENCES UnidadMedida,
	[Existencia] [int] NOT NULL,
	[Id_Marca] [int] CONSTRAINT fk_producto_marca FOREIGN KEY (Id_Marca) REFERENCES Marca,
	[Costo] [money] NOT NULL,
	[Precio] [money]NOT NULL,
	[Descp_producto ] [varchar](50) NOT NULL,
	CONSTRAINT pk_producto PRIMARY KEY (Id_Prod)
);
GO
CREATE TABLE [dbo].[Estado](
	[Id_Estado] [varchar] (1) NOT NULL,
	[Nom_estado] [varchar](11) NOT NULL,
	CONSTRAINT pk_estado PRIMARY KEY (Id_Estado)
);
GO
CREATE TABLE [dbo].[Venta](
	[Id_venta] [int] IDENTITY(1,1),
	[Id_Usuario] [int] NOT NULL CONSTRAINT fk_venta_usuario FOREIGN KEY (Id_Usuario) REFERENCES Usuario,
	[fecha] [date] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Subtotal] [money] NOT NULL,
	[Id_Prod] [int] NOT NULL CONSTRAINT fk_venta_producto FOREIGN KEY (Id_Prod) REFERENCES Producto,
	[Id_Estado] [varchar](1) NOT NULL CONSTRAINT fk_venta_estado FOREIGN KEY (Id_Estado) REFERENCES Estado,
	CONSTRAINT pk_venta PRIMARY KEY (Id_venta)
);
GO
CREATE TABLE [dbo].[Tipo](
	[Id_tipo] [int] IDENTITY(1,1),
	[Nom_tipo] [varchar] (15) NOT NULL,
	CONSTRAINT pk_tipo PRIMARY KEY (Id_tipo)
);

CREATE TABLE [dbo].[Disponibilidad](
	[Id_Disponibilidad] [varchar](2) NOT NULL,
	[Descp_disponibilidad] [varchar] (11) NOT NULL,
	CONSTRAINT pk_disponibilidad PRIMARY KEY (Id_Disponibilidad)
);
GO
CREATE TABLE [dbo].[Mesa](
	[Id_mesa] [int] IDENTITY(1,1),
	[Id_tipo] [int] NOT NULL CONSTRAINT fk_mesa_tipo FOREIGN KEY (Id_tipo) REFERENCES Tipo,
	[Id_Disponibilidad] [varchar] (2) NOT NULL CONSTRAINT fk_mesa_disp FOREIGN KEY (Id_Disponibilidad) REFERENCES Disponibilidad,
	CONSTRAINT pk_mesa PRIMARY KEY (Id_Mesa)
);
GO
CREATE TABLE [dbo].[PagoMesa](
	[Id_pagoMesa] [int] IDENTITY(1,1),
	[Id_Usuario] [int] NOT NULL CONSTRAINT fk_pagoMesa_usuario FOREIGN KEY (Id_Usuario) REFERENCES Usuario,
	[fecha] [date] NOT NULL,
	[Id_mesa] [int] NOT NULL CONSTRAINT fk_pago_mesa FOREIGN KEY (Id_mesa) REFERENCES Mesa,
	[Tiempo_inicio] [time] NOT NULL,
	[Tiempo_fin] [time] NOT NULL,
	[Tiempo_total] [time] NOT NULL,
	[PagoTotal] [money] NOT NULL,
	CONSTRAINT pk_pago_mesa PRIMARY KEY (Id_pagoMesa)
);
GO
--INSERTAR REGISTROS PARA TABLA Rol
--SOLO SE INGRESAN 3 VALORES PORQUE SOLO HAY 3 ROLES EN EL SISTEMA
INSERT INTO Rol VALUES ('Administrador','Control total')
INSERT INTO Rol VALUES ('Cajero','Manejo de dinero')
INSERT INTO Rol VALUES ('Jefe de inventario','Inventario - Gestión de productos')


--INSERTAR 10 REGISTROS PARA TABLA Empleado
INSERT INTO Empleado VALUES('David','Rivera','Perez','225-123-08-44','Lazaro Cardenas No.3',1)
INSERT INTO Empleado VALUES('Juan Manuel','Hernandez','Solis','225-178-70-12','Calle Los Pinos No. 28',2)
INSERT INTO Empleado VALUES('Abigail','Ramirez','Quezada','225-100-14-12','Calle Benito Juarez No.78',2)
INSERT INTO Empleado VALUES('Veronica','Sandoval','Hernandez','225-783-02-14','Calle 22 de Noviembre No.96',2)
INSERT INTO Empleado VALUES('José','Huerta','Carreon','225-123-78-41','Calle Vicente Guerrero No.32',2)
INSERT INTO Empleado VALUES('Pablo','Perdomo','Campos','225-363-50-12','Calle Fco. I Madero No.12',2)
INSERT INTO Empleado VALUES('Esmeralda','Ramos','Arrieta','225-107-56-92','Calle 18 de Marzo No.45',2)
INSERT INTO Empleado VALUES('Manuel','Diaz','Ortiz','225-130-43-48','Calle Plutarco Elias No.2',2)
INSERT INTO Empleado VALUES('Orlando','Soto','Ortiz','225-150-20-74','Calle 16 de Septiembre No.23',3)
INSERT INTO Empleado VALUES('Monserrat','Arellano','Carlos','225-107-78-41','Calle Alamo No.34',3)

--INSERTAR 10 REGISTROS PARA TABLA Usuario
INSERT INTO Usuario VALUES('Admin','A123',1)
INSERT INTO Usuario VALUES('EmpJM','J9H8S7987',2)
INSERT INTO Usuario VALUES('EmpAB','A6R5Q4654',2)
INSERT INTO Usuario VALUES('EmpVE','V3S2H1321',2)
INSERT INTO Usuario VALUES('EmpJO','J9H8C7987',2)
INSERT INTO Usuario VALUES('EmpPA','P6P5C4654',2)
INSERT INTO Usuario VALUES('EmpES','E3R2A1321',2)
INSERT INTO Usuario VALUES('EmpMA','M9D8O7987',2)
INSERT INTO Usuario VALUES('EmpOR','O6S5O4654',3)
INSERT INTO Usuario VALUES('EmpMO','M3A2C1321',3)

--INSERTAR 10 REGISTROS PARA TABLA Marca
INSERT INTO Marca VALUES('Coca Cola')
INSERT INTO Marca VALUES('Pepsi')
INSERT INTO Marca VALUES('Sabritas')
INSERT INTO Marca VALUES('Gatorade')
INSERT INTO Marca VALUES('Bachoco')
INSERT INTO Marca VALUES('Marinela')
INSERT INTO Marca VALUES('Holanda')
INSERT INTO Marca VALUES('Jumex')
INSERT INTO Marca VALUES('Corona')
INSERT INTO Marca VALUES('Barcel')

--INSERTAR REGISTROS PARA TABLA UnidadMedida
--SOLO SE INGRESARON 6 POR LOS TIPOS DE PRODUCTOS QUE SE MANEJAN
INSERT INTO UnidadMedida VALUES ('Kilo', 'Kg')
INSERT INTO UnidadMedida VALUES ('Gramo','g')
INSERT INTO UnidadMedida VALUES ('Miligramo','mg')
INSERT INTO UnidadMedida VALUES ('Pieza', 'Pz')
INSERT INTO UnidadMedida VALUES ('Litro', 'L')
INSERT INTO UnidadMedida VALUES ('mililitro', 'ml')

--INSERTAR REGISTROS PARA TABLA Producto
INSERT INTO Producto VALUES ('Coca cola',6,25,1,15,20,'Coca Cola de 600 ml')
INSERT INTO Producto VALUES ('Sabritas sal',4,18,3,11,15,'Bolsa de sabritas de sal')
INSERT INTO Producto VALUES ('Alitas',1,120,5,150,230,'Alitas en varios sabores')
INSERT INTO Producto VALUES ('Cerveza',5,18,9,30,55,'Vaso de cerveza de 1L')
INSERT INTO Producto VALUES ('Paleta Magnun',4,12,7,19,32,'Paleta Magnum de almendras')
INSERT INTO Producto VALUES ('Jugo Jumex',6,17,7,8,15,'Jugo de durazno de 250 ml')
INSERT INTO Producto VALUES ('Ruffles',4,8,3,12,18,'Bolsa de ruffles')
INSERT INTO Producto VALUES ('Gatorade de uva',5,9,4,15,24,'Gatorade sabor uva de 1L')
INSERT INTO Producto VALUES ('Gansito',4,7,2,7,12,'Gansito marinela de 50g')
INSERT INTO Producto VALUES ('Pepsi',6,14,2,10,15,'Pepsi de 600 ml')

--INSERTAR REGISTROS TIPOS DE MESA
INSERT INTO Tipo VALUES ('Carambola')
INSERT INTO Tipo VALUES ('Americana(Pool)')
INSERT INTO Tipo VALUES ('Inglés(Snooker)')
INSERT INTO Tipo VALUES ('Automática')
INSERT INTO Tipo VALUES ('Con Monedero')
INSERT INTO Tipo VALUES ('Convertible')
INSERT INTO Tipo VALUES ('Fija')
INSERT INTO Tipo VALUES ('Plegable')
INSERT INTO Tipo VALUES ('Multijuego')
INSERT INTO Tipo VALUES ('Portátil')

--INSERTAR REGISTROS PARA TABLA Estado
--SOLO SE AGREGAN 2 VALORES YA QUE SON LAS UNICAS OPCIONES (DATOS POR DEFAULT)
INSERT INTO Estado VALUES ('A','Anulado')
INSERT INTO Estado VALUES ('C','Confirmado')

--INSERTAR REGISTROS PARA TABLA Disponibilidad
--SOLO SE AGREGAN 2 VALORES YA QUE SON LAS UNICAS OPCIONES (DATOS POR DEFAULT)
INSERT INTO Disponibilidad VALUES ('Si','Desocupada')
INSERT INTO Disponibilidad VALUES ('No','Ocupada')

--INSERTAR REGISTROS DE MESAS
INSERT INTO Mesa VALUES (1,'Si')
INSERT INTO Mesa VALUES (2,'Si')
INSERT INTO Mesa VALUES (3,'Si')
INSERT INTO Mesa VALUES (4,'Si')
INSERT INTO Mesa VALUES (5,'Si')
INSERT INTO Mesa VALUES (6,'Si')
INSERT INTO Mesa VALUES (7,'Si')
INSERT INTO Mesa VALUES (8,'Si')
INSERT INTO Mesa VALUES (9,'Si')
INSERT INTO Mesa VALUES (10,'Si')

--DELETE DE UN REGISTRO
DELETE FROM Producto WHERE [Nom_producto]='Pepsi';

--UPDATE DE UN REGISTRO
UPDATE Marca SET Nom_marca='Coca-Cola' WHERE Nom_marca='Coca Cola';

--SELECT PARA LA CONSULTA DE LA TABLA MARCA
SELECT * FROM Marca

--JOIN PARA LA CONSUTA DE 2 TABLAS
 SELECT * FROM   Empleado
         JOIN Rol
           ON Empleado.Id_empleado = Rol.Id_Rol

--INER JOIN PARA LA CONSULTA DE 2 TABLAS
SELECT Id_mesa, Id_Disponibilidad, Nom_tipo FROM Mesa INNER JOIN Tipo ON Mesa.Id_tipo=Tipo.Id_tipo

