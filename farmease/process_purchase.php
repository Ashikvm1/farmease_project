<?php
// Include your database connection
include('db_connection.php');

$product_id = $_POST['id'];
$quantity = $_POST['quantity'];
$address = $_POST['address'];
$mobile = $_POST['mobile'];

// Fetch the current stock of the product
$sql = "SELECT stock FROM products WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $product_id);
$stmt->execute();
$result = $stmt->get_result();
$product = $result->fetch_assoc();

if ($product) {
    $current_stock = $product['stock'];

    // Check if there is enough stock
    if ($current_stock >= $quantity) {
        // Deduct the stock
        $new_stock = $current_stock - $quantity;
        $update_sql = "UPDATE products SET stock = ? WHERE id = ?";
        $update_stmt = $conn->prepare($update_sql);
        $update_stmt->bind_param("ii", $new_stock, $product_id);
        $update_stmt->execute();

        // Process the purchase (add to orders or do other processing)
        // For now, we just return success
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'message' => 'Insufficient stock']);
    }
} else {
    echo json_encode(['success' => false, 'message' => 'Product not found']);
}

$stmt->close();
$conn->close();
?>
