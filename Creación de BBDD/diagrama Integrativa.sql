CREATE TABLE [Proveedor] (
  [rut_proveedor] nchar(15) PRIMARY KEY,
  [nombre_proveedor] nchar(50) NOT NULL,
  [id_comuna] tinyint NOT NULL,
  [calle] nchar(50) NOT NULL,
  [numero] nchar(25) NOT NULL,
  [web] nchar(150),
  [codigo_postal] int NOT NULL
)
GO

CREATE TABLE [Comuna] (
  [id_comuna] tinyint PRIMARY KEY,
  [id_ciudad] tinyint NOT NULL,
  [nombre_comuna] nchar(50) NOT NULL
)
GO

CREATE TABLE [Ciudad] (
  [id_ciudad] tinyint PRIMARY KEY,
  [nombre_ciudad] nchar(50) NOT NULL
)
GO

CREATE TABLE [Cliente] (
  [rut_cliente] nchar(15) PRIMARY KEY,
  [nombre_cliente] nchar(50) NOT NULL,
  [id_comuna] tinyint NOT NULL,
  [calle] nchar(50) NOT NULL,
  [numero] nchar(25) NOT NULL,
  [codigo_postal] int NOT NULL
)
GO

CREATE TABLE [Telefono] (
  [numero_telefono] nchar(15) PRIMARY KEY,
  [rut_cliente] nchar(15) NOT NULL
)
GO

CREATE TABLE [Categoria] (
  [id_categoria] tinyint PRIMARY KEY,
  [nombre_categoria] nchar(50) NOT NULL
)
GO

CREATE TABLE [Producto] (
  [id_producto] int PRIMARY KEY,
  [id_categoria] tinyint NOT NULL,
  [nombre_producto] nchar(100) NOT NULL,
  [precio_producto] decimal NOT NULL,
  [stock_producto] int NOT NULL
)
GO

CREATE TABLE [Proveedor_Producto] (
  [id_producto] int NOT NULL,
  [rut_proveedor] nchar(15) NOT NULL,
  [ind_vigente] bit NOT NULL,
  [fecha_ultima_compra] date NOT NULL
)
GO

CREATE TABLE [Detalle_boleta] (
  [correlativo_detalle] bigint PRIMARY KEY,
  [id_venta] bigint NOT NULL,
  [id_producto] int NOT NULL,
  [precio_venta] decimal NOT NULL,
  [cantidad_producto] int NOT NULL
)
GO

CREATE TABLE [Boleta] (
  [id_venta] bigint PRIMARY KEY,
  [rut_cliente] nchar(15) NOT NULL,
  [fecha_venta] date NOT NULL,
  [descuento_venta] decimal NOT NULL
)
GO

ALTER TABLE [Proveedor_Producto] ADD FOREIGN KEY ([rut_proveedor]) REFERENCES [Proveedor] ([rut_proveedor])
GO

ALTER TABLE [Proveedor_Producto] ADD FOREIGN KEY ([id_producto]) REFERENCES [Producto] ([id_producto])
GO

ALTER TABLE [Producto] ADD FOREIGN KEY ([id_categoria]) REFERENCES [Categoria] ([id_categoria])
GO

ALTER TABLE [Detalle_boleta] ADD FOREIGN KEY ([id_venta]) REFERENCES [Boleta] ([id_venta])
GO

ALTER TABLE [Boleta] ADD FOREIGN KEY ([rut_cliente]) REFERENCES [Cliente] ([rut_cliente])
GO

ALTER TABLE [Cliente] ADD FOREIGN KEY ([id_comuna]) REFERENCES [Comuna] ([id_comuna])
GO

ALTER TABLE [Comuna] ADD FOREIGN KEY ([id_ciudad]) REFERENCES [Ciudad] ([id_ciudad])
GO

ALTER TABLE [Telefono] ADD FOREIGN KEY ([rut_cliente]) REFERENCES [Cliente] ([rut_cliente])
GO

ALTER TABLE [Proveedor] ADD FOREIGN KEY ([id_comuna]) REFERENCES [Comuna] ([id_comuna])
GO

ALTER TABLE [Detalle_boleta] ADD FOREIGN KEY ([id_producto]) REFERENCES [Producto] ([id_producto])
GO
