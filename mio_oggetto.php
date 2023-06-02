<?php


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
$id_user = $user['user_id'];

//se non è settato l'id dell'oggetto
if (!isset($_GET['id_oggetto'])){
    header('Location: index.php');
    exit(0);
}

$oggetto = TradeRepository::getOggetto($_GET['id_oggetto']);
$acquirente = false;
if ($oggetto['id_richiedente'] != null){
    $acquirente = TradeRepository::getUtente($oggetto['id_richiedente']);
}
//controllo che l'oggetto sia mio
if ($oggetto['id_offerente'] != $id_user){
    header('Location: index.php');
    exit(0);
}

echo $template->render('oggetto',[
    'oggetto' => $oggetto,
    'acquirente' => $acquirente,
    'utente' => TradeRepository::getUtente($id_user),
    'chats' => TradeRepository::getMessaggiUtente($_GET['id_oggetto'], $id_user),
]);
exit(0);
