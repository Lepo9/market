<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $oggetti
 * @var $utente
 * @var $ricerca
 * @var $messaggio
 */
?>

<?php $this->layout('home', [
    'titolo' => 'I miei oggetti',
    'home' => true,
    'oggetti' => true,
    'logout' => true,
    'vendita' => true,
    'comprati' => true,
    'search' => true,
    'pagename' => 'miei_oggetti.php',
    'sv' => $ricerca,
    'mr' => 'Cerca tra i tuoi oggetti',
    'corrente' => 'I miei oggetti in vendita'
]);?>

<h1 class="text-5xl font-bold text-center">Benvenut* <?php echo $utente['nome'] ?></h1>
<p class="text-center">Il tuo saldo è di <?php echo $utente['gettoni'] ?> gettoni</p>

<div class="divider"></div>
<h1 class="text-3xl font-bold mb-4 text-center"><?php echo $messaggio ?></h1>
<?php if($oggetti == null): ?>
    <p>Non hai mai venduto un oggetto. Fai la prima vendita <!--suppress HtmlUnknownTarget -->
        <a href="./vendita.php">qui</a></p>
<?php else: ?>
    <table class="table table-zebra table-lg">
    <thead>
    <tr>
        <th class="text-xl text-center">Nome</th>
        <th class="text-xl text-center">Categoria</th>
        <th class="text-xl text-center">Data dell'offerta</th>
        <th class="text-xl text-center">Stato</th>
        <th class="text-xl text-center">Visualizza</th>
        <th class="text-xl text-center">Modifica</th>
        <th class="text-xl text-center">Elimina</th>
    </tr>
    </thead>
    <tbody>
    <?php foreach ($oggetti as $oggetto): ?>
        <tr>
            <td><?php echo $oggetto['nome'] ?></td>
            <td><?php echo $oggetto['categoria'] ?></td>
            <td><?php echo $oggetto['data_offerta'] ?></td>
            <td>
                <?php if($oggetto['data_scambio'] != null): ?>
                    <p>Scambiato</p>
                <?php else: ?>
                    <p>In vendita</p>
                <?php endif; ?>
            </td>
            <td>
                <!--suppress HtmlUnknownTarget -->
                <form method="get" action="./mio_oggetto.php" class="text-center">
                    <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id_oggetto'] ?>">
                    <label tabindex="0" class="btn btn-ghost btn-square mt-4">
                        <button class="w-10">
                            <!--suppress HtmlUnknownTarget -->
                            <img src="./icons/chat_ico.svg" alt=""/>
                        </button>
                    </label>
                </form>
            </td>
            <?php if ($oggetto['data_scambio'] == null): ?>
                <td>
                    <!--suppress HtmlUnknownTarget -->
                    <form method="post" action="./vendita.php" class="text-center">
                        <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id_oggetto'] ?>">
                        <label tabindex="0" class="btn btn-ghost btn-square mt-4">
                            <button class="w-10">
                                <!--suppress HtmlRequiredAltAttribute, HtmlUnknownTarget -->
                                <img src="./icons/edit_ico.svg" />
                            </button>
                        </label>
                    </form>
                </td>
                <td>
                    <!--suppress HtmlUnknownTarget -->
                    <form method="post" action="./action.php" class="text-center">
                        <input type="hidden" name="action" value="elimina_oggetto">
                        <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id_oggetto'] ?>">
                        <label tabindex="0" class="btn btn-ghost btn-square mt-4">
                            <button class="w-10">
                                <!--suppress HtmlUnknownTarget -->
                                <img src="./icons/delete_ico.svg"  alt=""/>
                            </button>
                        </label>                    </form>
                </td>
            <?php else: ?>
                <td></td>
                <td></td>
            <?php endif; ?>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php endif; ?>

