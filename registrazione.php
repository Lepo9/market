<?php

require_once 'vendor/autoload.php';
require_once 'conf/config.php';

use League\Plates\Engine;
use Model\TradeRepository;
use Util\Authenticator;


$template = new Engine('templates','tpl');



$user = Authenticator::getUser();
if (isset($user['user_id'])){
    header('Location: index.php');
    exit(0);
}

$errore = "";

if(isset($_GET['errore'])){
    $errore = $_GET['errore'];
    if($errore == 1)
        $errore = "Le password non coincidono";
    if ($errore == 2)
        $errore = "Email già in uso";
}



echo $template->render('registrazione',[
    'errore' => $errore,
]);

