USE IntegrativaAdminBBDD;
GO


INSERT INTO Ciudad VALUES (1, 'Santiago'), (2, 'Valparaíso'), (3, 'Concepción');
INSERT INTO Comuna VALUES (1, 1, 'Providencia'), (2, 1, 'Las Condes'), (3, 1, 'Santiago Centro'), (4, 2, 'Viña del Mar'), (5, 2, 'Valparaíso'), (6, 3, 'Talcahuano');

INSERT INTO Categoria VALUES (1, 'Electrónica'), (2, 'Librería'), (3, 'Hogar');
INSERT INTO Producto VALUES 
(101, 1, 'Notebook 14" Core i5', 599990.00, 15),
(102, 1, 'Monitor Curvo 27"', 249990.00, 25),
(103, 1, 'Mouse Ergonómico', 19990.00, 50),
(201, 2, 'Cuaderno 100 Hojas', 2500.00, 100),
(202, 2, 'Set Lápices 24u', 5990.00, 80),
(301, 3, 'Juego Sábanas 2P', 29990.00, 30);

INSERT INTO Cliente (rut_cliente, nombre_cliente, id_comuna, calle, numero, codigo_postal) VALUES
('12345678-9', 'Ana Torres', 1, 'Av. Providencia', '123', 7500000),
('98765432-1', 'Bruno Díaz', 2, 'Apoquindo', '4560', 7550000),
('11223344-K', 'Carla Soto', 5, 'Calle Esmeralda', '789', 2340000);

INSERT INTO Telefono VALUES 
('12345678-9', '+56911112222'), 
('12345678-9', '223334455'), 
('98765432-1', '+56933334444');

INSERT INTO Proveedor (rut_proveedor, nombre_proveedor, id_comuna, calle, numero, telefono, web, codigo_postal) VALUES
('76111222-3', 'TecnoGlobal S.A.', 3, 'Alameda', '1000', '+56255556666', 'http://tecnoglobal.cl', 8320000),
('77333444-5', 'Librería Central', 1, 'Nva Providencia', '2020', '+56277778888', 'http://libcentral.cl', 7500000),
('78555666-7', 'DecoHogar Import', 2, 'Av. Vitacura', '3000', '+56299990000', 'http://decohogar.cl', 7550000);

INSERT INTO Proveedor_Producto VALUES 
('76111222-3', 101, 1, '2025-10-15'),
('76111222-3', 102, 1, '2025-10-15'),
('77333444-5', 201, 1, '2025-09-30'),
('78555666-7', 301, 1, '2025-11-01');

INSERT INTO Boleta VALUES 
(1001, '12345678-9', '2025-11-05', 0.10, 557982.00),
(1002, '98765432-1', '2025-11-06', 0.00, 24480.00),
(1003, '11223344-K', '2025-11-07', 0.00, 59980.00);

INSERT INTO Detalle_boleta VALUES 
(1, 1001, 101, 599990.00, 1),
(2, 1001, 103, 19990.00, 1),
(3, 1002, 201, 2500.00, 5),
(4, 1002, 202, 5990.00, 2),
(5, 1003, 301, 29990.00, 2);
GO
