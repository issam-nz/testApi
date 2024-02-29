<?php

// Include necessary files
require_once 'jwt.php';
require_once 'config.php';

// Define allowed endpoints
$allowedEndpoints = ['login', 'usuarios', 'idiomas', 'idioma_alumno', 'practicas', 'alumnos', 'profesores', 'ciclos', 'empresas', 'centros_trabajo', 'contactos']; // Add more endpoints as needed
// para luego tipos_practicas, tipo_usuario, nivel_idiomas

// Get request method and endpoint from the URL
$requestMethod = $_SERVER['REQUEST_METHOD'];
$endpoint = $_GET['endpoint'] ?? '';

// Check if the endpoint is allowed
if (!in_array($endpoint, $allowedEndpoints)) {
    http_response_code(404);
    echo json_encode(['message' => 'Endpoint not found']);
    exit();
}

// Handle login endpoint separately
if ($endpoint === 'login' && $requestMethod === 'POST') {
    // Handle login logic here
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';

    // Example: Check if username and password are valid (you should implement your own logic here)
    if ($username === 'admin' && $password === 'admin') {
        $userData = ['username' => $username]; // You can include additional user data here if needed
        $jwt = generateJWT($userData);
        echo json_encode(['token' => $jwt]);
        exit();
    } else {
        http_response_code(401);
        echo json_encode(['message' => 'Invalid username or password']);
        exit();
    }
}

// Check if JWT exists and is valid for all other endpoints
$headers = apache_request_headers();
$jwt = $headers['Authorization'] ?? '';

// var_dump($jwt);
// var_dump($headers['Authorization']);
// var_dump(verifyJWT($jwt));
// die();

if (!$jwt || !verifyJWT($jwt)) {
    http_response_code(401);
    echo json_encode(['message' => 'Unauthorized']);
    exit();
}

// Include endpoint handler based on the request method
switch ($requestMethod) {
    case 'GET':
        require_once "endpoints/{$endpoint}/{$endpoint}_get.php";
        break;
    case 'POST':
        require_once "endpoints/{$endpoint}/{$endpoint}_post.php";
        break;
    case 'PUT':
        require_once "endpoints/{$endpoint}/{$endpoint}_put.php";
        break;
    case 'DELETE':
        require_once "endpoints/{$endpoint}/{$endpoint}_delete.php";
        break;
    default:
        http_response_code(405);
        echo json_encode(['message' => 'Method not allowed']);
        break;
}

?>