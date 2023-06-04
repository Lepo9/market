<?php

require_once 'vendor/autoload.php';
require_once 'conf/config.php';

use League\Plates\Engine;
use Model\TradeRepository;
use Util\Authenticator;

$template = new Engine('templates','tpl');

//Routing di tutte le pagine

$ricerca = "";

//Fa partire il processo di autenticazione
$user = Authenticator::getUser();
if (!isset($user['user_id'])){
    $login_fallito = $user;
    echo $template->render('login',["login_fallito" => $login_fallito]);
    exit(0);
}

//ottengo l'id dell'utente e il suo nome
$id_user = $user['user_id'];

if(isset($_GET['search'])){
    $search = $_GET['search'];
    if($search!="") {
        echo $template->render('index', [
            'oggetti_disponibili' => TradeRepository::getOggettiDisponibiliRicerca($id_user, $search),
            'utente' => TradeRepository::getUtente($id_user),
            'messaggio' => 'Risultati della ricerca per "' . $search . '":',
            'ricerca' => $search
        ]);
        exit(0);
    }
}

//nel caso si voglia fare il logout
if (isset($_GET['action'])){
    $action = $_GET['action'];
    //switch case
    if($action == 'logout'){
            Authenticator::logout();
            echo $template->render('login',["login_fallito" => false]);
            exit(0);
    }
}


echo $template->render('index', [
    'oggetti_disponibili' => TradeRepository::getOggettiDisponibili($id_user),
    'utente' => TradeRepository::getUtente($id_user),
    'messaggio' => 'Questi sono tutti gli oggetti disponibili',
    'ricerca' => $ricerca
]);

