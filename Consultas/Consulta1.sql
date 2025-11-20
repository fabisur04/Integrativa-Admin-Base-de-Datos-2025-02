USE IntegrativaAdminBBDD;
GO

CREATE OR ALTER FUNCTION dbo.fn_CalcularSubtotal
(
    @precio DECIMAL(10,2), 
    @Cantidad INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @valor DECIMAL(10,2) = (@precio * @Cantidad);
    RETURN @valor;
END
GO

CREATE OR ALTER FUNCTION dbo.fn_CalcularTotalEnInventario
(
    @ID_producto INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @valor DECIMAL(10,2);

    SELECT @valor = (pro.precio_producto * pro.stock_producto)
    FROM Producto pro
    WHERE @ID_producto = pro.id_producto;

END
GO

CREATE OR ALTER PROCEDURE MostrarClientesFrecuentes
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT

        UPPER(c.nombre_cliente) AS NombreCliente,         -- (1. Cadena)
        c.rut_cliente,
        CONCAT(c.calle, ' #', c.numero) AS Direccion,     -- (2. Cadena)
        LEFT(co.nombre_comuna, 10) AS ComunaAbreviada,    -- (3. Cadena)


        COUNT(DISTINCT b.id_venta) AS TotalCompras,       -- (1. Grupo)
        SUM(b.monto_final) AS GastoTotalNeto,             -- (2. Grupo)
        AVG(b.monto_final) AS GastoPromedioPorBoleta,     -- (3. Math)

        MAX(b.fecha_venta) AS UltimaCompra,
        DATEDIFF(DAY, MAX(b.fecha_venta), GETDATE()) AS DiasDesdeUltimaCompra, -- (1. Fecha, 2. Fecha)
        DATENAME(MONTH, MAX(b.fecha_venta)) AS MesUltimaCompra,             -- (3. Fecha)
        
        -- USO DE FUNCIÓN ESCALAR 1 
        -- CAMBIO: Ahora el nombre coincide con la función creada arriba
        SUM(dbo.fn_CalcularSubtotal(db.precio_venta, db.cantidad_producto)) AS GastoTotalBruto,


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

    GROUP BY c.rut_cliente, c.nombre_cliente, c.calle, c.numero, co.nombre_comuna
    
    HAVING COUNT(DISTINCT b.id_venta) >= 1
    
    ORDER BY GastoTotalNeto DESC;
END;
GO
