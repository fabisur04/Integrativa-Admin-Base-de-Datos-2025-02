--A esto le falta por si acaso
--Solo copie y pegue de gemini
--Tenemos que ver su proposito pero ya es tarde y me quiero dormir ayuda no quiero ser vocal de mesa


--Funcion para calcular el valor total de un producto dependiendo de su cantidad a comprar
CREATE or alter FUNCTION CalcularTotal
(
	@precio int,
	@Cantidad int
)
RETURNS decimal(10,2)
AS
BEGIN
	declare @valor decimal(10,2)=(@precio *@Cantidad)
	RETURN @valor
END
GO

--Fucion para calcular el valor total de un producto que se encuentra en inventario
CREATE or alter FUNCTION CalcularTotalEnInventario
(
	@ID_producto int
)
RETURNS decimal(10,2)
AS
BEGIN
	declare @valor decimal(10,2)

	select @valor=pro.precio_producto*pro.stock_producto
	from Producto pro
	where @ID_producto = pro.id_producto

	RETURN @valor
END
GO

--SP
CREATE or alter PROCEDURE MostrarClientesFrecuentes
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        -- FUNCIONES DE CADENA (3+) [cite: 61]
        UPPER(c.nombre_cliente) AS NombreCliente,         -- (1. Cadena)
        c.rut_cliente,
        CONCAT(c.calle, ' #', c.numero) AS Direccion,    -- (2. Cadena)
        LEFT(co.nombre_comuna, 10) AS ComunaAbreviada,  -- (3. Cadena)

        -- FUNCIONES DE GRUPO Y MATEMÁTICAS (3+) [cite: 62, 63]
        COUNT(DISTINCT b.id_venta) AS TotalCompras,       -- (1. Grupo)
        SUM(b.monto_final) AS GastoTotalNeto,             -- (2. Grupo)
        AVG(b.monto_final) AS GastoPromedioPorBoleta,     -- (3. Math)

        -- FUNCIONES DE FECHA (3+) [cite: 61]
        MAX(b.fecha_venta) AS UltimaCompra,
        DATEDIFF(DAY, MAX(b.fecha_venta), GETDATE()) AS DiasDesdeUltimaCompra, -- (1. Fecha, 2. Fecha)
        DATENAME(MONTH, MAX(b.fecha_venta)) AS MesUltimaCompra,            -- (3. Fecha)
        
        -- USO DE FUNCIÓN ESCALAR 1 
        SUM(dbo.fn_CalcularSubtotal(db.precio_venta, db.cantidad_producto)) AS GastoTotalBruto,

        -- USO DE CASE [cite: 60]
        CASE 
            WHEN SUM(b.monto_final) > 500000 THEN 'Cliente Premium'
            WHEN SUM(b.monto_final) > 50000 THEN 'Cliente Frecuente'
            ELSE 'Cliente Ocasional'
        END AS SegmentoCliente

    FROM Cliente c
    JOIN Boleta b ON c.rut_cliente = b.rut_cliente
    JOIN Detalle_boleta db ON b.id_venta = db.id_venta
    JOIN Comuna co ON c.id_comuna = co.id_comuna
    WHERE b.fecha_venta BETWEEN @FechaInicio AND @FechaFin
    
    -- USO DE GROUP BY [cite: 63]
    GROUP BY c.rut_cliente, c.nombre_cliente, c.calle, c.numero, co.nombre_comuna
    
    -- USO DE HAVING [cite: 63]
    HAVING COUNT(DISTINCT b.id_venta) >= 1
    
    ORDER BY GastoTotalNeto DESC;
END;
GO

-- Ejemplo de ejecución:
-- EXEC sp_ReporteRentabilidadClientes '2025-01-01', '2025-12-31';
