<?php

// Include necessary files
require_once 'db.php';

// Check if ID and filter are provided in the request
$id = $_GET['id'] ?? '';
$filter = $_GET['filter'] ?? '';

// Initialize response variables
$success = false;
$usuarios = null;
$usuario = null;

// Get usuario(s) from the database
$conn = connectDB();
if (!empty($id)) {
    // Get usuario by ID
    $sql = "SELECT * FROM usuarios WHERE id = $id";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $usuario = $result->fetch_assoc();
        $success = true;
    }
} else {
    // Build filter SQL if provided
    $filterSQL = '';
    if (!empty($filter)) {
        $filterArray = json_decode($filter, true);
        foreach ($filterArray as $key => $value) {
            if (is_string($value)) {
                // Handle string values with LIKE "%VALUE%"
                $filterSQL .= " AND $key LIKE '%$value%'";
            } elseif (is_numeric($value)) {
                // Handle numeric values with =
                $filterSQL .= " AND $key = $value";
            } elseif (is_bool($value)) {
                // Convert boolean value to 0 or 1 and handle with =
                $boolValue = $value ? 1 : 0;
                $filterSQL .= " AND $key = $boolValue";
            }
        }
    }

    // Get all usuarios with filter if provided
    $sql = "SELECT * FROM usuarios WHERE 1" . $filterSQL;
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        $usuarios = [];
        while ($row = $result->fetch_assoc()) {
            $usuarios[] = $row;
        }
        $success = true;
    }
}

// Prepare and return response
if (!empty($id)) {
    $response = [
        'success' => $success,
        'usuario' => $usuario
    ];
} else {
    $response = [
        'success' => $success,
        'usuarios' => $usuarios
    ];
}

echo json_encode($response);

$conn->close();

?>
