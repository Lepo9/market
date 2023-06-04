<?php

require_once 'vendor/autoload.php';
require_once 'conf/config.php';

use League\Plates\Engine;
use Util\Authenticator;

$template = new Engine('templates','tpl');

//Routing di tutte le pagine


//Fa partire il processo di autenticazione
$user = Authenticator::getUser();
if (!isset($user['user_id'])){
    $login_fallito = $user;
    echo $template->render('login',["login_fallito" => $login_fallito]);
    exit(0);
}

//redirect alla index
header("Location: ./index.php");
exit(0);

