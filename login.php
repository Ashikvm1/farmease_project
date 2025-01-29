<?php
session_start();
include 'db_connection.php'; // Database connection

if(isset($_POST['login'])) {
    $user_type = $_POST['user_type'];
    $email = $_POST['user_email'];
    $password = $_POST['password'];

    // Determine the table based on user type
    $table = ($user_type == 'admin') ? 'admin' : 'user';

    // Fetch user details
    $query = "SELECT * FROM $table WHERE user_email = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        if(password_verify($password, $user['password'])) {
            $_SESSION['user_email'] = $user['user_email'];
            $_SESSION['user_type'] = $user_type;
            header("Location: home.html");
        } else {
            echo "<div class='alert alert-danger'>Incorrect Email or Password!</div>";
        }
    } else {
        echo "<div class='alert alert-danger'>Incorrect Email or Password!</div>";
    }
}
?>
