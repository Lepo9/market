<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $oggetti_disponibili
 * @var $utente
 */
?>

<?php $this->layout('home', [
        'titolo' => 'Market',
        'home' => false,
        'oggetti' => true,
        'logout' => true,
        'vendita' => true,
        'comprati' => true
]);?>

<h4>Benvenut* <?php echo $utente['nome'] ?></h4>
<p>Il tuo saldo è di <?php echo $utente['gettoni'] ?> gettoni</p>

<div class="divider"></div>
<h3>Questi sono tutti gli oggetti disponibili</h3>
<table class="table table-striped table-hover">
    <thead>
    <tr>
        <th>Nome</th>
        <th>Categoria</th>
        <th>Data dell'offerta</th>
        <th>Offerente</th>
        <th>Contatta il venditore</th>
    </tr>
    </thead>
    <tbody>
    <?php foreach ($oggetti_disponibili as $oggetto): ?>
        <tr>
            <td><?php echo $oggetto['nome'] ?></td>
            <td><?php echo $oggetto['categoria'] ?></td>
            <td><?php echo $oggetto['data_offerta'] ?></td>
            <td><?php echo $oggetto['nomeu']." ".$oggetto["cognomeu"] ?></td>
            <td>
                <form method="get" action="./oggetto.php">
                    <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id_oggetto'] ?>">
                    <button class="btn btn-sm"><i class="icon icon-message"></i></button>
                </form>
            </td>
        </tr>
    <?php endforeach; ?>
    </tbody>
</table>

