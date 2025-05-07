-- MySQL database dump
-- Versión completa con creación de la base de datos 'camp'

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS `autocamp` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `autocamp`;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
-- Estructura de la tabla `cliente`
--

CREATE TABLE `cliente` (
  `codcli` char(4) NOT NULL,
  `nombre` varchar(20) DEFAULT NULL,
  `apellido` varchar(40) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `mail` varchar(100) DEFAULT NULL,
  `rol` varchar(30) DEFAULT NULL,
  `password` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la tabla `coche`
--

CREATE TABLE `coche` (
  `matricula` char(7) NOT NULL,
  `modelo` varchar(40) DEFAULT NULL,
  `combustible` char(1) DEFAULT NULL,
  `motor` char(1) DEFAULT NULL,
  `plazas` int(11) DEFAULT NULL,
  `maletas` int(11) DEFAULT NULL,
  `foto` varchar(15) DEFAULT NULL,
  `codgama` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la tabla `gama`
--

CREATE TABLE `gama` (
  `codgama` char(2) NOT NULL,
  `nomgama` varchar(20) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `combustible` char(1) DEFAULT NULL,
  `motor` char(1) DEFAULT NULL,
  `plazas` int(11) DEFAULT NULL,
  `maletas` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de la tabla `reserva`
--

CREATE TABLE `reserva` (
  `codreserva` int(11) NOT NULL,
  `fecha_res` date NOT NULL,
  `f_inicio` date DEFAULT NULL,
  `f_fin` date DEFAULT NULL,
  `dias` int(11) DEFAULT NULL,
  `lugar` varchar(50) DEFAULT NULL,
  `importe` decimal(10,2) DEFAULT 0.00,
  `gama` varchar(2) NOT NULL,
  `codcliente` varchar(4) NOT NULL,
  `coche` char(7) DEFAULT NULL,
  `f_recogida` date DEFAULT NULL,
  `f_devolucion` date DEFAULT NULL,
  `s_motor` char(1) DEFAULT NULL,
  `s_plazas` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para las tablas
--

INSERT INTO `cliente` (`codcli`, `nombre`, `apellido`, `direccion`, `mail`, `rol`, `password`) VALUES
('1   ', 'Pepe', 'García', 'Ausiach March, 23', 'pep@gmailx.com', NULL, NULL),
('2   ', 'Lucas', 'Iniesta', 'Ausiach March, 23', 'lui@gmailx.com', NULL, NULL),
('3   ', 'Ana', 'Lorca Sanz', 'Ausiach March, 23', 'annta@gmailx.com', NULL, NULL);

INSERT INTO `coche` (`matricula`, `modelo`, `combustible`, `motor`, `plazas`, `maletas`, `foto`, `codgama`) VALUES
('1111AAA', 'Volvo z', 'F', 'A', 5, 3, 'foto1.jpg', 'F1'),
('1112AAA', 'Volvo EX40', 'E', 'A', 5, 3, 'foto2.jpg', 'F1'),
('1001BBB', 'Ford Focus', 'H', 'A', 5, 3, 'foto4.jpg', 'F1'),
('1003TTT', 'Citroen e-c3', 'E', 'A', 7, 4, 'foto5.jpg', 'T1'),
('3003LLL', 'Mercedes', 'E', 'A', 7, 4, 'foto6.jpg', 'L1'),
('3333BBB', 'Volvo XC90', 'E', 'A', 7, 4, 'foto7.jpg', 'L1'),
('4444NNN', 'Volvo XC1', 'H', 'A', 5, 4, 'foto10.jpg', 'F1'),
('1113AAA', 'Audi A3', 'H', 'M', 5, 4, 'foto3.jpg', 'F2'),
('6666NNN', 'Fiesta', 'F', 'M', 5, 3, 'foto8.jpg', 'F2'),
('6612NNN', 'Audi A3', 'F', 'M', 5, 3, 'foto9.jpg', 'F2');

INSERT INTO `gama` (`codgama`, `nomgama`, `stock`, `precio`, `combustible`, `motor`, `plazas`, `maletas`) VALUES
('L1', 'Lujo', 2, 23.00, NULL, NULL, NULL, NULL),
('F2', 'Familiar', 3, 23.00, NULL, NULL, NULL, NULL),
('T1', '4 x 4', 1, 23.00, NULL, NULL, NULL, NULL),
('F1', 'Familiar', 4, 15.00, NULL, NULL, NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`codcli`);

--
-- Indices de la tabla `coche`
--
ALTER TABLE `coche`
  ADD PRIMARY KEY (`matricula`);

--
-- Indices de la tabla `gama`
--
ALTER TABLE `gama`
  ADD PRIMARY KEY (`codgama`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `coche`
--
ALTER TABLE `coche`
  ADD CONSTRAINT `coche_ibfk_1` FOREIGN KEY (`codgama`) REFERENCES `gama` (`codgama`);

--
-- Triggers
--

DELIMITER $$
--
-- Eventos
--
CREATE TRIGGER `tr_st` AFTER INSERT ON `coche` FOR EACH ROW BEGIN
    UPDATE gama
    SET stock = stock + 1
    WHERE gama.codgama = NEW.codgama;
END
$$

CREATE TRIGGER `tr_st_delete` AFTER DELETE ON `coche` FOR EACH ROW BEGIN
    UPDATE gama
    SET stock = stock - 1
    WHERE gama.codgama = OLD.codgama;
END
$$

DELIMITER ;

--
-- Funciones
--

DELIMITER $$
CREATE FUNCTION `f_ver_precio`(n1 char(2)) RETURNS decimal(10,2)
BEGIN
    RETURN (SELECT precio FROM gama WHERE n1=codgama);
END$$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION `f_ver_stock`(n1 char(2)) RETURNS int(11)
BEGIN
    RETURN (SELECT stock FROM gama WHERE n1=codgama);
END$$
DELIMITER ;
