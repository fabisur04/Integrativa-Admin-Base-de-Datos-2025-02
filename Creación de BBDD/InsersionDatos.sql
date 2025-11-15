

USE IntegrativaAdminBBDD;
GO

INSERT INTO Ciudad (id_ciudad, nombre_ciudad) VALUES
(1, N'Santiago'),
(2, N'Valparaíso'),
(3, N'Concepción');

INSERT INTO Comuna (id_comuna, id_ciudad, nombre_comuna) VALUES
(1, 1, 'Providencia'),
(2, 1, 'Las Condes'),
(3, 1, 'Santiago Centro'),
(4, 2, 'Viña del Mar'),
(5, 2, 'Valparaíso'),
(6, 3, 'Talcahuano');
GO

INSERT INTO Categoria (id_categoria, nombre_categoria) VALUES
(1, 'Electrónica'),
(2, 'Librería'),
(3, 'Hogar y Decoración');

INSERT INTO Producto (id_producto, id_categoria, nombre_producto, precio_producto, stock_producto) VALUES
(101, 1, 'Notebook 14" Core i5 16GB RAM', 599990.00, 15),
(102, 1, 'Monitor Curvo 27" 144Hz', 249990.00, 25),
(103, 1, 'Mouse Inalámbrico Ergonómico', 19990.00, 50),
(201, 2, 'Cuaderno Universitario 100 Hojas', 2500.00, 100),
(202, 2, 'Set Lápices Colores 24 Unidades', 5990.00, 80),
(301, 3, 'Juego de Sábanas 2 Plazas', 29990.00, 30);
GO

INSERT INTO Cliente (rut_cliente, nombre_cliente, id_comuna, calle, numero) VALUES
('1234567890', N'Ana Torres', 1, N'Av. Providencia', N'123'),
('9876543210', N'Bruno Díaz', 2, N'Apoquindo', N'4560'),
('112223330K', N'Carla Soto', 5, N'Calle Esmeralda', N'789');


INSERT INTO Telefono (rut_cliente, numero_telefono) VALUES
('1234567890', N'+56911112222'),
('1234567890', N'223334455'),
('9876543210', N'+56933334444');

INSERT INTO Proveedor (rut_proveedor, nombre_proveedor, id_comuna, calle, numero, telefono, web) VALUES
('76111222-3', N'TecnoGlobal S.A.', 3, N'Alameda', N'1000', N'+56255556666', 'http://tecnoglobal.cl'),
('77333444-5', N'Librería Central Ltda.', 1, N'Nueva Providencia', N'2020', N'+56277778888', 'http://libcentral.cl'),
('78555666-7', N'DecoHogar Importaciones', 2, N'Av. Vitacura', N'3000', N'+56299990000', 'http://decohogar.cl');
GO

INSERT INTO Proveedor_Producto (rut_proveedor, id_producto, ind_vigente, fecha_ultima_compra) VALUES
('76111222-3', 101, 1, '2025-10-15'),
('76111222-3', 102, 1, '2025-10-15'),
('77333444-5', 201, 1, '2025-09-30'),
('78555666-7', 301, 1, '2025-11-01');
GO


INSERT INTO Boleta (id_venta, rut_cliente, fecha_venta, descuento_venta, monto_final) VALUES
('F-1001', '1234567890', '2025-11-05', 0.10, 557982.00); -- Total calculado con 10% dcto

INSERT INTO Detalle_boleta (correlativo_detalle, id_venta, id_producto, precio_venta, cantidad_producto) VALUES
('D-1001-1', 'F-1001', 101, 599990.00, 1),
('D-1001-2', 'F-1001', 103, 19990.00, 1);

INSERT INTO Boleta (id_venta, rut_cliente, fecha_venta, descuento_venta, monto_final) VALUES
('F-1002', '9876543210', '2025-11-06', 0.00, 24480.00); -- Total sin dcto

INSERT INTO Detalle_boleta (correlativo_detalle, id_venta, id_producto, precio_venta, cantidad_producto) VALUES
('D-1002-1', 'F-1002', 201, 2500.00, 5),
('D-1002-2', 'F-1002', 202, 5990.00, 2);

INSERT INTO Boleta (id_venta, rut_cliente, fecha_venta, descuento_venta, monto_final) VALUES
('F-1003', '112223330K', '2025-11-07', 0.00, 59980.00);

INSERT INTO Detalle_boleta (correlativo_detalle, id_venta, id_producto, precio_venta, cantidad_producto) VALUES
('D-1003-1', 'F-1003', 301, 29990.00, 2);
GO

