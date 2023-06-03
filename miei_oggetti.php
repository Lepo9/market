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

echo $template->render('miei_oggetti',[
    'oggetti' => TradeRepository::getMieiOggetti($id_user),
    'utente' => TradeRepository::getUtente($id_user)
]);

