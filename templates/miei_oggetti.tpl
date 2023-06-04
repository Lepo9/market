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
    'oggetti' => false,
    'logout' => true,
    'vendita' => true,
    'comprati' => true,
    'search' => true,
    'pagename' => 'miei_oggetti.php',
    'sv' => $ricerca
]);?>

<h4>Benvenut* <?php echo $utente['nome'] ?></h4>
<p>Il tuo saldo è di <?php echo $utente['gettoni'] ?> gettoni</p>

<div class="divider"></div>
<h3><?php echo $messaggio ?></h3>

<?php if($oggetti == null): ?>
    <p>Non hai mai venduto un oggetto. Fai la prima vendita <a href="./vendita.php">qui</a></p>
<?php else: ?>
<table class="table table-striped table-hover">
    <thead>
    <tr>
        <th>Nome</th>
        <th>Categoria</th>
        <th>Data dell'offerta</th>
        <th>Stato</th>
        <th>Visualizza</th>
        <th>Modifica</th>
        <th>Elimina</th>
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
                <form method="get" action="./mio_oggetto.php" class="text-center">
                    <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id_oggetto'] ?>">
                    <button class="btn btn-sm"><i class="icon icon-message"></i></button>
                </form>
            </td>
            <?php if ($oggetto['data_scambio'] == null): ?>
                <td>
                    <form method="post" action="./vendita.php" class="text-center">
                        <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id_oggetto'] ?>">
                        <button class="btn btn-sm"><i class="icon icon-edit text-warning"></i></button>
                    </form>
                </td>
                <td>
                    <form method="post" action="./action.php" class="text-center">
                        <input type="hidden" name="action" value="elimina_oggetto">
                        <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id_oggetto'] ?>">
                        <button class="btn btn-sm"><i class="icon icon-delete text-error"></i></button>
                    </form>
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

