<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $oggetti
 * @var $utente
 */
?>

<?php $this->layout('home', [
    'titolo' => 'I miei oggetti',
    'home' => true,
    'oggetti' => false,
    'logout' => true,
]);?>

<h4>Benvenut* <?php echo $utente['nome'] ?></h4>
<p>Il tuo saldo è di <?php echo $utente['gettoni'] ?> gettoni</p>

<div class="divider"></div>
<h3>Questi sono i tuoi oggetti in vendita</h3>
<table class="table table-striped table-hover">
    <thead>
    <tr>
        <th>Nome</th>
        <th>Categoria</th>
        <th>Data dell'offerta</th>
        <th>Stato</th>
        <th>Visualizza oggetto</th>
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
                <form method="get" action="./mio_oggetto.php">
                    <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id_oggetto'] ?>">
                    <button class="btn btn-sm"><i class="icon icon-message"></i></button>
                </form>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>

