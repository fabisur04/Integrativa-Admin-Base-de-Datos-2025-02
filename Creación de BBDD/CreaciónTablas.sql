

CREATE DATABASE IntegrativaAdminBBDD;
GO

USE IntegrativaAdminBBDD;
GO

-- 1. Tablas de Ubicación
CREATE TABLE Ciudad (
    id_ciudad TINYINT PRIMARY KEY,
    nombre_ciudad NCHAR(50) NOT NULL
);

CREATE TABLE Comuna (
    id_comuna TINYINT PRIMARY KEY,
    id_ciudad TINYINT NOT NULL,
    nombre_comuna VARCHAR(100) NOT NULL,
    CONSTRAINT FK_Comuna_Ciudad FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad)
);

CREATE TABLE Cliente (
    rut_cliente NCHAR(10) PRIMARY KEY, 
    nombre_cliente NCHAR(50) NOT NULL,
    id_comuna TINYINT NOT NULL,
    calle NCHAR(80) NOT NULL,
    numero NCHAR(20) NOT NULL,
    codigo_postal INT NOT NULL, 
    CONSTRAINT FK_Cliente_Comuna FOREIGN KEY (id_comuna) REFERENCES Comuna(id_comuna)
);

CREATE TABLE Telefono (
    rut_cliente NCHAR(10) NOT NULL,
    numero_telefono NCHAR(15) NOT NULL,
    CONSTRAINT PK_Telefono PRIMARY KEY (rut_cliente, numero_telefono),
    CONSTRAINT FK_Telefono_Cliente FOREIGN KEY (rut_cliente) REFERENCES Cliente(rut_cliente)
);

CREATE TABLE Proveedor (
    rut_proveedor NCHAR(10) PRIMARY KEY,
    nombre_proveedor NCHAR(50) NOT NULL,
    id_comuna TINYINT NOT NULL,
    calle NCHAR(80) NOT NULL,
    numero NCHAR(20) NOT NULL,
    telefono NCHAR(15) NULL,
    web VARCHAR(255) NULL,
    codigo_postal INT NOT NULL, 
    CONSTRAINT FK_Proveedor_Comuna FOREIGN KEY (id_comuna) REFERENCES Comuna(id_comuna)
);

CREATE TABLE Categoria (
    id_categoria TINYINT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE Producto (
    id_producto INT PRIMARY KEY,
    id_categoria TINYINT NOT NULL,
    nombre_producto VARCHAR(150) NOT NULL,
    precio_producto DECIMAL(10, 2) NOT NULL,
    stock_producto INT NOT NULL,
    CONSTRAINT FK_Producto_Categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
    CONSTRAINT CHK_Stock_Positivo CHECK (stock_producto >= 0),
    CONSTRAINT CHK_Precio_Positivo CHECK (precio_producto > 0)
);

CREATE TABLE Proveedor_Producto (
    rut_proveedor NCHAR(10) NOT NULL, 
    id_producto INT NOT NULL,
    ind_vigente BIT NOT NULL DEFAULT 1,
    fecha_ultima_compra DATE NULL,
    CONSTRAINT PK_Proveedor_Producto PRIMARY KEY (rut_proveedor, id_producto),
    CONSTRAINT FK_ProvProd_Proveedor FOREIGN KEY (rut_proveedor) REFERENCES Proveedor(rut_proveedor),
    CONSTRAINT FK_ProvProd_Producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- 5. Tablas Transaccionales
CREATE TABLE Boleta (
    id_venta BIGINT PRIMARY KEY,         
    rut_cliente NCHAR(10) NOT NULL, 
    fecha_venta DATE NOT NULL,
    descuento_venta DECIMAL(5, 2) NOT NULL DEFAULT 0,
    monto_final DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_Boleta_Cliente FOREIGN KEY (rut_cliente) REFERENCES Cliente(rut_cliente),
    CONSTRAINT CHK_Monto_Final_Positivo CHECK (monto_final >= 0),
    CONSTRAINT CHK_Descuento_Valido CHECK (descuento_venta BETWEEN 0 AND 1)
);

CREATE TABLE Detalle_boleta (
    correlativo_detalle BIGINT PRIMARY KEY, 
    id_venta BIGINT NOT NULL,
    id_producto INT NOT NULL,
    precio_venta DECIMAL(10, 2) NOT NULL,
    cantidad_producto INT NOT NULL,
    CONSTRAINT FK_Detalle_Boleta FOREIGN KEY (id_venta) REFERENCES Boleta(id_venta),
    CONSTRAINT FK_Detalle_Producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    CONSTRAINT CHK_PrecioVenta_Positivo CHECK (precio_venta > 0),
    CONSTRAINT CHK_Cantidad_Positiva CHECK (cantidad_producto > 0)
);
GO
