<?php

// Include necessary files
require_once 'jwt.php';
require_once 'config.php';
require_once 'db.php';

// Handle login request
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check if username and password are provided
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';

    if (empty($username) || empty($password)) {
        http_response_code(400);
        echo json_encode(['loggedIn' => false, 'usuario' => null]);
        exit();
    }

    // Check if username and password are valid
    $conn = connectDB();
    $sql = "SELECT id, username, nombre, apellidos FROM usuarios WHERE username = '$username' AND contrasena = '$password'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // User found, generate JWT
        $userData = $result->fetch_assoc();
        $userData['token'] = generateJWT(['username' => $username]);
        echo json_encode(['loggedIn' => true, 'usuario' => $userData]);
    } else {
        // User not found or invalid credentials
        echo json_encode(['loggedIn' => false, 'usuario' => null]);
    }

    $conn->close();
} else {
    // Invalid request method
    http_response_code(405);
    echo json_encode(['message' => 'Method not allowed']);
}

?>
