<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $oggetto
 * @var $acquirente
 * @var $utente
 */
?>

<?php $this->layout('home', ['titolo' => 'Oggetto']);?>



        <h1><?php echo $oggetto['nome'] ?></h1>
            <?php if ($oggetto['immagine'] != null): ?>
                <img src="<?php echo $oggetto['immagine'] ?>" alt="immagine dell'oggetto">
            <?php endif; ?>
        <h3>Categoria: <?php echo $oggetto['categoria']?></h3>

        <?php if ($acquirente != false): ?>
            <p>L'oggetto era stato messo in vendita il <?php echo $oggetto['data_offerta'] ?></p>
            <p>L'oggetto è stato comprato da <?php echo $acquirente['nome'] ?> il <?php echo $oggetto['data_scambio'] ?></p>
        <?php else: ?>
            <p>L'oggetto è stato messo in vendita il <?php echo $oggetto['data_offerta'] ?></p>
            <p>Non è ancora stato venduto :(</p>
        <?php endif; ?>



<?php if ($oggetto['descrizione'] != null): ?>
    <p><?php echo $oggetto['descrizione']?></p>
<?php endif; ?>

<div class="divider"></div>

