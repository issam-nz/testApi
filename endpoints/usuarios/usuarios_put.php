<?php

// Include necessary files
require_once 'config.php';
require_once 'db.php';

// Handle PUT request
if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    // Check if required data is provided
    $data = json_decode(file_get_contents("php://input"), true);
    if (!isset($data['id']) ||
        !isset($data['username']) ||
        !isset($data['nombre']) ||
        !isset($data['apellidos']) || 
        !isset($data['email']) || 
        !isset($data['contrasena']) || 
        !isset($data['id_tipo_usuario'])) {
        http_response_code(400);
        echo json_encode(['message' => 'Bad request. Missing required data', 'updated' => false]);
        exit();
    }

    // Extract data from request
    $id = $data['id'];
    $username = $data['username'];
    $nombre = $data['nombre'];
    $apellidos = $data['apellidos'];
    $email = $data['email'];
    $contrasena = $data['contrasena'];
    $id_tipo_usuario = $data['id_tipo_usuario'];

    // Update usuario in the database
    $conn = connectDB();
    $sql = "UPDATE usuarios SET 
            username = '$username', 
            nombre = '$nombre', 
            apellidos = '$apellidos', 
            email = '$email', 
            contrasena = '$contrasena', 
            id_tipo_usuario = $id_tipo_usuario 
            WHERE id = $id";
    if ($conn->query($sql) === TRUE) {
        echo json_encode(['message' => 'Usuario updated successfully', 'updated' => true]);
    } else {
        echo json_encode(['message' => 'Error updating usuario: ' . $conn->error, 'updated' => false]);
    }

    $conn->close();
}

?>
