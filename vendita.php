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

if (isset($_POST['nome'])) {
    $nome = $_POST['nome'];
    $descrizione = null;
    if (isset($_POST['descrizione']))
        $descrizione = $_POST['descrizione'];
    $categoria = $_POST['categoria'];
    $immagine = null;
    if (isset($_FILES['immagine'])){
        $immagine = $_FILES['immagine'];
        $immagine = TradeRepository::uploadImage($immagine);
        //var_dump($immagine);
    }
    $errore = TradeRepository::newOggetto($id_user, $nome, $descrizione, $immagine, $categoria);
    if ($errore == null) {
        header('Location: index.php');
        exit(0);
    }

}


$categorie = TradeRepository::getCategorie();

echo $template->render('aggiungi', [
    'utente' => TradeRepository::getUtente($id_user),
    'categorie' => $categorie
]);
