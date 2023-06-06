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



if(isset($_POST['id_oggetto'])){
    $oggetto = TradeRepository::getRawOggetto($_POST['id_oggetto']);
    $nome = $oggetto['nome'];
    $descrizione = $oggetto['descrizione'];
    $categoria = $oggetto['id_categoria'];

    $categorie = TradeRepository::getCategorie();

    echo $template->render('aggiungi', [
        'id_oggetto' => $_POST['id_oggetto'],
        'messaggio' => "Se avevi già inserito un oggetto, verrà sovrascritto. L'immagine verrà mantenuta se non viene selezionata una nuova.",
        'errore' => "",
        'nome' => $nome,
        'descrizione' => $descrizione,
        'id_categoria' => $categoria,
        'utente' => TradeRepository::getUtente($id_user),
        'categorie' => $categorie
    ]);
    exit(0);
}



if(isset($_POST['id_oggetto_vecchio'])){
    $oggetto = TradeRepository::getRawOggetto($_POST['id_oggetto_vecchio']);
    $nome = $_POST['nome'];
    $descrizione = $oggetto['descrizione'];
    if (isset($_POST['descrizione']))
        $descrizione = $_POST['descrizione'];
    $categoria = $_POST['categoria'];
    $immagine = $oggetto['immagine'];
    if ($_FILES['immagine']['name'] != ""){
        $immagine = $_FILES['immagine'];
        var_dump($immagine);
        $immagine = TradeRepository::uploadImage($immagine);
    }
    TradeRepository::editOggetto($_POST['id_oggetto_vecchio'], $nome, $descrizione, $immagine, $categoria);
    header('Location: mio_oggetto.php?id_oggetto='.$_POST['id_oggetto_vecchio']);
    exit(0);
}

if (isset($_POST['nome'])) {
    $nome = $_POST['nome'];
    $descrizione = null;
    if (isset($_POST['descrizione']))
        $descrizione = $_POST['descrizione'];

    if(!isset($_POST['categoria'])){
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
    $categoria = $_POST['categoria'];
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
