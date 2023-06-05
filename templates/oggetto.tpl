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
    'pagename' => 'miei_oggetti.php',
    'sv' => '',
    'mr' => 'Cerca tra i tuoi oggetti'
]);?>

<?php if($utente['id'] != $oggetto['id_offerente']): ?>
    <h1>AH! Furbetto! Non sei autorizzato a vedere questa pagina! IHIHIH!</h1>
<?php else: ?>

    <div class="flex w-full justify-center">

    <div class="card w-1/2 bg-base-100 shadow-xl">
        <?php if ($oggetto['immagine'] != null): ?>
            <figure><img src="<?php echo $oggetto['immagine'] ?>" alt="immagine dell'oggetto" /></figure>
        <?php endif; ?>
        <div class="card-body">
            <h1 class="card-title text-3xl font-bold"><?php echo $oggetto['nome'] ?></h1>
            <h3 class="text-2xl"><strong>Categoria:</strong> <?php echo $oggetto['categoria']?></h3>

            <?php if ($acquirente): ?>
                <p>L'oggetto era stato messo in vendita il <?php echo $oggetto['data_offerta'] ?></p>
                <p>L'oggetto è stato comprato da <?php echo $acquirente['nome'] ?> <?php echo $acquirente['cognome'] ?> il <?php echo $oggetto['data_scambio'] ?></p>
            <?php else: ?>
                <p>L'oggetto è stato messo in vendita il <?php echo $oggetto['data_offerta'] ?></p>
                <p>Non è ancora stato venduto :(</p>
            <?php endif; ?>

            <div class="divider"></div>
            <?php if ($oggetto['descrizione'] != null): ?>
                <?php $righe =   explode("\n", $oggetto['descrizione'] ); ?>
                <h3 class="text-2xl font-bold">Descrizione</strong></h3>
                <?php foreach ($righe as $riga): ?>
                    <p><?php echo $riga ?></p>
                <?php endforeach; ?>
            <?php endif; ?>

        </div>
    </div>


    <div class="divider divider-horizontal"></div>
    <div class="flex flex-col max-w-lg">

    <h1 class="text-3xl">Questi sono i messaggi che i vari utenti ti hanno scritto</h1>

    <?php if (!$chats): ?>
        <p>Non hai ricevuto messaggi per questo oggetto</p>
    <?php else: ?>
        <?php foreach ($chats as $chat): ?>
        <h3 class="text-xl mt-8 mb-4">Chat con <strong><?php echo $chat['nome'] ?> <?php echo $chat['cognome'] ?></strong></h3>

        <?php foreach ($chat['messaggi'] as $messaggio): ?>


                    <?php if ($messaggio['id_mittente'] == $utente['id']): ?>
                    <div class="chat chat-end">
                    <div class="chat-header">
                    Tu
                    <?php else: ?>
                    <div class="chat chat-start">
                    <div class="chat-header">
                    <?php echo $chat['nome'] ?>

                    <?php endif; ?>
                        <time class="text-xs opacity-50"><?php echo $messaggio['data'] ?></time>
                    </div>
                        <?php $righe =   explode("\n", $messaggio['testo'] ); ?>
                        <div class="chat-bubble">
                            <?php foreach ($righe as $riga): ?>
                                <?php echo $riga.'<br/>' ?>
                            <?php endforeach; ?>
                        </div>
                    </div>

        <?php endforeach; ?>

                        <?php if ($oggetto['data_scambio'] != null): ?>
                            <p>Non puoi più rispondere a questa chat, l'oggetto è stato venduto</p>
                        <?php else: ?>
                            <!--suppress HtmlUnknownTarget -->
                            <form action="./action.php" method="post" class="text-end">
                                <div class="form-group">
                                    <input type="hidden" name="action" value="messaggio">
                                    <input type="hidden" name="pagina" value="mio_oggetto.php">
                                    <input type="hidden" name="id_oggetto" value="<?php echo $oggetto['id'] ?>">
                                    <input type="hidden" name="id_destinatario" value="<?php echo $chat['id'] ?>">

                                    <div class="form-control">
                                        <label class="label">
                                            <span class="label-text">Rispondi a <?= $chat['nome'] ?></span>
                                        </label>
                                        <!--suppress HtmlFormInputWithoutLabel -->
                                        <textarea class="textarea textarea-bordered h-24" placeholder="Scrivi un messaggio" name="testo" rows="5"></textarea>
                                    </div>

                                    <button class="btn btn-info">Invia!</button>
                                </div>
                            </form>
                        <?php endif; ?>
                        <div class="divider"></div>



        <?php endforeach; ?>
        <?php endif; ?>



    </div>


    </div>
    </div>
    </div>




<?php endif; ?>