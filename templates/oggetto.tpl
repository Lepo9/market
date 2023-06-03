<?php
/**
 * Questo commento serve solo a eliminare l'indicazione di errore
 * @var $oggetto
 * @var $acquirente
 * @var $utente
 * @var $chats
 */
?>

<?php $this->layout('home', [
    'titolo' => 'Oggetto',
    'home' => true,
    'oggetti' => true,
    'logout' => true,
    'vendita' => true
]);?>

<?php if($utente['id'] != $oggetto['id_offerente']): ?>
    <h1>AH! Furbetto! Non sei autorizzato a vedere questa pagina! IHIHIH!</h1>
<?php else: ?>


        <h1><?php echo $oggetto['nome'] ?></h1>
            <?php if ($oggetto['immagine'] != null): ?>
                <img src="<?php echo $oggetto['immagine'] ?>" alt="immagine dell'oggetto">
            <?php endif; ?>
        <h3>Categoria: <?php echo $oggetto['categoria']?></h3>

        <?php if ($acquirente != false): ?>
            <p>L'oggetto era stato messo in vendita il <?php echo $oggetto['data_offerta'] ?></p>
            <p>L'oggetto è stato comprato da <?php echo $acquirente['nome'] ?> <?php echo $acquirente['cognome'] ?> il <?php echo $oggetto['data_scambio'] ?></p>
        <?php else: ?>
            <p>L'oggetto è stato messo in vendita il <?php echo $oggetto['data_offerta'] ?></p>
            <p>Non è ancora stato venduto :(</p>
        <?php endif; ?>




<?php if ($oggetto['descrizione'] != null): ?>
    <p><?php echo $oggetto['descrizione']?></p>
<?php endif; ?>

<div class="divider"></div>

<h3>Questi sono i messaggi che i vari utenti ti hanno scritto</h3>

<?php if ($chats != false): ?>
    <?php foreach ($chats as $chat): ?>
            <h5>Chat con <?php echo $chat['nome'] ?> <?php echo $chat['cognome'] ?></h5>

            <?php foreach ($chat['messaggi'] as $messaggio): ?>
                <div class="columns">
                    <div class="column col-3">
                        <p><?php echo $messaggio['data'] ?></p>
                    </div>
                    <div class="divider-vert"></div>
                    <div class="column">
                        <?php if ($messaggio['id_mittente'] == $utente['id']): ?>
                            <strong>Tu:</strong>
                        <?php else: ?>
                            <strong><?php echo $chat['nome'] ?>:</strong>
                        <?php endif; ?>
                        <p><?php echo $messaggio['testo'] ?></p>
                    </div>
                </div>
            <?php endforeach; ?>
            <div class="divider"></div>
    <?php endforeach; ?>
<?php else: ?>
    <p>Non hai ricevuto messaggi per questo oggetto</p>
    <?php endif; ?>
<?php endif; ?>