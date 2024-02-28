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

// Handle DELETE request
if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    // Check if id is provided in the request
    if (!isset($_GET['id'])) {
        http_response_code(400);
        echo json_encode(['message' => 'Bad request. Missing usuario id']);
        exit();
    }

    $id = $_GET['id'];
    $conn = connectDB();

    // Check if the usuario exists
    $checkSql = "SELECT * FROM usuarios WHERE id = $id";
    $result = $conn->query($checkSql);
    if ($result->num_rows === 0) {
        http_response_code(404);
        echo json_encode(['message' => 'Usuario not found']);
        exit();
    }

    // Delete the usuario
    $deleteSql = "DELETE FROM usuarios WHERE id = $id";
    if ($conn->query($deleteSql) === TRUE) {
        echo json_encode(['message' => 'Usuario deleted successfully']);
    } else {
        echo json_encode(['message' => 'Error deleting usuario: ' . $conn->error]);
    }

    $conn->close();
}

?>
