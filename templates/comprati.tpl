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
    'titolo' => 'Oggetti che ho comprato',
    'home' => true,
    'oggetti' => true,
    'logout' => true,
    'vendita' => true,
    'comprati' => false,
    'search' => true,
    'pagename' => 'comprati.php',
    'sv' => $ricerca,
    'mr' => 'Cerca tra i comprati'

]);
?>

<h4>Benvenut* <?php echo $utente['nome'] ?></h4>

<div class="divider"></div>
<h3><?php echo $messaggio ?></h3>

<?php if ($oggetti == null): ?>
    <p>Non hai ancora comprato nessun oggetto...</p>
<?php else: ?>
<table class="table table-striped table-hover">
    <thead>
    <tr>
        <th>Nome</th>
        <th>Categoria</th>
        <th>Data dell'acquisto'</th>
        <th>Visualizza</th>
    </tr>
    </thead>
    <tbody>
    <?php foreach ($oggetti as $oggetto): ?>
        <tr>
            <td><?php echo $oggetto['nome'] ?></td>
            <td><?php echo $oggetto['categoria'] ?></td>
            <td><?php echo $oggetto['data_scambio'] ?></td>
            <td>
                <form method="get" action="./oggetto_scambiato.php">
                    <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id'] ?>">
                    <button class="btn btn-sm"><i class="icon icon-message"></i></button>
                </form>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>
<?php endif; ?>
