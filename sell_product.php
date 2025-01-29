<?php
// Database connection settings
$servername = "localhost"; // Change if your database server is different
$username = "root"; // Your database username
$password = ""; // Your database password
$dbname = "FarmEase"; // Your database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if the form is submitted via POST
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get form data
    $name = $_POST['name'];
    $price = $_POST['price'];
    $category = $_POST['category'];
    $stock = $_POST['stock'];
    $farmer_name = $_POST['farmer_name'];
    $phone_number = $_POST['phone_number'];
    $farmer_email = $_POST['farmer_email'];

    // Handle file upload
    $target_dir = "uploads/"; // Directory to store uploaded files
    $target_file = $target_dir . basename($_FILES["product_image"]["name"]);
    
    // Check if uploads directory exists, if not create it
    if (!is_dir($target_dir)) {
        mkdir($target_dir, 0755, true);
    }

    // Move the uploaded file to the target directory
    if (move_uploaded_file($_FILES["product_image"]["tmp_name"], $target_file)) {
        echo "File uploaded successfully: $target_file<br>";
    } else {
        echo "Error uploading file.<br>";
    }

    // Prepare and bind
    $stmt = $conn->prepare("INSERT INTO products (name, price, category, stock, farmer_name, phone_number, farmer_email, product_image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sdsssiss", $name, $price, $category, $stock, $farmer_name, $phone_number, $farmer_email, $target_file);

    // Execute the statement
    if ($stmt->execute()) {
        echo "New product added successfully!";
        header("Location: home.html"); // Redirect to home page after successful submission
        exit;
    } else {
        echo "Error: " . $stmt->error;
    }

    // Close the statement
    $stmt->close();
}

// Close the database connection
$conn->close();
?>
