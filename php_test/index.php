<?php
include 'connect.php';

// $stmt = $con->prepare("SELECT * FROM users");
// $stmt->execute();
// $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
// echo json_encode($users);

$stmt = $con->prepare("INSERT INTO `users`(`name`, `email`) VALUES ('muhamed','mohamed@gmail.com')");
$stmt->execute();


?>