<?php


require_once 'vendor/autoload.php';
require_once 'conf/config.php';

use League\Plates\Engine;
use Model\TradeRepository;
use Util\Authenticator;

$template = new Engine('templates','tpl');

$user = Authenticator::getUser();
if (!isset($user['user_id'])) {
    $login_fallito = $user;
    header('Location: index.php');
    exit(0);
}
$id_user = $user['user_id'];

$errore = "";
$messaggio = "";
$nome = "";
$descrizione = "";

if (isset($_POST['categoria'])) {

    $nome = $_POST['nome'];
    $descrizione = null;
    if (isset($_POST['descrizione']))
        $descrizione = $_POST['descrizione'];
    $categoria = $_POST['categoria'];
    if($categoria == 0){
        $errore = "Seleziona una categoria";
        $categorie = TradeRepository::getCategorie();

        echo $template->render('aggiungi', [
            'messaggio' => $messaggio,
            'errore' => $errore,
            'nome' => $nome,
            'descrizione' => $descrizione,
            'utente' => TradeRepository::getUtente($id_user),
            'categorie' => $categorie
        ]);
        exit(0);
    }
    $immagine = null;
    if (isset($_FILES['immagine'])){
        $immagine = $_FILES['immagine'];
        $immagine = TradeRepository::uploadImage($immagine);
        //var_dump($immagine);
    }
    $esito = TradeRepository::newOggetto($id_user, $nome, $descrizione, $immagine, $categoria);

    if ($esito) {
        $messaggio = "Oggetto caricato con successo! Vai in <a href=\"./miei_oggetti.php\">Oggetti in vendita</a> per vederlo";
    } else {
        $errore = "Errore durante il caricamento dell'oggetto";
    }

}


$categorie = TradeRepository::getCategorie();

echo $template->render('aggiungi', [
    'messaggio' => $messaggio,
    'errore' => "",
    'nome' => "",
    'descrizione' => "",
    'utente' => TradeRepository::getUtente($id_user),
    'categorie' => $categorie
]);
