<?php 

include "../connect.php";

$title = filterRequest('title');
$content = filterRequest('content');
$userid = filterRequest('id');
$imagename = uploadImage('file');


if ($imagename != 'failed') {
    $stmt = $con->prepare('INSERT INTO `notes`(`notes_title`, `notes_content`, `notes_user`,`notes_images`) VALUES (? , ? , ?, ?)');
$stmt->execute(array($title,$content,$userid,$imagename));

$count = $stmt->rowCount();
if($count > 0) {
    echo json_encode(array('status' => "success"));
}else {
    echo json_encode(array('status' => "failed"));
}
}else {
    echo json_encode(array('status' => "failed"));
}




