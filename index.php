<?php

require_once 'vendor/autoload.php';
require_once 'conf/config.php';

use League\Plates\Engine;
use Model\TradeRepository;
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

//ottengo l'id dell'utente e il suo nome
$id_user = $user['user_id'];

if(isset($_POST['action'])){
    if($_POST['action'] == 'compra' && TradeRepository::canBuy($id_user)){
        TradeRepository::buyOggetto($_POST['id_oggetto'], $id_user, $_POST['id_offerente']);
    }
}

//nel caso si voglia fare il logout
if (isset($_GET['action'])){
    $action = $_GET['action'];
    //switch case
    switch ($action){
        case 'logout':
            Authenticator::logout();
            echo $template->render('login',["login_fallito" => false]);
            exit(0);
            break;
        case 'messaggio':
            if(isset($_GET['msg'])){
                TradeRepository::newMessaggio($id_user, $_GET['id_destinatario'], $_GET['msg'], $_GET['id_oggetto']);
            }
            $id_oggetto = $_GET['id_oggetto'];
            $id_destinatario = $_GET['id_destinatario'];
            echo $template->render('messaggio',[
                'oggetto' => TradeRepository::getOggetto($id_oggetto),
                'offerente' => TradeRepository::getUtente($id_destinatario),
                'utente' => TradeRepository::getUtente($id_user),
                'canBuy' => TradeRepository::canBuy($id_user),
                'messaggi' => TradeRepository::getMessaggi($id_oggetto)
            ]);
            exit(0);
            break;
        case 'miei_oggetti':
            echo $template->render('miei_oggetti',[
                'oggetti' => TradeRepository::getMieiOggetti($id_user),
                'utente' => TradeRepository::getUtente($id_user)
            ]);
            exit(0);
            break;
    }
}


echo $template->render('index', [
    'oggetti_disponibili' => TradeRepository::getOggettiDisponibili($id_user),
    'utente' => TradeRepository::getUtente($id_user),
]);

