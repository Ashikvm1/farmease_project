<?php
session_start();
include 'db_connection.php'; // Database connection

if (isset($_POST['login'])) {
    $user_type = $_POST['user_type'];  // user_type (admin or user)
    $email = $_POST['user_email'];     // Email entered in the form
    $password = $_POST['password'];    // Password entered in the form

    // Determine the table and the corresponding email column based on user type
    if ($user_type == 'admin') {
        $table = 'admin';  // Use 'admin' table
        $email_column = 'admin_email';  // Column for admin's email
    } else {
        $table = 'user';  // Use 'user' table
        $email_column = 'user_email';  // Column for regular user's email
    }

    // Prepare the query based on the selected table and email column
    $query = "SELECT * FROM `$table` WHERE `$email_column` = ?";
    $stmt = $conn->prepare($query);

    if (!$stmt) {
        die("<div class='alert alert-danger'>Query Error: " . $conn->error . "</div>");
    }

    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    // Check if user was found in the database
    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();  // Get user data from the result

        // Debugging: Print out the stored password hash for the admin
        echo "<div>Stored Password Hash: " . $user['password'] . "</div><br>";

        // Verify if the entered password matches the hashed password in the database
        if (password_verify($password, $user['password'])) {
            $_SESSION['user_email'] = $user[$email_column];  // Store the email in session
            $_SESSION['user_type'] = $user_type;  // Store user type in session (admin/user)
            $_SESSION['user_name'] = $user['user_first_name'];
            $_SESSION['user_id'] = $user['id'];
            header("Location: home.html");  // Redirect to home page on successful login
            exit;
        } else {
            echo "<div class='alert alert-danger'>Incorrect Password!</div>";
        }
    } else {
        echo "<div class='alert alert-danger'>Email not found!</div>";
    }
}


?>
