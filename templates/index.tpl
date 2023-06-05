<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $oggetti_disponibili
 * @var $utente
 * @var $messaggio
 * @var $ricerca
 */
?>




<?php
$login = true;
$logout = false;
if($utente != null){
    $login = false;
    $logout = true;
}

$this->layout('home', [
        'titolo' => 'Market',
        'home' => true,
        'oggetti' => $logout,
        'logout' => $logout,
        'vendita' => $logout,
        'comprati' => $logout,
        'search' => true,
        'pagename' => 'index.php',
        'sv' => $ricerca,
        'mr' => 'Cerca oggetti in vendita',
        'login' => $login,
        'corrente' => 'Home'
]);?>

<?php if($utente == null): ?>
    <h1 class="text-5xl font-bold text-center">Benvenut*</h1>
    <p class="max-w-screen-xl text-center">Per poter utilizzare il sito devi prima effettuare il <!--suppress HtmlUnknownTarget -->
        <a href="./login.php">login</a> o <!--suppress HtmlUnknownTarget -->
        <a href="./registrazione.php">registrarti</a></p>
<?php else: ?>
<h1 class="text-5xl font-bold text-center">Benvenut* <?php echo $utente['nome'] ?></h1>
<p class="text-center">Il tuo saldo è di <?php echo $utente['gettoni'] ?> gettoni</p>
<?php endif; ?>

<div class="divider"></div>
<h1 class="text-3xl font-bold mb-4 text-center"><?php echo $messaggio ?></h1>

<?php if($oggetti_disponibili == null): ?>
    <p>Non ci sono oggetti disponibili</p>
<?php else: ?>

        <table class="table table-zebra table-lg">
            <thead>
            <tr>
                <th class="text-xl text-center">Nome</th>
                <th class="text-xl text-center">Categoria</th>
                <th class="text-xl text-center">Data dell'offerta</th>
                <th class="text-xl text-center">Contatta il venditore</th>
            </tr>
            </thead>
            <tbody>
            <?php foreach ($oggetti_disponibili as $oggetto): ?>
                <tr class="hover">
                    <td class="text-center"><?php echo $oggetto['nome'] ?></td>
                    <td class="text-center"><?php echo $oggetto['categoria'] ?></td>
                    <td class="text-center"><?php echo $oggetto['data_offerta'] ?></td>
                    <td class="text-center">
                        <!--suppress HtmlUnknownTarget -->
                        <form method="get" action="./oggetto.php">
                            <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id_oggetto'] ?>">
                            <button class="btn btn-sm"><?php echo $oggetto['nomeu']." ".$oggetto["cognomeu"] ?></i></button>
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>


<?php endif; ?>
