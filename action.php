<?php
//in questo file vengono gestite le azioni che l'utente può compiere
//vengono infatti intercettate tutte le post
//e in base al valore di action si esegue una determinata azione

require_once 'vendor/autoload.php';
require_once 'conf/config.php';

use League\Plates\Engine;
use Model\TradeRepository;
use Util\Authenticator;
use Model\UserRepository;


$template = new Engine('templates', 'tpl');




if(!isset($_POST['action'])){
    header('Location: index.php');
    exit(0);
}

$action = $_POST['action'];


if($action == 'registrazione'){
    $nome = $_POST['nome'];
    $cognome = $_POST['cognome'];
    $email = $_POST['e-mail'];
    $password1 = $_POST['password1'];
    $password2 = $_POST['password2'];

    if($password1 != $password2){
        header('Location: registrazione.php?errore=1');
        exit(0);
    }

    if(UserRepository::emailInUso($email)){
        header('Location: registrazione.php?errore=2');
        exit(0);
    }

    $esito = UserRepository::newUtente($nome, $cognome, $email, $password1);
    var_dump($esito);
    header('Location: index.php');
    exit(0);
}


$user = Authenticator::getUser();
if (!isset($user['user_id'])) {
    $login_fallito = $user;
    header('Location: index.php');
    exit(0);
}
$id_user = $user['user_id'];

if($action == 'compra'){

    if(TradeRepository::canBuy($id_user)){
        TradeRepository::buyOggetto($_POST['id_oggetto'], $id_user);
    }
    header('Location: index.php');
    exit(0);
}

if($action == 'messaggio'){
    TradeRepository::newMessaggio($id_user, $_POST['id_destinatario'], $_POST['testo'], $_POST['id_oggetto']);
    header('Location: '.$_POST['pagina'].'?id_oggetto='.$_POST['id_oggetto']);
    exit(0);
}

if($action == 'elimina_oggetto'){
    TradeRepository::deleteOggetto($_POST['id_oggetto']);
    header('Location: miei_oggetti.php');
    exit(0);
}



header('Location: index.php');
exit(0);

