<?php
//in questo file vengono gestite le azioni che l'utente può compiere
//vengono infatti intercettate tutte le post
//e in base al valore di action si esegue una determinata azione

require_once 'vendor/autoload.php';
require_once 'conf/config.php';

use League\Plates\Engine;
use Model\TradeRepository;
use Util\Authenticator;


$template = new Engine('templates', 'tpl');


$user = Authenticator::getUser();
if (!isset($user['user_id'])) {
    $login_fallito = $user;
    header('Location: index.php');
    exit(0);
}

if(!isset($_POST['action'])){
    header('Location: index.php');
    exit(0);
}

$action = $_POST['action'];

if($action == 'compra'){
    $id_user = $user['user_id'];
    if(TradeRepository::canBuy($id_user)){
        TradeRepository::buyOggetto($_POST['id_oggetto'], $id_user);
    }
    header('Location: index.php');
    exit(0);
}




echo $template->render('scritta', [

]);

