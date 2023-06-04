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
    'vendita' => true,
    'comprati' => true,
    'search' => true,
    'pagename' => 'index.php',
    'sv' => '',
    'mr' => 'Cerca oggetti in vendita'
]);?>

<?php if($utente['id'] != $oggetto['id_offerente']): ?>
    <h1>AH! Furbetto! Non sei autorizzato a vedere questa pagina! IHIHIH!</h1>
<?php else: ?>


        <h1><?php echo $oggetto['nome'] ?></h1>
        <div class="columns">
            <?php if ($oggetto['immagine'] != null): ?>
            <div class="column col-6">
                <img src="<?php echo $oggetto['immagine'] ?>" alt="immagine dell'oggetto" class="img-responsive">
            </div>
            <?php endif; ?>
        <div class="column col-6">
        <h3>Categoria: <?php echo $oggetto['categoria']?></h3>

        <?php if ($acquirente != false): ?>
            <p>L'oggetto era stato messo in vendita il <?php echo $oggetto['data_offerta'] ?></p>
            <p>L'oggetto è stato comprato da <?php echo $acquirente['nome'] ?> <?php echo $acquirente['cognome'] ?> il <?php echo $oggetto['data_scambio'] ?></p>
        <?php else: ?>
            <p>L'oggetto è stato messo in vendita il <?php echo $oggetto['data_offerta'] ?></p>
            <p>Non è ancora stato venduto :(</p>
        <?php endif; ?>
        </div>
        </div>



<?php if ($oggetto['descrizione'] != null): ?>
    <div class="divider m-4"></div>
    <?php $righe =   explode("\n", $oggetto['descrizione'] ); ?>
    <h4>Descrizione</h4>
    <?php foreach ($righe as $riga): ?>
        <p><?php echo $riga ?></p>
    <?php endforeach; ?>
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

                        <?php $righe =   explode("\n", $messaggio['testo'] ); ?>
                        <?php foreach ($righe as $riga): ?>
                            <p><?php echo $riga ?></p>
                        <?php endforeach; ?>

                    </div>
                </div>
            <?php endforeach; ?>
            <?php if ($oggetto['data_scambio'] != null): ?>
                <p>Non puoi più rispondere a questa chat, l'oggetto è stato venduto</p>
            <?php else: ?>
            <form action="./action.php" method="post">
                <div class="form-group">
                    <input type="hidden" name="action" value="messaggio">
                    <input type="hidden" name="pagina" value="mio_oggetto.php">
                    <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id'] ?>">
                    <input type="hidden" name="id_destinatario" value="<?php echo $chat['id'] ?>">
                    <label class="form-label" for="input-example-1">Rispondi a <?= $chat['nome'] ?></label>
                    <textarea class="form-input" id="input-example-3" placeholder="Scrivi un messaggio" name="testo" rows="2"></textarea>
                    <button class="btn">Invia!</button>
                </div>
            </form>
            <?php endif; ?>
            <div class="divider"></div>
    <?php endforeach; ?>
<?php else: ?>
    <p>Non hai ricevuto messaggi per questo oggetto</p>
    <?php endif; ?>
<?php endif; ?>