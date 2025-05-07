<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Coches</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .banner img {
            width: 100%;
            height: 300px;
            object-fit: cover;
        }
    </style>
</head>
<body class="bg-white">
    <div class="banner">
        <img src="TU_IMAGEN_AQUI.jpg" alt="Banner de Coches">
    </div>

    <div class="container py-5">
        <h1 class="text-center text-danger mb-5">Listado de Coches Disponibles</h1>

        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle text-center">
                <thead class="table-danger">
                    <tr>
                        <th>Matricula</th>
                        <th>Modelo</th>
                        <th>Combustible</th>
                        <th>Motor</th>
                        <th>Plazas</th>
                        <th>Maletas</th>
                        <th>Foto</th>
                        <th>Gama</th>
                    </tr>
                </thead>
                <tbody>
                    
                    <?php
                        
                        include 'conexion.php';
                        $sql = "SELECT * FROM coche";
                        $resultado = mysqli_query($conexion, $sql);

                        while($fila = mysqli_fetch_assoc($resultado)) {
                            echo "<tr>";
                            echo "<td>{$fila['matricula']}</td>";
                            echo "<td>{$fila['modelo']}</td>";
                            echo "<td>{$fila['combustible']}</td>";
                            echo "<td>{$fila['motor']}</td>";
                            echo "<td>{$fila['maletas']} €</td>";
                            echo "<td>{$fila['foto']} €</td>";
                            echo "<td>{$fila['codgama']} €</td>";
                            echo "<td><a class='btn btn-danger btn-sm'>Ver más</a></td>";
                            echo "</tr>";
                        }
                        */
                    ?>
                </tbody>
            </table>
        </div>
    </div>
    
</body>
</html>
