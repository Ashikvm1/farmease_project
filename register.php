<?php
include 'db_connection.php'; // Database connection

if(isset($_POST['register'])) {
    $first_name = $_POST['first_name'];
    $last_name = $_POST['last_name'];
    $email = $_POST['user_email'];
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);

    $query = "INSERT INTO user (user_first_name, user_last_name, user_email, password) VALUES (?, ?, ?, ?)";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("ssss", $first_name, $last_name, $email, $password);

    if($stmt->execute()) {
        echo "<script>alert('Registration successful!'); window.location='index.html';</script>";
    } else {
        echo "<script>alert('Error! Please try again.');</script>";
    }
}
?>
