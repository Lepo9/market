<?php

require_once 'vendor/autoload.php';
require_once 'conf/config.php';

use League\Plates\Engine;
use Model\TradeRepository;
use Util\Authenticator;

$template = new Engine('templates','tpl');

//Routing di tutte le pagine
//C'è solo questa pagina


//Fa partire il processo di autenticazione
$user = Authenticator::getUser();
if ($user == null){
    echo $template->render('login');
    exit(0);
}

//ottengo l'id dell'utente e il suo nome
$id_user = $user['user_id'];
$displayed_name = $user['nome'];

//nel caso si voglia fare il logout
if (isset($_GET['action'])){
    if (($_GET['action']) == 'logout') {
        Authenticator::logout();
        echo $template->render('login');
        exit(0);
    }
}


//quando un oggetto viene aggiornato
if (isset($POST['id_object'])){

}



//Gestisce l'aggiunta di un nuovo impegno
if (isset($_POST['impegno'])){
    $impegno = $_POST['impegno'];
    $importanza = $_POST['importanza'];
    if (isset($_POST['id'])){
        $id = $_POST['id'];
        if (TradeRepository::owned($id, $id_user))
            TradeRepository::updateTesto($impegno, $importanza, $id);
    }
    else if ($impegno != '') {
        TradeRepository::add($impegno, $importanza, $id_user);
    }
}

$testo = "";
$importanza = -1;
$id = null;

if (isset($_GET['action'])){
    $azione = $_GET['action'];
    $id = $_GET['id'];
    //Se l'id dell'impegno è corretto può eseguire l'azione, altrimenti no
    if (TradeRepository::owned($id, $id_user)) {
        //Gestisce il completamento di un impegno
        if ($azione == 'completa') {
            TradeRepository::completa($id);
        } //Gestisce il recupero del testo dell'impegno da modificare
        else if ($azione == 'modifica') {
            $impegno = TradeRepository::getImpegno($id);
            $testo = $impegno['testo'];
            $importanza = $impegno['importanza'];
        } //Gestisce l'eliminazione
        else if ($azione == 'elimina') {
            TradeRepository::delete($id);
        }
    }
}

$todos = TradeRepository::listAllByUser($user['user_id']);

echo $template->render('crud', [
    'todos' => $todos,
    'testo' => $testo,
    'importanza' => $importanza,
    'id' => $id,
    'displayed_name' => $displayed_name
]);