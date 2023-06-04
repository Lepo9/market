<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $oggetto
 * @var $offerente
 * @var $utente
 * @var $messaggi
 */
?>

<?php $this->layout('home', [
    'titolo' => 'Oggetto comprato',
    'home' => true,
    'oggetti' => true,
    'logout' => true,
    'vendita' => true,
    'comprati' => true,
    'search' => true,
    'pagename' => 'index.php',
    'sv' => '',
]);?>



<div class="columns">
    <div class="column">
        <h1><?php echo $oggetto['nome'] ?></h1>
            <?php if ($oggetto['immagine'] != null): ?>
                <img src="<?php echo $oggetto['immagine'] ?>" alt="immagine dell'oggetto" class="img-responsive">
            <?php endif; ?>


    </div>
    <div class="divider-vert"></div>
    <div class="column">
        <h3 class="mt-2">Categoria: <?php echo $oggetto['categoria']?></h3>
        <p><?php echo $offerente['nome'] ?> <?php echo $offerente['cognome'] ?> ti ha venduto l'oggetto</p>
        <p>L'oggetto èra stato messo in vendita il <?php echo $oggetto['data_offerta'] ?></p>
        <p>L'acquisto è avvenuto il <?php echo $oggetto['data_scambio'] ?></p>
    </div>
</div>

<div class="divider mt-4"></div>

<?php if ($oggetto['descrizione'] != null): ?>
    <?php $righe =   explode("\n", $oggetto['descrizione'] ); ?>
    <h4>Descrizione</h4>
    <?php foreach ($righe as $riga): ?>
        <p><?php echo $riga ?></p>
    <?php endforeach; ?>
<?php endif; ?>

<div class="divider"></div>

<h5>Messaggi recenti</h5>
<?php if ($messaggi == null): ?>
    <p>Non ci sono messaggi...</p>
<?php else: ?>
    <?php foreach ($messaggi as $messaggio): ?>
        <div class="columns">
            <div class="column col-3">
                <p><?php echo $messaggio['data'] ?></p>

            </div>
            <div class="divider-vert"></div>
            <div class="column">

                <?php if ($messaggio['id_mittente'] == $utente['id']): ?>
                    <strong>Tu:</strong>
                <?php else: ?>
                    <strong><?php echo $offerente['nome'] ?>:</strong>
                <?php endif; ?>
                <?php $righe =   explode("\n", $messaggio['testo'] ); ?>
                <?php foreach ($righe as $riga): ?>
                    <p><?php echo $riga ?></p>
                <?php endforeach; ?>
            </div>
        </div>
    <?php endforeach; ?>
<?php endif; ?>
