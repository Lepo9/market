<?php

require_once 'vendor/autoload.php';
require_once 'conf/config.php';

use League\Plates\Engine;
use Model\TradeRepository;
use Util\Authenticator;


$template = new Engine('templates','tpl');


$user = Authenticator::getUser();
if (!isset($user['user_id'])){
    $login_fallito = $user;
    header('Location: index.php');
    exit(0);
}


//recupero dalla get id_oggetto
$id_oggetto = $_GET['id_oggetto'];
// se non è settato, reinderizzo alla home
if (!isset($id_oggetto)) {
    header('Location: index.php');
    exit;
}

//recupero l'oggetto dal db
$oggetto = TradeRepository::getOggetto($id_oggetto);
//se non esiste, reindirizzo alla home
if (!$oggetto) {
    header('Location: index.php');
    exit;
}



echo $template->render('oggetto_generico',[
    'oggetto' => $oggetto,
    'offerente' => TradeRepository::getUtente($oggetto['id_offerente']),
    'utente' => TradeRepository::getUtente($user['user_id']),
    'canBuy' => TradeRepository::canBuy($user['user_id']),
    'messaggi' => TradeRepository::getMessaggi($id_oggetto)
]);

