-- =============================================
-- 1. TABLAS MAESTRAS (Geográficas y Categorías)
-- =============================================

-- Insertar Ciudades
INSERT INTO Ciudad (id_ciudad, nombre_ciudad) VALUES 
(1, 'Santiago'),
(2, 'Valparaíso'),
(3, 'Concepción');

-- Insertar Comunas (Dependen de Ciudad)
INSERT INTO Comuna (id_comuna, id_ciudad, nombre_comuna) VALUES 
(10, 1, 'Cerrillos'),
(11, 1, 'Providencia'),
(12, 1, 'Santiago Centro'),
(20, 2, 'Viña del Mar'),
(30, 3, 'Talcahuano');

-- Insertar Categorías
INSERT INTO Categoria (id_categoria, nombre_categoria) VALUES 
(1, 'Electrónica'),
(2, 'Línea Blanca'),
(3, 'Computación'),
(4, 'Hogar');

-- =============================================
-- 2. ENTIDADES PRINCIPALES (Productos y Personas)
-- =============================================

-- Insertar Productos
-- Formato: id_producto, id_categoria, nombre, precio, stock
INSERT INTO Producto (id_producto, id_categoria, nombre_producto, precio_producto, stock_producto) VALUES 
(100, 1, 'Smart TV 50 Pulgadas 4K', 350000, 20),
(101, 1, 'Audífonos Bluetooth Noise Cancelling', 45000, 50),
(200, 2, 'Refrigerador No Frost 300L', 420000, 10),
(201, 2, 'Lavadora Carga Frontal 9kg', 280000, 15),
(300, 3, 'Notebook Gamer i7 16GB RAM', 890000, 5),
(301, 3, 'Mouse Ergonómico Inalámbrico', 15000, 100);

-- Insertar Proveedores
-- Nota: codigo_postal es tinyint, usamos valores pequeños referenciales.
INSERT INTO Proveedor (rut_proveedor, nombre_proveedor, id_comuna, calle, numero, web, codigo_postal) VALUES 
('76.123.456-1', 'TecnoImport SpA', 11, 'Av. Providencia', '1234', 'www.tecnoimport.cl', 80),
('77.987.654-K', 'Distribuidora Hogar Feliz', 10, 'Av. Pedro Aguirre Cerda', '5500', NULL, 92),
('78.555.444-2', 'CompuGlobal HyperMegaNet', 12, 'Calle Huérfanos', '890', 'www.compuglobal.com', 83);

-- Insertar Clientes
INSERT INTO Cliente (rut_cliente, nombre_cliente, id_comuna, calle, numero, codigo_postal) VALUES 
('15.345.678-9', 'Juan Pérez', 10, 'Los Presidentes', '101', 92),
('18.987.654-3', 'María González', 20, 'Av. Libertad', '500', 25),
('12.111.222-4', 'Carlos Tapia', 12, 'Calle San Diego', '202', 83);

-- Insertar Teléfonos (Dependen de Cliente)
INSERT INTO Telefono (numero_telefono, rut_cliente) VALUES 
('+56911112222', '15.345.678-9'), -- Celular de Juan
('+56225556666', '15.345.678-9'), -- Casa de Juan
('+56933334444', '18.987.654-3'), -- Celular de María
('+56955556666', '12.111.222-4'); -- Celular de Carlos

-- =============================================
-- 3. RELACIONES Y TRANSACCIONES
-- =============================================

-- Relación Proveedor - Producto
-- Quién surte qué producto y desde cuándo
INSERT INTO Proveedor_Producto (id_producto, rut_proveedor, ind_vigente, fecha_ultima_compra) VALUES 
(100, '76.123.456-1', 1, '2025-10-01'), -- TecnoImport provee TV
(101, '76.123.456-1', 1, '2025-10-05'), -- TecnoImport provee Audífonos
(200, '77.987.654-K', 1, '2025-09-20'), -- Hogar Feliz provee Refrigerador
(201, '77.987.654-K', 0, '2024-12-15'), -- Hogar Feliz proveía Lavadoras (Ya no vigente)
(300, '78.555.444-2', 1, '2025-11-01'); -- CompuGlobal provee Notebooks

-- Insertar Ventas (Boletas)
-- Nota: Si id_venta es IDENTITY, elimina la columna id_venta en el INSERT. Aquí asumo inserción manual.
INSERT INTO Boleta (id_venta, rut_cliente, fecha_venta, descuento_venta) VALUES 
(5001, '15.345.678-9', '2025-11-01', 0),    -- Juan compró sin descuento
(5002, '18.987.654-3', '2025-11-02', 5000), -- María compró con 5000 de descuento
(5003, '15.345.678-9', '2025-11-15', 0);    -- Juan volvió a comprar

-- Insertar Detalle de Boleta
-- Aquí desglosamos qué compró cada uno
INSERT INTO Detalle_boleta (correlativo_detalle, id_venta, id_producto, precio_venta, cantidad_producto) VALUES 
-- Boleta 5001: Juan compró un TV y unos audífonos
(1, 5001, 100, 350000, 1), 
(2, 5001, 101, 45000, 2),

-- Boleta 5002: María compró un Notebook
(3, 5002, 300, 890000, 1),

-- Boleta 5003: Juan compró solo un Mouse
(4, 5003, 301, 15000, 1);