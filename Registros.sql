USE Proyectousuarios;

-- Añadir variable de sueldo devengado

ALTER TABLE DetalleTrabajo ADD Sueldo_Devengado FLOAT;

INSERT INTO DetalleTrabajo
VALUES
(1, 2, 2, 6, 1, 2, '05-06-2010'),
(1, 3, 5, 12, 1, 3, '03-02-2009'),
(2, 1, 3, 3, 2, 3, '01-02-2015');

-- Añadiendo sueldos

UPDATE DetalleTrabajo 
SET Sueldo_Devengado = CASE
	WHEN Detalle_ID = 1 THEN 5000000
	WHEN Detalle_ID = 2 THEN 3200000
	WHEN Detalle_ID = 3 THEN 5600000
END;

INSERT INTO DetalleTrabajo
VALUES
(2, 3, 13, 14, 3, 3, '02-06-2023', 4300000),
(3, 1, 19, 2, 1, 2, '01-10-2020', 6500000),
(4, 1, 6, 7, 2, 5, '06-12-2021', 4650000),
(5, 1, 4, 10, 1, 4, '09-06-2017', 6506000),
(6, 1, 10, 13, 1, 2, '09-06-2023', 9653000),
(7, 3, 5, 2, 1, 5, '01-11-2015', 5500000),
(8, 2, 18, 9, 2, 2, '12-20-2022', 4000000),
(9, 3, 9, 14, 1, 4, '06-30-2022', 5000000),
(9, 1, 5, 9, 4, 4, '10-11-2022', 4000000),
(10, 1, 1, 5, 1, 5, '03-12-2024', 5500000),
(11, 2, 17, 4, 2, 2, '10-20-2016', 5860000),
(12, 1, 2, 3, 1, 2, '12-06-2023', 6665000),
(12, 1, 11, 15, 4, 2, '01-10-2024', 4000000),
(13, 1, 15, 12, 1, 2, '01-12-2024', 6652000),
(13, 1, 4, 18, 4, 2, '06-30-2023', 3500000),
(14, 3, 6, 7, 3, 2, '03-10-2021', 5000000),
(15, 3, 12, 6, 1, 2, '03-30-2021', 6502000),
(16, 2, 17, 13, 1, 4, '05-14-2018', 6000000),
(17, 1, 3, 5, 1, 1, '06-30-2021', 6450000),
(18, 3, 14, 10, 1, 2, '01-15-2010', 5600000),
(19, 1, 18, 20, 2, 1, '04-09-2021', 5000000),
(20, 2, 14, 1, 1, 5, '08-09-2022', 5220000),
(21, 1, 10, 12, 1, 2, '10-06-2021', 6430000),
(22, 3, 9, 17, 1, 2, '09-23-2021', 6000000),
(23, 3, 13, 8, 1, 2, '03-30-2023', 6500000),
(24, 1, 2, 3, 1, 2, '03-15-2010', 7660000),
(25, 2, 10, 6, 1, 2, '12-10-2022', 5210000),
(26, 2, 1, 1, 1, 5, '10-30-2019', 4500000),
(27, 2, 7, 4, 1, 2, '10-06-2022', 4500000);

--	Trabajador_ID INT NOT NULL,
--	Modalidad_ID INT,
--	Cargo_ID INT NOT NULL,
--	Empresa_ID INT NOT NULL,
--	Contrato_ID INT,
--	Ciudad_ID INT,
--	Fecha_Ingreso DATE

-- Prueba para consultar el salario promedio por ciudad

SELECT c.Nombre_Ciudad, FORMAT(ROUND(AVG(dt.Sueldo_Devengado), 0), '$ #,###') AS Sueldo_Promedio, COUNT(*) AS Cantidad_Empleos 
FROM DetalleTrabajo dt INNER JOIN Ciudad c ON
c.Ciudad_ID = dt.Ciudad_ID GROUP BY c.Nombre_Ciudad ORDER BY Sueldo_Promedio DESC;