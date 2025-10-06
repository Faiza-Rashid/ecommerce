<?php
include('../../config/db.php');

$order_id = isset($_GET['order_id']) ? intval($_GET['order_id']) : 0;

$orderQuery = "SELECT o.*, u.name AS customer_name, u.email AS customer_email
               FROM orders o
               JOIN users u ON o.user_id = u.id
               WHERE o.id = $order_id";
$orderResult = mysqli_query($conn, $orderQuery);
$order = mysqli_fetch_assoc($orderResult);

if (!$order) {
    echo "<h3 style='color:red;text-align:center;margin-top:50px;'>Invalid Order ID!</h3>";
    exit;
}

$itemQuery = "SELECT oi.*, p.name AS product_name, p.image AS product_image
              FROM order_items oi
              JOIN products p ON oi.product_id = p.id
              WHERE oi.order_id = $order_id";
$itemResult = mysqli_query($conn, $itemQuery);

// Simulate sample data if no results from query (for demonstration)
$sample_data = [
    ['product_name' => 'Premium DSLR Camera - Model 1', 'quantity' => 1, 'price' => 799.99, 'product_image' => 'camera1.jpg'],
    ['product_name' => 'Advanced Mirrorless Camera - Model 2', 'quantity' => 2, 'price' => 899.99, 'product_image' => 'camera2.jpg'],
    ['product_name' => 'Professional Cine Camera - Model 3', 'quantity' => 1, 'price' => 1099.99, 'product_image' => 'camera3.jpg'],
    ['product_name' => 'High-Performance Drone - Edition 1', 'quantity' => 1, 'price' => 499.99, 'product_image' => 'drone1.jpg'],
    ['product_name' => 'Ultra-Light Drone - Edition 2', 'quantity' => 3, 'price' => 299.99, 'product_image' => 'drone2.jpg'],
    ['product_name' => 'Ergonomic Gaming Chair - Black', 'quantity' => 1, 'price' => 199.99, 'product_image' => 'gamingchair1.jpg'],
    ['product_name' => 'Luxury Gaming Chair - Grey', 'quantity' => 2, 'price' => 249.99, 'product_image' => 'gamingchair2.jpg'],
    ['product_name' => 'Elite Wireless Earbuds - Series 1', 'quantity' => 4, 'price' => 59.99, 'product_image' => 'wirelessearbuds1.jpg'],
];
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Invoice #<?php echo $order['id']; ?></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            font-family: 'Poppins', sans-serif;
            padding-top: 80px;
            overflow-x: hidden;
        }

        .navbar {
            background: linear-gradient(90deg, #2c3e50, #3498db);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .navbar .nav-link {
            color: #fff;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .navbar .nav-link:hover {
            color: #f1c40f;
        }

        .invoice-box {
            background: #ffffff;
            border-radius: 25px;
            padding: 40px;
            margin-top: 30px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.15);
            position: relative;
            overflow: hidden;
            border: 2px solid #ecf0f1;
        }

        .invoice-box::after {
            content: "INVOICE";
            position: absolute;
            top: 50%;
            left: 50%;
            font-size: 120px;
            color: rgba(52, 152, 219, 0.05);
            transform: translate(-50%, -50%) rotate(-25deg);
            z-index: 0;
            font-family: 'Arial', sans-serif;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
        }

        .invoice-header {
            background: linear-gradient(90deg, #2c3e50, #3498db);
            color: #fff;
            padding: 35px;
            border-radius: 20px 20px 0 0;
            margin: -40px -40px 40px -40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .invoice-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0) 70%);
            transform: rotate(45deg);
            z-index: 0;
        }

        .invoice-header h2 {
            margin: 0;
            font-weight: 800;
            position: relative;
            z-index: 1;
        }

        .invoice-header p {
            margin: 5px 0 0 0;
            font-size: 1rem;
            color: #ecf0f1;
            position: relative;
            z-index: 1;
        }

        .invoice-section {
            margin-bottom: 30px;
            position: relative;
            z-index: 1;
        }

        .invoice-section h6 {
            font-weight: 700;
            color: #2c3e50;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        table {
            border-collapse: separate !important;
            border-spacing: 0 10px;
        }

        table th {
            background: linear-gradient(90deg, #3498db, #2c3e50);
            color: #fff;
            font-weight: 700;
            border-radius: 10px;
        }

        table tbody tr {
            background: #f9fbfd;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        table tbody tr:hover {
            background-color: #e8eef7;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .table td i {
            margin-right: 8px;
            color: #3498db;
        }

        .product-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 5px;
        }

        .grand-total {
            background: linear-gradient(90deg, #e74c3c, #c0392b);
            color: #fff;
            font-weight: 800;
            font-size: 1.8rem;
            padding: 20px;
            border-radius: 15px;
            text-align: right;
            margin-top: 30px;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }

            50% {
                transform: scale(1.05);
            }

            100% {
                transform: scale(1);
            }
        }

        .print-btn {
            margin-top: 30px;
        }

        .print-btn .btn {
            background: linear-gradient(90deg, #2ecc71, #27ae60);
            color: #fff;
            font-weight: 600;
            padding: 12px 30px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        .print-btn .btn:hover {
            background: linear-gradient(90deg, #27ae60, #2ecc71);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(39, 174, 96, 0.4);
        }

        @media print {
            .print-btn,
            .navbar {
                display: none;
            }

            .invoice-box {
                box-shadow: none;
                border: none;
            }
        }

        @media (max-width: 768px) {
            .invoice-header {
                text-align: center;
                flex-direction: column;
            }

            .invoice-header div {
                margin-top: 15px;
            }

            .grand-total {
                font-size: 1.5rem;
            }

            .print-btn .btn {
                width: 100%;
            }

            .product-img {
                width: 40px;
                height: 40px;
            }
        }
    </style>
</head>

<body>

    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand text-white" href="#"><i class="fas fa-box-open"></i> Orders</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"><i class="fas fa-bars" style="color:#fff;"></i></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="create_order.php">Create Order</a></li>
                    <li class="nav-item"><a class="nav-link" href="invoice.php?order_id=<?php echo $order_id; ?>">Invoice</a></li>
                    <li class="nav-item"><a class="nav-link" href="order_history.php">Order History</a></li>
                    <li class="nav-item"><a class="nav-link" href="payment.php?order_id=<?php echo $order_id; ?>">Payment</a></li>
                    <li class="nav-item"><a class="nav-link" href="update_status.php?order_id=<?php echo $order_id; ?>">Update Status</a></li>
                    <li class="nav-item"><a class="nav-link" href="view_order.php?order_id=<?php echo $order_id; ?>">View Order</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container invoice-box">
        <div class="invoice-header">
            <div>
                <h2><i class="fas fa-file-invoice"></i> INVOICE</h2>
                <p>Order #<?php echo $order['id']; ?><br>
                    Date: <?php echo date('d M Y', strtotime($order['created_at'])); ?><br>
                    Status: <strong style="color:#f1c40f;"><?php echo ucfirst($order['status']); ?></strong></p>
            </div>
            <div class="text-end">
                <img src="https://via.placeholder.com/120x60.png?text=Logo" alt="Logo" style="border-radius:10px;">
                <p style="font-style:italic;">Multi Vendor E-Commerce<br>
                    Chittagong, Bangladesh<br>
                    support@myecom.com<br>
                    +880 1234 567 890</p>
            </div>
        </div>

        <div class="row invoice-section">
            <div class="col-md-6">
                <div class="p-3 border rounded bg-light" style="background: #f9fbfd;">
                    <h6><i class="fas fa-user"></i> Billed To:</h6>
                    <p style="color:#2c3e50;"><?php echo $order['customer_name']; ?><br>
                        <?php echo $order['customer_email']; ?></p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="p-3 border rounded bg-light" style="background: #f9fbfd;">
                    <h6><i class="fas fa-truck"></i> Shipping Address:</h6>
                    <p style="color:#2c3e50;">123, Sample Road<br>Chittagong, Bangladesh</p>
                </div>
            </div>
        </div>

        <table class="table table-bordered table-striped text-center align-middle">
            <thead>
                <tr>
                    <th><i class="fas fa-image"></i> Image</th>
                    <th><i class="fas fa-box"></i> Product</th>
                    <th><i class="fas fa-sort-numeric-up"></i> Qty</th>
                    <th><i class="fas fa-dollar-sign"></i> Price ($)</th>
                    <th><i class="fas fa-dollar-sign"></i> Total ($)</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $grand_total = 0;
                if (mysqli_num_rows($itemResult) > 0) {
                    while ($item = mysqli_fetch_assoc($itemResult)) {
                        $total = $item['quantity'] * $item['price'];
                        $grand_total += $total;
                        $image_path = !empty($item['product_image']) ? "/Multi-Vendor-E-Commerce-main/images/" . htmlspecialchars($item['product_image']) : "https://via.placeholder.com/50x50.png?text=No+Image";
                        // Debug: Output the image path
                        // echo "<!-- Image path: $image_path -->";
                        echo "<tr>
                            <td><img src='$image_path' alt='{$item['product_name']}' class='product-img'></td>
                            <td style='color:#2c3e50;'>{$item['product_name']}</td>
                            <td>{$item['quantity']}</td>
                            <td>\$" . number_format($item['price'], 2) . "</td>
                            <td>\$" . number_format($total, 2) . "</td>
                        </tr>";
                    }
                } else {
                    // Use sample data if query returns no results
                    foreach ($sample_data as $item) {
                        $total = $item['quantity'] * $item['price'];
                        $grand_total += $total;
                        $image_path = !empty($item['product_image']) ? "/Multi-Vendor-E-Commerce-main/images/" . htmlspecialchars($item['product_image']) : "https://via.placeholder.com/50x50.png?text=No+Image";
                        // Debug: Output the image path
                        // echo "<!-- Image path: $image_path -->";
                        echo "<tr>
                            <td><img src='$image_path' alt='{$item['product_name']}' class='product-img'></td>
                            <td style='color:#2c3e50;'>{$item['product_name']}</td>
                            <td>{$item['quantity']}</td>
                            <td>\$" . number_format($item['price'], 2) . "</td>
                            <td>\$" . number_format($total, 2) . "</td>
                        </tr>";
                    }
                }
                ?>
            </tbody>
        </table>

        <div class="grand-total">
            <i class="fas fa-dollar-sign"></i> Grand Total: $<?php echo number_format($grand_total, 2); ?>
        </div>

        <div class="text-center print-btn">
            <button class="btn btn-lg" onclick="window.print()"><i class="fas fa-print"></i> Print Invoice</button>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
