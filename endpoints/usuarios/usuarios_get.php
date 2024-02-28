<?php

// Include necessary files
require_once '../../jwt.php';
require_once '../../config.php';
require_once '../../db.php';

// Check JWT
$headers = apache_request_headers();
$jwt = $headers['Authorization'] ?? '';
if (!$jwt || !verifyJWT($jwt)) {
    http_response_code(401);
    echo json_encode(['message' => 'Unauthorized']);
    exit();
}

// Handle GET request
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $conn = connectDB();
    
    // Check if id is provided in the request
    if (isset($_GET['id'])) {
        $id = $_GET['id'];
        // Filter by id
        $sql = "SELECT * FROM usuarios WHERE id = $id";
    } else {
        // Check if filters are provided in the request
        $filters = [];
        if (!empty($_GET)) {
            // Example: Get filter for nombre
            if (isset($_GET['nombre'])) {
                $nombre = $_GET['nombre'];
                $filters[] = "nombre LIKE '%$nombre%'";
            }
            // Add more filters as needed
        }

        // Construct the SQL query based on filters
        $sql = "SELECT * FROM usuarios";
        if (!empty($filters)) {
            $sql .= " WHERE " . implode(" AND ", $filters);
        }
    }

    // Execute the SQL query
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $usuarios = [];
        while ($row = $result->fetch_assoc()) {
            $usuarios[] = $row;
        }
        echo json_encode($usuarios);
    } else {
        echo json_encode(['message' => 'No usuarios found']);
    }

    $conn->close();
}

?>
