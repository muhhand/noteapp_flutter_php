<?php 


define('MB', 1048576);


function filterRequest ($requestname) {
   return htmlspecialchars(strip_tags($_POST[$requestname]));
}


function uploadImage ($imageRequest) {
 global $msgerror;
 $imagename = rand(100,10000) . $_FILES[$imageRequest]['name'];
 $imagetmp = $_FILES[$imageRequest]['tmp_name'];
 $imagesize = $_FILES[$imageRequest]['size'];
 $allowext = array('jpg','jpeg','png','mp3','pdf');
 $strToArray = explode(".",$imagename);
 $ext = end($strToArray);
 $ext = strtolower($ext);

 if(!empty($imagename) && !in_array($ext,$allowext)){
        $msgerror[] = 'Ext';
 }
 if($imagesize > 2 * MB){
   $msgerror[] = 'Size';
 }
 if(empty($msgerror)){
   move_uploaded_file($imagetmp, "../upload/" . $imagename);
   return $imagename;
 }else {
   return 'failed';
 }
 
}



function deleteFile ($dir , $imagename) {
   if (file_exists($dir . '/' . $imagename)){
      unlink($dir . '/' . $imagename);
   }



}



{
function checkAuthenticate() {
    if (isset($_SERVER['PHP_AUTH_USER'])  && isset($_SERVER['PHP_AUTH_PW'])) {

        if ($_SERVER['PHP_AUTH_USER'] != "muhhand" ||  $_SERVER['PHP_AUTH_PW'] != "muhhand291"){
            header('WWW-Authenticate: Basic realm="My Realm"');
            header('HTTP/1.0 401 Unauthorized');
            echo 'Page Not Found';
            exit;
        }
    } else {
        exit;
    }
  }
}