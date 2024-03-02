<?php

// Include necessary files
require_once 'config.php';
require_once 'db.php';

// Handle DELETE request
if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    // Check if id is provided in the request
    if (!isset($_GET['id'])) {
        http_response_code(400);
        echo json_encode(['message' => 'Bad request. Missing alumno id']);
        exit();
    }

    $id = $_GET['id'];
    $conn = connectDB();

    // Check if the alumno exists
    $checkSql = "SELECT * FROM alumnos WHERE id = $id";
    $result = $conn->query($checkSql);
    if ($result->num_rows === 0) {
        http_response_code(404);
        echo json_encode(['message' => 'Alumno not found', 'deleted' => false]);
        exit();
    }

    // Delete the alumno
    $deleteSql = "DELETE FROM alumnos WHERE id = $id";
    if ($conn->query($deleteSql) === TRUE) {
        echo json_encode(['message' => 'Alumno deleted successfully', 'deleted' => true]);
    } else {
        echo json_encode(['message' => 'Error deleting alumno: ' . $conn->error, 'deleted' => false]);
    }

    $conn->close();
}

?>
